//
//  HomeViewModel.swift
//  VinderApp
//
//  Created by ios Dev on 28/09/2023.
//

import Foundation
import UIKit

class HomeViewModel {
    
    // MARK: - Properties
    
    private var getUsersListResponse: [[String: Any]]? {
        didSet {
            guard let g = getUsersListResponse else { return }
            self.didFinishFetchforList?(g)
        }
    }

    private var apiService: ExploreUserWebServices?

    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Constructor
    
    init(apiService: ExploreUserWebServices) {
        self.apiService = apiService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (([String: Any]) -> ())?
    var didFinishFetchforList: (([[String: Any]]) -> ())?

    // MARK: - Network call
    
    func getUsersList() {
    
        print("getUsersList....")
        self.apiService?.getUsersList(subUrl: enumForAPIsEndPoints.getUsersList.rawValue, completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(error.description)
                    return
                }
                print("tempData....", tempData)
                if let response = tempData["response"] as? [String: Any]{
                    self.getUsersListResponse = response["data"] as? [[String : AnyObject]]
                }
            } else {
                self.showAlertClosure?(error.description)
                print("error description....", error.description)
            }
        })
    }
  
}




