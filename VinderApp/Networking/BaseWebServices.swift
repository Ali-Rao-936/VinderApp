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
            Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            }

            Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                // sucesss block
                switch response.result {
                case .success:
                    
                    if let value: AnyObject = response.result.value as AnyObject? {
                        if let statusCode = response.response?.statusCode as? Int {//value[enumForCodingKeys.status.rawValue] as? Int{
                            
                            if statusCode == 200{ //(statusCode  >= 200 && statusCode <= 299) || statusCode == 404 || statusCode == 400 {
                                DispatchQueue.main.async(execute: {
                                    do {
                                        let jsonResponse = try JSON.init(data: response.data!)
                                        //print("JSON RESPONSE: \(jsonResponse)")
                                    } catch {
                                        print("JSONSerialization error:", error)
                                    }
                                    success(response)
                                })
                            }else{
                                // Show alert on window level
                                if let errorObj = value["error"] as? [String:Any]{
                                    if let error = errorObj["messages"] as? [String]{
                                        print("error...webservice", error)
                                        
                                        CommonFxns.showAlertOnWindowlevel(message: error[0] , title: AlertMessages.ERROR_TITLE)
                                    }else if let error = errorObj["messages"] as? NSDictionary{
                                        print(error.allValues.first ?? "")
                                        if let errStr = error.allValues.first as? [String]{
                                            CommonFxns.showAlertOnWindowlevel(message: errStr[0], title: AlertMessages.ERROR_TITLE)
                                        }else{
                                            CommonFxns.showAlertOnWindowlevel(message: "Incompatible information", title: AlertMessages.ERROR_TITLE)
                                        }
                                    }else{
                                        CommonFxns.showAlertOnWindowlevel(message: "Incompatible information", title: AlertMessages.ERROR_TITLE)
                                    }
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
    
    func uploadInterestList(url: String, method : HTTPMethod, params: [String: String], header: HTTPHeaders?, onSuccess success: @escaping (DataResponse<Any>) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        //   let parameters = ["mobile": mobilenumberTextfield.text!]
        
        Alamofire.upload(multipartFormData: { (multiFormData) in
            for (key, value) in params {
                multiFormData.append(Data(value.utf8), withName: key)
            }
        }, to: url, method: method, headers:CommonFxns.getAuthenticationToken()){ (result) in
            switch result {
            case .success(let response, _, _):
                response.responseJSON { res in
                    print("response is :\(res)")
                    if let statusCode = res.response?.statusCode as? Int {//value[enumForCodingKeys.status.rawValue] as? Int{
                        
                        if statusCode == 200{ //(statusCode  >= 200 && statusCode <= 299) || statusCode == 404 || statusCode == 400 {
                            DispatchQueue.main.async(execute: {
                                success(res)
                            })
                        }else{
                            // Show alert on window level
                            if let value: AnyObject = res.result.value as AnyObject? {
                                if let errorObj = value["error"] as? [String:Any]{
                                    if let error = errorObj["messages"] as? [String]{
                                        print("error...webservice", error)
                                        
                                        CommonFxns.showAlertOnWindowlevel(message: error[0] , title: AlertMessages.ERROR_TITLE)
                                    }else if let error = errorObj["messages"] as? NSDictionary{
                                        print(error.allValues.first ?? "")
                                        if let errStr = error.allValues.first as? [String]{
                                            CommonFxns.showAlertOnWindowlevel(message: errStr[0], title: AlertMessages.ERROR_TITLE)
                                        }else{
                                            CommonFxns.showAlertOnWindowlevel(message: "Incompatible information", title: AlertMessages.ERROR_TITLE)
                                        }
                                    }else{
                                        CommonFxns.showAlertOnWindowlevel(message: "Incompatible information", title: AlertMessages.ERROR_TITLE)
                                    }
                                }
                                CommonFxns.dismissProgress()
                            }else{
                                CommonFxns.dismissProgress()
                            }
                        }
                    }
                }
                
            case .failure(let error):
                print("FAILURE RESPONSE: \(error.localizedDescription)")
                if error._code == NSURLErrorTimedOut{
                    CommonFxns.dismissProgress()
                }
                CommonFxns.dismissProgress()
                
            }
        }
    }
        
//        Alamofire.upload(multipartFormData: { (multiFormData) in
//            for (key, value) in parameters {
//                multiFormData.append(Data(value.utf8), withName: key)
//            }
//        }, to: registerApi).responseJSON { response in
//            switch response.result {
//            case .success(let JSON):
//                print("response is :\(response)")
//
//            case .failure(_):
//                print("fail")
//            }
//        }
 //   }
    
  
    public func uploadImageWithInfo(parameters: [String:Any]?, url: String, img: UIImage, method : Alamofire.HTTPMethod, header: HTTPHeaders?, onSuccess success: @escaping (DataResponse<Any>) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        let imgData = img.jpegData(compressionQuality: 0.2)!

        let timestamp = NSDate().timeIntervalSince1970 // just for some random name.
        

       Alamofire.upload(multipartFormData: { multipartFormData in
               multipartFormData.append(imgData, withName: "profile_img",fileName: "\(timestamp).jpg", mimeType: "image/jpg")
           if parameters != nil{
               for (key, value) in parameters! {
                   multipartFormData.append((value as AnyObject).data(using:String.Encoding.utf8.rawValue)!, withName: key)
                   } // Optional for extra parameters
           }

           },
                        to:url, method: method, headers:CommonFxns.getAuthenticationToken())
       { (result) in
           switch result {
           case .success(let upload, _, _):

               upload.uploadProgress(closure: { (progress) in
                   print("Upload Progress: \(progress.fractionCompleted)")
               })

               upload.responseJSON { response in
                   
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
    
    public func uploadEventImageWithInfo(parameters: [String:Any]?, url: String, img: UIImage, method : Alamofire.HTTPMethod, header: HTTPHeaders?, onSuccess success: @escaping (DataResponse<Any>) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        let imgData = img.jpegData(compressionQuality: 0.2)!

        print("url.....", url)
        let timestamp = NSDate().timeIntervalSince1970 // just for some random name.

       Alamofire.upload(multipartFormData: { multipartFormData in
               multipartFormData.append(imgData, withName: "banner",fileName: "\(timestamp).jpg", mimeType: "image/jpg")
           
           
           if parameters != nil{
               for (key, value) in parameters! {
                   
                   multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    print(key, value)
                } // Optional for extra parameters
           }

           },
                        to:url, method: method, headers:CommonFxns.getAuthenticationToken())
       { (result) in
           switch result {
           case .success(let upload, _, _):

               upload.uploadProgress(closure: { (progress) in
                   print("Upload Progress: \(progress.fractionCompleted)")
               })

               upload.responseJSON { response in
                   
                   if let value: AnyObject = response.result.value as AnyObject? {
                       if let statusCode = response.response?.statusCode as? Int { // value["statusCode"] as? Int{
                           
                           print("Status code.....", statusCode , value )
                           if (statusCode  >= 200 && statusCode <= 299){
                               DispatchQueue.main.async(execute: {
                                   do {
                                       let jsonResponse = try JSON.init(data: response.data!)
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
                   }else{
                       CommonFxns.showAlertOnWindowlevel(message: AlertMessages.CAST_ERROR, title: AlertMessages.ALERT_TITLE)
                   }
               }

           case .failure(let encodingError):
               print("FAILURE RESPONSE: \(encodingError.localizedDescription)")
           }
       }
    }
    
}

