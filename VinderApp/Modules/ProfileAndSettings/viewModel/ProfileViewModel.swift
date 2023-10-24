//
//  ProfileViewModel.swift
//  VinderApp
//
//  Created by iOS Dev on 19/10/2023.
//

import Foundation

class ProfileViewModel {
    
    private var apiService = APIService()
    
    private(set) var sportsList: UserSportsInterestList! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> ()) = {}
    
    init() {
        callFuncToGetUserSportsInterestList()
    }
    
    func callFuncToGetUserSportsInterestList() {
        self.apiService.request(UserSportsInterestModel.self, url: APIURL.SportsInterestList, httpMethod: HTTPMethodType.get) { (result : Result<UserSportsInterestModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.sportsList = result.response
                    //   print("RESPONSE---> \(String(describing: self.userList))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}
