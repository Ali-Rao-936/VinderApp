//
//  UserViewModel.swift
//  VinderApp
//
//  Created by iOS Dev on 10/10/2023.
//

import Foundation

//struct Test {
//    
//    var id: Int
//    var dictionary: [String: Any] {
//            return ["id": id]
//        }
//     var nsDictionary: NSDictionary {
//            return dictionary as NSDictionary
//      }
//    
//    // calling Test(id: 2).dictionary
//}

class UserViewModel {
    
    private var apiService = APIService()
    
    private(set) var userList: UserList! {
        didSet {
            self.bindUserViewModelToController()
        }
    }

    private(set) var userLiked: LikedUser! {
        didSet {
            self.bindUserViewModelToController()
        }
    }
    
    private(set) var userDetail: UserDetailResponse! {
        didSet {
            self.bindUserViewModelToController()
        }
    }
    
    var bindUserViewModelToController : (() -> ()) = {}

    init(userType: UserType, userID: Int? = 0) {
        switch userType {
        case .allUsers:
            callFuncToGetUsers()
        case .likedUser:
            callFuncToLikeUser(userID ?? 0)
        case .nearUsers:
            callFuncToGetNearUsers()
        case .myMatchUsers:
            callFuncToGetMatchUsers()
        case .userDetail:
            callFuncToGetUserDetail(userID ?? 0)
        }
    }
    
    // API call to get All user list
    func callFuncToGetUsers() {
        self.apiService.request(UserListModel.self, url: APIURL.AllUserList + "?per_page=100", httpMethod: HTTPMethodType.get) { (result : Result<UserListModel,Error>) in
            
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
    
    // API call to post liked user
    func callFuncToLikeUser(_ likedUserID: Int) {
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
    
    // API call to get Near users
    func callFuncToGetNearUsers() {
        let queryParams = "?latitude=25.098028026793607&longitude=55.15621635330942&radius=60" //"?latitude=\(AppDelegate.shared.getCurrentLocation().0)&longitude=\(AppDelegate.shared.getCurrentLocation().1)&radius=60"
        self.apiService.request(UserListModel.self, url: APIURL.NearUsersList + queryParams, httpMethod: HTTPMethodType.get) { (result : Result<UserListModel,Error>) in
            
            DispatchQueue.main.async {
                CommonFxns.dismissProgress()
                switch result {
                case .success(let result): self.userList = result.response
                    print("RESPONSE---> \(String(describing: self.userList))")
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    // API call to get Matched Users
    func callFuncToGetMatchUsers() {
        self.apiService.request(UserListModel.self, url: APIURL.MatchUsersList, httpMethod: HTTPMethodType.get) { (result : Result<UserListModel,Error>) in
            
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
    
    // API call to Match Detail data
    func callFuncToGetUserDetail(_ userID: Int) {
        self.apiService.request(UserDetailModel.self, url: APIURL.AllUserList + "?id=\(userID)", httpMethod: HTTPMethodType.get) { (result : Result<UserDetailModel,Error>) in
            CommonFxns.dismissProgress()
        
            DispatchQueue.main.async {
                    switch result {
                    case .success(let result): self.userDetail = result.response
                        print("RESPONSE---> \(String(describing: self.userDetail))")
                    case .failure(let error): print(error.localizedDescription)
                    }
             }
        }
    }
}

// 103|enpPGBMUHTeHKg2fik3mPO6jCFiRA1GLSFxxq5BV26189296
//37.785834
// -122.406417
