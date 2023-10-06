//
//  ProfileAndSettingsWebServices.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Services

struct ProfileAndSettingsWebServices {
    
    func getUserProfileInfo(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.getProfileInfo.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken()
        print("header..", header)

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
    
    func updateProfileAPI(parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.updateProfile.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken()
        print("header..", header)

        Obj.baseServiceProvider(url: url, method: .post, params: parameters, header: header, onSuccess: { response in
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

    
    func updateSportsInterests(parameters: [Int], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.addSportsInterests.rawValue
        print("url..", url)
        print("parameters..", parameters)

        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken()
        print("header..", header)
        
        var dict = [String: Any]()

        for i in parameters.indices{
            
            print(parameters[i])
            print("sport_id[\(i)]")

            dict["sport_id[\(i)]"] = parameters[i]
        }
        print("dict...", dict)
        Obj.baseServiceProvider(url: url, method: .post, params: dict, header: header, onSuccess: { response in
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

    func getInterestsList(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.getAllInterestsList.rawValue
        print("url..", url)
        let Obj = BaseWebService()


        Obj.baseServiceProvider(url: url, method: .get, params: nil, header: nil, onSuccess: { response in
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
    
    func giveFeedback(params: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.rateApp.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        
        let header = CommonFxns.getAuthenticationToken()
        
        Obj.baseServiceProvider(url: url, method: .post, params: params, header: header, onSuccess: { response in
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
    
    func getStaticContent(subUrl: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + subUrl
        print("url..", url)
        let Obj = BaseWebService()
        
        let header = CommonFxns.getAuthenticationToken()
        
        Obj.baseServiceProvider(url: url, method: .get, params: nil, header: nil, onSuccess: { response in
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
    func uploadProfilePicture(image: UIImage, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.updateProfile.rawValue
        print("url..", url)
        let Obj = BaseWebService()

        Obj.uploadImageWithInfo(parameters: nil, url: url, img: image, method: .post, header: nil) { response in
            
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
            
        } onFailure: { error in
            print("error...", error?.localizedDescription.description ?? emptyStr)
        }

//        Obj.uploadImageWithInfo(url: url, img: image, method: .post, parameters: nil, header: nil, onSuccess: { response in
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
    }

}



