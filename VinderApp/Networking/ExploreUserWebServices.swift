//
//  ExploreUserWebServices.swift
//  VinderApp
//
//  Created by ios Dev on 28/09/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Services

struct ExploreUserWebServices {
    
    func getUsersList( subUrl: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + subUrl
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken()
        
        Obj.baseServiceProvider(url: url, method: .get, params: nil, header: header, onSuccess: { response in
            guard response.result.error == nil else {
                
                DispatchQueue.main.async(execute: {
                    completion(nil, false, response.result.error.debugDescription)
                })
                return
            }
            print(response.result.description)
            let message = "";

            if let value: AnyObject = response.result.value as AnyObject? {
                let json = JSON(value)
                if let statusCode = response.response?.statusCode as? Int{//value[enumForCodingKeys.status.rawValue] as? Int{
                    
                    if statusCode == 200{ //statusCode  >= 200 && statusCode <= 299{
                        DispatchQueue.main.async(execute: {
                            completion(json.dictionaryObject as [String: AnyObject]?, true, message)
                        })
                    }else{
                        completion(json.dictionaryObject as [String: AnyObject]?, false, message)
                    }
                }else{
                    completion(nil, false, message)//response.result.error.debugDescription)
                }
            } else {
                completion(nil, false,message)// response.result.error.debugDescription)
            }
        }) { error in
            print("error...", error?.localizedDescription.description ?? emptyStr)
        }
    }
 
    
//    func getEventsList(subUrl: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
//
//        let url = baseUrl + subUrl
//        print("url..", url)
//
//        let Obj = BaseWebService()
//        let header = CommonFxns.getAuthenticationToken()
//        print("header..", header)
//
//        Obj.baseServiceProvider(url: url, method: .get, params: nil, header: header, onSuccess: { response in
//            guard response.result.error == nil else {
//
//                DispatchQueue.main.async(execute: {
//                    completion(nil, false, response.result.error.debugDescription)
//                })
//                return
//            }
//            print(response.result.description)
//            let message = "";
//
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let json = JSON(value)
//                if let statusCode = response.response?.statusCode as? Int{//value[enumForCodingKeys.status.rawValue] as? Int{
//
//                    if statusCode == 200{ //statusCode  >= 200 && statusCode <= 299{
//                        DispatchQueue.main.async(execute: {
//                            completion(json.dictionaryObject as [String: AnyObject]?, true, message)
//                        })
//                    }else{
//                        completion(json.dictionaryObject as [String: AnyObject]?, false, message)
//                    }
//                }else{
//                    completion(nil, false, message)//response.result.error.debugDescription)
//                }
//            } else {
//                completion(nil, false,message)// response.result.error.debugDescription)
//            }
//        }) { error in
//            print("error...", error?.localizedDescription.description ?? emptyStr)
//        }
//    }
//
//    func getEventsListWithPagination(subUrl: String, page: Int, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
//
//        let url = baseUrl + subUrl
//        print("url..", url)
//
//        let Obj = BaseWebService()
//        let header = CommonFxns.getAuthenticationToken()
//        print("header..", header)
//
//        Obj.baseServiceProvider(url: url, method: .get, params: nil, header: header, onSuccess: { response in
//            guard response.result.error == nil else {
//
//                DispatchQueue.main.async(execute: {
//                    completion(nil, false, response.result.error.debugDescription)
//                })
//                return
//            }
//            print(response.result.description)
//            let message = "";
//
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let json = JSON(value)
//                if let statusCode = response.response?.statusCode as? Int{//value[enumForCodingKeys.status.rawValue] as? Int{
//
//                    if statusCode == 200{ //statusCode  >= 200 && statusCode <= 299{
//                        DispatchQueue.main.async(execute: {
//                            completion(json.dictionaryObject as [String: AnyObject]?, true, message)
//                        })
//                    }else{
//                        completion(json.dictionaryObject as [String: AnyObject]?, false, message)
//                    }
//                }else{
//                    completion(nil, false, message)//response.result.error.debugDescription)
//                }
//            } else {
//                completion(nil, false,message)// response.result.error.debugDescription)
//            }
//        }) { error in
//            print("error...", error?.localizedDescription.description ?? emptyStr)
//        }
//    }

}




