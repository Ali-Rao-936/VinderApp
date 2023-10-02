//
//  UserDefaultsToStoreUserInfo.swift
//  VinderApp
//
//  Created by ios Dev on 22/09/2023.
//

import Foundation
import UIKit

class UserDefaultsToStoreUserInfo: NSObject {

    // Method to save userInfo(private and public key, userId, token) locally
    class func saveUserDataInUserDefaults(token: String, userId: Int, userDetails: [String: Any]){
        
        var userInfo = [String: Any]()
        
        userInfo = [USER_DEFAULT_token_Key: token,
                   USER_DEFAULT_userID_Key: userId,
                    USER_DEFAULT_userDetails_Key: userDetails]
        
        print("userDetails....", userDetails)
        
//        let dict = ["name": "dklsjldfkjsaf", "int" : 9, "sajkdhsakjd" : "dsfjkdsfhkjdshfksj"] as [String : Any]
        userDefault.setValue(token, forKey: USER_DEFAULT_token_Key)
        userDefault.set(userInfo, forKey: USER_DEFAULT_userInfo_Key)

        print("userInfo uu....", userId)
        print("token uu....", token)
    }
    
    class func getUserID()->Int{
        var userId:Int = 0
        if let userInfo = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]{
            let id = userInfo[USER_DEFAULT_userID_Key] as? Int
            userId = id ?? 0
        }
        return userId
    }
    
    class func getUser()-> UserModel?{
         if let userInfo = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]{
            if let dict = userInfo[USER_DEFAULT_userDetails_Key] as? [String:Any]{
                return UserModel(with: dict)
            }
        }
        return nil
    }
    
    class func updateUserDetails(user: [String: Any]){
        
        print("userr before....",user)

        var userObject = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]
        userObject?[USER_DEFAULT_userDetails_Key] = user
        
        userDefault.set(userObject, forKey: USER_DEFAULT_userInfo_Key)
        print("userr after....", UserDefaultsToStoreUserInfo.getUser())
    }
    
    
    
    
    
}
