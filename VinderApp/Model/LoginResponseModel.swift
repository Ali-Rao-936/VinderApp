//
//  LoginResponseModel.swift
//  VinderApp
//
//  Created by ios Dev on 22/09/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UserModel: Codable {

    let userId: Int? // 1
    let name: String? // 2
    let email: String? // 3
    let phoneNumber: String? // 4
    let age: Int? // 5
    let gender: String? // 6
    let about: String? // 7
    let allowNotifications: Int? // 8
    let loginPurpose: String? // 9
    let locationId: Int? // 10
    let locationName: String? // 11
    let latitude: String? // 12
    let longitude: String? // 13
    let islocationTurnOn: Int? // 14

    let level: Int? // 15
    let profileImg: String? // 16
    let prefferedLanguage: String? // 17
    let isBlock: Int? // 18
    let isDeleted: Int? // 19
    let accessToken: String? // 20
    let signUpVia: String? // 21
    let loginVia: String? // 22

    let otpVerifed: Int?
    let sportsInterests: [SportsInterests]?
    
    init(userId: Int, name: String, email: String, about: String, age: Int, profileImg: String, phoneNumber: String, gender: String, allowNotifications: Int, loginPurpose: String, locationId: Int, locationName: String, latitude: String, longitude: String, islocationTurnOn: Int, level: Int,prefferedLanguage: String, isBlock: Int, isDeleted: Int, accessToken: String, signUpVia: String, loginVia: String, otpVerified: Int, sportsInterests: [SportsInterests
    ]){
        self.userId = userId
        self.name = name
        self.email = email
        self.about = about
        self.profileImg = profileImg
        self.age = age
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.allowNotifications = allowNotifications
        self.loginPurpose = loginPurpose
        self.locationId = locationId
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.islocationTurnOn = islocationTurnOn
        self.level = level
        self.prefferedLanguage = prefferedLanguage
        self.isBlock = isBlock
        self.isDeleted = isDeleted
        self.accessToken = accessToken
        self.signUpVia = signUpVia
        self.loginVia = loginVia
        self.otpVerifed = otpVerified
        self.sportsInterests = sportsInterests
    }

    init(with data: [String: Any]?) {

        self.userId = data?["id"] as? Int ?? zero
        self.name = data?["name"] as? String ?? emptyStr
        self.phoneNumber = data?["phone_number"] as? String ?? emptyStr
        self.email = data?["email"] as? String ?? emptyStr
        self.age = data?["age"] as? Int
        self.profileImg = data?["profile_img"] as? String ?? emptyStr
        self.gender = data?["gender"] as? String ?? emptyStr
        self.about = data?["about"] as? String ?? emptyStr
        self.isBlock = data?["block"] as? Int ?? zero
        self.allowNotifications = data?["allow_notification"] as? Int ?? zero
        self.loginPurpose = data?["login_purpose"] as? String ?? emptyStr
        self.prefferedLanguage = data?["preffered_language"] as? String ?? emptyStr
        self.loginVia = data?["login_via"] as? String ?? emptyStr
        self.signUpVia = data?["signup_via"] as? String ?? emptyStr
        self.locationId = data?["location_id"] as? Int
        self.locationName = data?["location_name"] as? String ?? emptyStr
        self.longitude = data?["longitude"] as? String ?? emptyStr
        self.latitude = data?["latitude"] as? String ?? emptyStr
        self.islocationTurnOn = data?["turn_on_location"] as? Int ?? zero
        self.level = data?["level"] as? Int ?? zero
        self.isDeleted = data?["deleted"] as? Int ?? zero
        self.accessToken = data?["access_token"] as? String ?? emptyStr
        self.otpVerifed = data?["otp_verified"] as? Int ?? zero
        
//        var updatedInterests = [SportInterests]()
//
//        let interests = data?["sports_interest"] as? [Any] ?? []
//        print(data?["sports_interest"] as? Any)
//
//        for value in interests{
//            
//            if let item = value as? [String: Any]{
//                if let interestImg = item["image_urls"] as? [String:Any]{
//                    let oneXImg = interestImg["1x"] as? String ?? ""
//                    let id = item["id"] as? Int ?? 0
//                    let name = item["name"] as? String ?? ""
//                    let active = item["active"] as? Int ?? 0
//                    let dict = SportInterests(id: id, name: name, imgUrl: oneXImg , active: active)
//                    updatedInterests.append(dict)
//                }
//            }
//
//        }
//        self.sportsInterests = updatedInterests
//        print(sportsInterests)
        
//        for item in interests{
//            let interest = SportInterests(id: <#T##Int#>, name: <#T##String#>, imgUrl: <#T##String#>, active: <#T##Int#>)(with: item)
//            updatedInterests.append(interest)
//        }
//        self.sportsInterests = updatedInterests
        self.sportsInterests = data?["sports_interest"] as? [SportsInterests] ?? []
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : userId ?? zero,
            "name": name ?? emptyStr,
            "phone_number": phoneNumber ?? emptyStr,
            "about": about ?? emptyStr,
            "email": email ?? emptyStr,
            "age": age ,
            "gender": gender ?? emptyStr,
            "block": isBlock ?? zero,
            "profile_img": profileImg ?? emptyStr,
            "allow_notification": allowNotifications ?? zero,
            "login_purpose": loginPurpose ?? emptyStr,
            "preffered_language": prefferedLanguage ?? emptyStr,
            "login_via": loginVia ?? emptyStr,
            "signup_via": signUpVia ?? emptyStr,
            "location_id": locationId ,
            "location_name": locationName ?? emptyStr,
            "longitude":longitude ?? emptyStr,
            "latitude": latitude ?? emptyStr,
            "turn_on_location": islocationTurnOn ?? zero,
            "level" : level ?? emptyStr,
            "deleted": isDeleted ?? zero,
            "access_token": accessToken ?? emptyStr,
            "otp_verified": otpVerifed ?? zero,
            "sports_interest" : sportsInterests ?? []
        ] as [String : Any]
    }
}

