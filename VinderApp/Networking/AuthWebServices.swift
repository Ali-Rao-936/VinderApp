//
//  AuthWebServices.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Services

struct AuthWebServices {
    
    func userAuthAPI(url: String, parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let newUrl = baseUrl + url
        print("newurl..", newUrl)
        let Obj = BaseWebService()
        
        Obj.baseServiceProvider(url: newUrl, method: .post, params: parameters, header: nil, onSuccess: { response in
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

    func updatePasswordAPI(parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.changePassword.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken()
        
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
    
    func deleteAccountAPI(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.deleteAccount.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken()
        Obj.baseServiceProvider(url: url, method: .delete, params: nil, header: header, onSuccess: { response in
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
    
    func verifyOtpAPI(token: String, parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.verifyOtp.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken(authToken: token )
        print("headers...", header)
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
    
    func resendOtpAPI(token: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.resendOtp.rawValue
        print("url..", url)
        let Obj = BaseWebService()
        let header = CommonFxns.getAuthenticationToken(authToken: token)
        print("headers...", header)
        
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
    
    func logoutAPI(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + enumForAPIsEndPoints.logout.rawValue
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
                    }else if statusCode == 500{
                        CommonFxns.logOutAndPopToInitialVC()
                    }
                    else{
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
        
    func getAPI(url: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let newUrl = baseUrl + url
        print("newurl..", newUrl)
        let Obj = BaseWebService()
        
        Obj.baseServiceProvider(url: newUrl, method: .get, params: nil, header: nil, onSuccess: { response in
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
    
}


