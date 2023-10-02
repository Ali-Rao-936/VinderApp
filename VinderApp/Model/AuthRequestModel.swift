//
//  AuthRequestModel.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//

import Foundation

struct LoginRequest{
    var email: String?
    var password: String?
    var deviceId : String?
    var token: String?
    var deviceType: String = "iOS"
    
    init(email: String?, password: String?, deviceId: String?, token: String?){
        self.email = email
        self.password = password
        self.deviceId = deviceId
//        self.deviceType = deviceType
        self.token = token
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["email": email ?? emptyStr,
                                 "password": password ?? emptyStr,
                                 "token": password ?? emptyStr,
                                 "device_id": password ?? emptyStr,
                                 "device_type": deviceType]
        return dict
    }
}

struct RegisterRequest{
    var email: String?
    var password: String?
    var phoneNumber: String?
    var name: String?
    var deviceId : String?
    var token: String?
    var deviceType: String = "iOS"
    
    init(email: String?, password: String?, phoneNumber: String?, name: String?, deviceId: String?, token: String?){
        self.email = email
        self.password = password
        self.name = name
        self.deviceId = deviceId
        self.token = token
        self.phoneNumber = phoneNumber
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["email": email ?? emptyStr,
                                 "password": password ?? emptyStr,
                                 "phone_number": phoneNumber ?? emptyStr,
                                 "name": name ?? emptyStr,
                                 "token": password ?? emptyStr,
                                 "device_id": password ?? emptyStr,
                                 "device_type": deviceType]
        return dict
    }
}

struct UpdatePasswordRequest{
    var oldPassword: String?
    var newPassword: String?
    var confirmNewPassword : String?
    
    init(oldPassword: String?, newPassword: String?, confirmNewPassword: String?){
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmNewPassword = confirmNewPassword
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["old_password": oldPassword ?? emptyStr,
                                 "password": newPassword ?? emptyStr,
                                 "confirm_password": confirmNewPassword ?? emptyStr]
        return dict
    }
}

struct UpdateProfileRequest{
    var name: String?
    var gender : String?
    var phoneNumber : String?
    var loginPurpose: String?
    var age : Int?
    var locationId : Int?
    var about : String?
    var latitude : String?
    var longitude : String?
    
    init(name: String?, phoneNumber: String, loginPurpose: String, gender: String?, age: Int?, locationId: Int?, about: String?, latitude: String?, longitude: String?){
        self.name = name
        self.gender = gender
        self.about = about
        self.phoneNumber = phoneNumber
        self.age = age
        self.locationId = locationId
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["name": name ?? emptyStr,
                                 "about": about ?? emptyStr,
                                 "age": age ,
                                 "phone_number": phoneNumber ?? emptyStr,
                                 "login_purpose": loginPurpose ?? emptyStr,
                                 "location_id": locationId,
                                 "latitude": latitude ?? emptyStr,
                                 "longitude": longitude ?? emptyStr,
                                 "gender": gender ?? emptyStr,]
        return dict
    }
}

//struct UpdateProfileRequest{
//    var name: String?
//    var phoneNumber: String?
//    var gender : String?
//    var age : Int?
//    var locationId : Int?
//    var about : String?
//    var latitude : String?
//    var longitude : String?
//
//    init(name: String?, phoneNumber: String?, gender: String?, age: Int?, locationId: Int?, about: String?, latitude: String?, longitude: String?){
//        self.name = name
//        self.phoneNumber = phoneNumber
//        self.gender = gender
//        self.about = about
//        self.age = age
//        self.locationId = locationId
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//
//    func toDictionary()->[String:Any]{
//        let dict:[String:Any] = ["name": name ?? emptyStr,
//                                 "phone_no": phoneNumber ?? emptyStr,
//                                 "about": about ?? emptyStr,
//                                 "age": age ?? zero,
//                                 "location_id": locationId ?? nil,
//                                 "latitude": latitude ?? emptyStr,
//                                 "longitude": longitude ?? emptyStr,
//                                 "gender": gender ?? emptyStr,]
//        return dict
//    }
//}

struct VerifyOtpRequestModel : Codable {
    
    let otp : String?
    
    init(otp: String?){
        self.otp = otp
    }
    
    func toAnyObject() -> Any {
        return [
            "otp" : otp ?? emptyStr,
        ]
    }
}
