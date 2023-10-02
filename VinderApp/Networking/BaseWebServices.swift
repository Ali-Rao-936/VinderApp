//
//  BaseWebServices.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

public typealias Parameters = [String: Any]

struct Post: Codable {
    let response: String
}

class BaseWebService: NSObject {
    
    public func baseServiceProvider(url: String, method : HTTPMethod, params: Parameters?, header: HTTPHeaders?, onSuccess success: @escaping (DataResponse<Any>) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        print("BASE URL : \(url)")
        
//        let newUrl = baseUrl + url
        if CommonFxns.isInternetAvailable(){

            Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.httpBody, headers: header).responseJSON { response in
                // sucesss block
                switch response.result {
                case .success:
                    
                    if let value: AnyObject = response.result.value as AnyObject? {
                        if let statusCode = response.response?.statusCode as? Int {//value[enumForCodingKeys.status.rawValue] as? Int{
                            
                            if statusCode == 200{ //(statusCode  >= 200 && statusCode <= 299) || statusCode == 404 || statusCode == 400 {
                                DispatchQueue.main.async(execute: {
                                    do {
                                        let jsonResponse = try JSON.init(data: response.data!)
                                        print("JSON RESPONSE: \(jsonResponse)")
                                    } catch {
                                        print("JSONSerialization error:", error)
                                    }
                                    success(response)
                                })
                            }else{
                                // Show alert on window level
                                if let errorObj = value["error"] as? [String:Any]{
                                    let error = errorObj["messages"] as? [String]
                                    print("error...", error?[0])
                                    
                                    CommonFxns.showAlertOnWindowlevel(message: error?[0] ?? emptyStr, title: AlertMessages.ERROR_TITLE)
                                }
                                CommonFxns.dismissProgress()
                            }
                        }
                    }
                    break
                case .failure(let error):
                    print("FAILURE RESPONSE: \(error.localizedDescription)")
                    if error._code == NSURLErrorTimedOut{
                        CommonFxns.dismissProgress()
                    }
                    CommonFxns.dismissProgress()
                    
                }
            }
        }else{
            CommonFxns.dismissProgress()
        }
    }
    
  
    public func uploadImageWithInfo(url: String, img: UIImage, method : Alamofire.HTTPMethod, parameters: Parameters?, header: HTTPHeaders?, onSuccess success: @escaping (DataResponse<Any>) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        let imgData = img.jpegData(compressionQuality: 0.2)!

        let timestamp = NSDate().timeIntervalSince1970 // just for some random name.

       Alamofire.upload(multipartFormData: { multipartFormData in
               multipartFormData.append(imgData, withName: "profile_img",fileName: "\(timestamp).jpg", mimeType: "image/jpg")
//               for (key, value) in parameters {
//                       multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                   } //Optional for extra parameters
           },
                        to:url, method: method, headers:CommonFxns.getAuthenticationToken())
       { (result) in
           switch result {
           case .success(let upload, _, _):

               upload.uploadProgress(closure: { (progress) in
                   print("Upload Progress: \(progress.fractionCompleted)")
               })

               upload.responseJSON { response in
                    print("Upload response:  ", response.result.value)
                   
                   if let value: AnyObject = response.result.value as AnyObject? {
                       if let statusCode = response.response?.statusCode as? Int { // value["statusCode"] as? Int{
                           
                           print("Status code.....", statusCode , value )
                           if (statusCode  >= 200 && statusCode <= 299){
                               DispatchQueue.main.async(execute: {
                                   do {
                                       let jsonResponse = try JSON.init(data: response.data!)
                                       print("JSON RESPONSE: \(jsonResponse)")
                                   } catch {
                                       print("JSONSerialization error:", error)
                                   }
                                   success(response)
                               })
                           }else if statusCode == 401{
//                               CommonFxns.logOutAccount()
                           }else{
                               if let msg =  value["message"] as? String{
                                   CommonFxns.showAlertOnWindowlevel(message: msg, title: AlertMessages.ALERT_TITLE)
                                   print("message...", msg)
                               }
                           }
                       }
                   }
               }

           case .failure(let encodingError):
               print("FAILURE RESPONSE: \(encodingError.localizedDescription)")
           }
       }
    }
    
}

