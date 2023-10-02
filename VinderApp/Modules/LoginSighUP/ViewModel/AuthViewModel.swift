//
//  AuthViewModel.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//


import Foundation
import UIKit

class AuthViewModel {
    
    // MARK: - Properties
    
    private var loginUserResponse: [String: Any]? {
        didSet {
            guard let l = loginUserResponse else { return }
            self.didFinishFetch?(l)
        }
    }
    
    private var registerUserResponse: [String: Any]? {
        didSet {
            guard let r = registerUserResponse else { return }
            self.didFinishFetch?(r)
        }
    }
    
    private var forgotPasswordResponse: [String: Any]? {
        didSet {
            guard let f = forgotPasswordResponse else { return }
            self.didFinishFetch?(f)
        }
    }
    
    private var updatePasswordResponse: [String: Any]? {
        didSet {
            guard let u = updatePasswordResponse else { return }
            self.didFinishFetch?(u)
        }
    }
    
    private var logoutUserResponse: [String: Any]? {
        didSet {
            guard let l = logoutUserResponse else { return }
            self.didFinishFetch?(l)
        }
    }
    
    private var verifyOtpResponse: [String: Any]? {
        didSet {
            guard let v = verifyOtpResponse else { return }
            self.didFinishFetch?(v)
        }
    }
    
    private var deleteAccountResponse: [String: Any]? {
        didSet {
            guard let d = deleteAccountResponse else { return }
            self.didFinishFetch?(d)
        }
    }
    
    private var resendOtpResponse: [String: Any]? {
        didSet {
            guard let r = resendOtpResponse else { return }
            self.didFinishFetch?(r)
        }
    }
    
    
    private var apiService: AuthWebServices?

    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Constructor
    
    init(apiService: AuthWebServices) {
        self.apiService = apiService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (([String: Any]) -> ())?
    
    // MARK: - Network call
    
    func loginUserAPI(url: String, parameters: [String: Any]) {
    
        print("loginUserAPI....")
        self.apiService?.userAuthAPI(url: url, parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.loginUserResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func registerUserAPI(url: String, parameters: [String: Any]) {
    
        print("registerUserAPI....")
        self.apiService?.userAuthAPI(url: url, parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.registerUserResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func forgotPassword(url: String, parameters: [String: Any]) {
    
        print("forgotPassword....")
        self.apiService?.userAuthAPI(url: url, parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                
                self.forgotPasswordResponse = tempData["response"] as? [String : AnyObject]

            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func deleteAccountAPI() {
    
        print("deleteAccountAPI....")
        self.apiService?.deleteAccountAPI(completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                self.deleteAccountResponse = tempData["response"] as? [String : AnyObject]
//                if let response = tempData["response"] as? [String: Any]{
//                    self.deleteAccountResponse = response["data"] as? [String : AnyObject]
//                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }

    func updatePasswordAPI(parameters: [String: Any]) {
    
        print("updatePasswordAPI....")
        self.apiService?.updatePasswordAPI(parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.updatePasswordResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func verifyOtpAPI(token: String, parameters: [String: Any]) {
    
        print("verifyOtpAPI....")
        self.apiService?.verifyOtpAPI(token: token, parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.verifyOtpResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func resendOtpAPI(token: String) {
    
        print("resendOtpAPI....")
        self.apiService?.resendOtpAPI(token: token, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                self.resendOtpResponse = tempData["response"] as? [String : AnyObject]
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
    
    func logoutUserAPI() {
    
        print("logoutUserAPI....")
        self.apiService?.logoutAPI(completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                self.loginUserResponse = tempData["response"] as? [String : AnyObject]
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }

}


