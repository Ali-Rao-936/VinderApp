//
//  ProfileAndSettingsViewModel.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import Foundation
import UIKit

class ProfileAndSettingsViewModel {
    
    // MARK: - Properties
    
    private var getProfileResponse: [String: Any]? {
        didSet {
            guard let g = getProfileResponse else { return }
            self.didFinishFetch?(g)
        }
    }
    
    private var updateProfileResponse: [String: Any]? {
        didSet {
            guard let u = updateProfileResponse else { return }
            self.didFinishFetch?(u)
        }
    }
    
    private var updateSportsInterestsResponse: [[String: Any]]? {
        didSet {
            guard let u = updateSportsInterestsResponse else { return }
            self.didFinishFetchforList?(u)
        }
    }
    
    private var getAllSportsInterestsResponse: [[String: Any]]? {
        didSet {
            guard let g = getAllSportsInterestsResponse else { return }
            self.didFinishFetchforList?(g)
        }
    }
    
    private var giveFeedbackResponse: [String: Any]? {
        didSet {
            guard let g = giveFeedbackResponse else { return }
            self.didFinishFetch?(g)
        }
    }
    
    private var getStaticContent: [String: Any]? {
        didSet {
            guard let g = getStaticContent else { return }
            self.didFinishFetch?(g)
        }
    }

    private var apiService: ProfileAndSettingsWebServices?

    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Constructor
    
    init(apiService: ProfileAndSettingsWebServices) {
        self.apiService = apiService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (([String: Any]) -> ())?
    var didFinishFetchforList: (([[String: Any]]) -> ())?

    // MARK: - Network call
    
    func getProfileInfo() {
    

        self.apiService?.getUserProfileInfo(completion: { data, succeeded, error in
            if succeeded {
           
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
           
                if let response = tempData["response"] as? [String: Any]{
                    self.getProfileResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
    
    func updateUserProfile(parameters: [String: Any]) {
    
   
        self.apiService?.updateProfileAPI(parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
           
                if let response = tempData["response"] as? [String: Any]{
                    self.updateProfileResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
    
    func updateSportsInterests(parameters: [Int]) {
    
        self.apiService?.updateSportsInterests(parameters: parameters, completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                if let response = tempData["response"] as? [String: Any]{
                    self.updateSportsInterestsResponse = response["data"] as? [[String : AnyObject]]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
    
    func uploadUserProfilePhoto(image: UIImage) {
    
        self.apiService?.uploadProfilePicture(image: image, completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                if let response = tempData["response"] as? [String: Any]{
                    self.updateProfileResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
    
    func getInterestsList() {
    
        self.apiService?.getInterestsList(completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                if let response = tempData["response"] as? [String: Any]{
                    self.getAllSportsInterestsResponse = response["data"] as? [[String : AnyObject]]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
    
    func giveFeedback(params: [String: Any]) {
        self.apiService?.giveFeedback(params: params, completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                if let response = tempData["response"] as? [String: Any]{
                    self.giveFeedbackResponse = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
    
    func getContent(subUrl: String) {
    
        self.apiService?.getStaticContent(subUrl: subUrl, completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                if let response = tempData["response"] as? [String: Any]{
                    self.getStaticContent = response["data"] as? [String : AnyObject]
                }
            } else {
                self.showAlertClosure?(error.description)
            }
        })
    }
}



