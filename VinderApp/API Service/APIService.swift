//
//  APIService.swift
//  PlayersApp
//
//  Created by Shailja on 05/07/2023.
//

import Foundation
import UIKit

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
        var imageSize: Int = data.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
        self.data = data
    }
}

class APIService: NSObject {
    //  var language = Constant.defaults.string(forKey: "Language") ?? "en"
    typealias Parameters = [String : Any]
    let session = URLSession.shared
    
    func request<T: Decodable>(_ type: T.Type, url: String, httpMethod: HTTPMethodType ,params: Parameters? = [:], completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let header = CommonFxns.getAuthenticationToken()
        if ((params?.isEmpty) != true) {
            let bodyData = try? JSONSerialization.data(withJSONObject: params as Any,options: [])
            request.httpBody = bodyData
        }
        
        request.allHTTPHeaderFields = header
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let result = Result {
                try JSONDecoder().decode(T.self, from: data)
            }
            completion(result)
        }.resume()
    }
    
    func uploadImageToServer<T: Decodable>(url: String, parameters: [String:Any], image: [String:Any], completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let mediaImage = Media(withImage: image.values.first as! UIImage, forKey: image.keys.first ?? "") else { return }
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethodType.post.rawValue
        //create boundary
        let boundary = generateBoundary()
        //set content type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let token = "60|qhBeilhnNC15e19dG1TkdJIxxyXmEpEK48NZhHZEa927cd04"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //call createDataBody method
        print(parameters, mediaImage, boundary)
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
        session.dataTask(with: request) { (data, response, error) in
            print(data, response, error)
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let result = Result {
                try JSONDecoder().decode(T.self, from: data)
            }
            completion(result)
        }.resume()
    }
}

func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
    let lineBreak = "\r\n"
    var body = Data()
    if let parameters = params {
        
        for (key, value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\" \(key)\"\(lineBreak + lineBreak)")
            body.append("\(value as AnyObject)\(lineBreak)")
//            if value is NSArray {
//                if let array = value as? [Any] {
//                    for value in array {
//                        body.append("\(value)\(lineBreak)")
//                    }
//                }
//            }else {
//                body.append("\(value)\(lineBreak)")
//            }
        }
    }
    if let media = media {
        for photo in media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
    }
    body.append("--\(boundary)--\(lineBreak)")
    return body
}

func generateBoundary() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
            print("data======>>>",data)
        }
    }
}