struct SportInterests: Codable {
    let id: Int? // 1
    let name: String? // 2
    let imgUrl: String? // 3
    let active: Int? // 4
    
    init(id: Int, name: String, imgUrl: String, active: Int){
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        self.active = active
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : id ?? zero,
            "name": name ?? emptyStr,
            "imgUrl": imgUrl ?? emptyStr,
            "active": active ?? zero
        ] as [String : Any]
    }
}


struct SportsInterests: Codable {
    let id: Int? // 1
    let name: String? // 2
    let imgUrls: ImageUrls? // 3
    let active: Int? // 4
    
    init(id: Int, name: String, imgUrls: ImageUrls, active: Int){
        self.id = id
        self.name = name
        self.imgUrls = imgUrls
        self.active = active
    }

    init(with data: [String: Any]?) {

        self.id = data?["id"] as? Int ?? zero
        self.name = data?["name"] as? String ?? emptyStr
        
        
        let urls = ImageUrls(with: data?["image_urls"] as? [String:Any])
        self.imgUrls = urls
        self.active = data?["active"] as? Int ?? zero
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : id ?? zero,
            "name": name ?? emptyStr,
            "image_urls": imgUrls ?? [:],
            "active": active ?? zero
        ] as [String : Any]
    }
}

struct ImageUrls: Codable {

    let oneX: String? // 1
    let twoX: String? // 2
    let threeX: String? // 3
    
    init(oneX: String, twoX: String, threeX: String){
        self.oneX = oneX
        self.twoX = twoX
        self.threeX = threeX
    }

    init(with data: [String: Any]?) {

        self.oneX = data?["1x"] as? String ?? emptyStr
        self.twoX = data?["2x"] as? String ?? emptyStr
        self.threeX = data?["3x"] as? String ?? emptyStr
    }
    
    func toAnyObject() -> Any {
        return [
            "1x" : oneX ?? emptyStr,
            "2x" : twoX ?? emptyStr,
            "3x" : threeX ?? emptyStr
        ] as [String : Any]
    }
}

//struct UsersList: Codable {
//
//    let userInfo: UserModel? // 1
////    let userEvents: [Even]? // 2
//    let userInterests: [SportsInterests]? // 2
//
//    init(userInfo: UserModel, userInterests: [SportsInterests]){
//        self.userInfo = userInfo
//        self.userInterests = userInterests
//    }
//
//    init(with data: [String: Any]?) {
//
//        self.userInterests = data?["1x"] as? String ?? emptyStr
//        self.twoX = data?["2x"] as? String ?? emptyStr
//        self.threeX = data?["3x"] as? String ?? emptyStr
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "1x" : oneX ?? emptyStr,
//            "2x" : twoX ?? emptyStr,
//            "3x" : threeX ?? emptyStr
//        ] as [String : Any]
//    }
//}
