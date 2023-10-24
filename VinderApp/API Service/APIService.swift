//
//  APIService.swift
//  PlayersApp
//
//  Created by Shailja on 05/07/2023.
//

import Foundation

class APIService: NSObject {
    var language = Constant.defaults.string(forKey: "Language") ?? "en"
    typealias Parameters = [String : Any]

    func get<T: Decodable>(_ type: T.Type, url: String, body: Parameters? = [:], completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        
        if ((body?.isEmpty) != true) {
            request.httpMethod = "POST"
            let bodyData = try? JSONSerialization.data(withJSONObject: body as Any,options: [])
            request.httpBody = bodyData
           
        }else {
            if language == "zh-Hans" {
                language = "zh"
            }
            request.setValue(language, forHTTPHeaderField: "lang")
            request.httpMethod = "GET"
        }
    
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data, error == nil else {
             //   print(error?.localizedDescription ?? "No data")
                return
            }
            
            let result = Result {
                // You know you can call `decode` with it because it's Decodable
                try JSONDecoder().decode(T.self, from: data)
            }
            completion(result)
        }.resume()
    }
}
