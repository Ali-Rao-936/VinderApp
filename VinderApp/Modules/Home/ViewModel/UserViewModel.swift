//
//  UserViewModel.swift
//  VinderApp
//
//  Created by iOS Dev on 10/10/2023.
//

import Foundation

class UserViewModel {
    
    private var apiService = APIService()
    var likedUserID = Int()
    
    private(set) var userList : UserList! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    private(set) var userLiked : LikedUser! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> ()) = {}
    
    init() {
        callFuncToGetUserList()
    }
    
    init(id: Int) {
        self.likedUserID = id
        callFuncToLikeUser()
    }
    
    // API call to Match Detail data
    func callFuncToGetUserList() {
        self.apiService.request(UserListModel.self, url: APIURL.UserList, httpMethod: HTTPMethodType.get) { (result : Result<UserListModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.userList = result.response
                 //   print("RESPONSE---> \(String(describing: self.userList))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    func callFuncToLikeUser() {
        let params = ["liked_to": likedUserID]
        self.apiService.request(LikedUserModel.self, url: APIURL.LikedUser, httpMethod: HTTPMethodType.post, params: params) { (result : Result<LikedUserModel,Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result): self.userLiked = result.response
                    print("RESPONSE---> \(String(describing: self.userLiked))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
}
