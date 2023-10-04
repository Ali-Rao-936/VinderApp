//
//  Constants.swift
//  PlayersApp
//
//  Created by meem on 20/07/2023.
//

import Foundation
import UIKit

// All the app costants using in code

// MARK: AppDelegate reference

let appDelegate = UIApplication.shared.delegate as!(AppDelegate)

// MARK: - UserDefault Constants

let userDefault = UserDefaults.standard

// User default Keys
// User info
let USER_DEFAULT_userInfo_Key = "userDefault_userInfo"
let USER_DEFAULT_firstTimeInstallApp_Key = "userDefault_firstTimeInstallApp"
let USER_DEFAULT_userID_Key = "userDefault_userID"
let USER_DEFAULT_userDetails_Key = "userDefault_userDetails"
let USER_DEFAULT_token_Key = "userDefault_token"

let USER_DEFAULT_imageUrl_Key = "userDefault_imageUrl"
let USER_DEFAULT_bio_Key = "userDefault_bio"

let USER_DEFAULT_sportsInterests_Key = "userDefault_sportsInterests"

// Other Settings
let USER_DEFAULT_isDarkMode_Key = "userDefault_isDarkMode"

// MARK: iPhone device's size Constants

// OS type
let iOSDeviceType = 1
let appVersion = 1.0

// MARK: - Others

// Text field length
let generalTextFieldLength = 40
let emailTextFieldLength = 60
let referralTextFieldLength = 12


// Screen sizes
let iPhone_8Plus_Height:CGFloat = 736
let iPhone_X_Height:CGFloat = 812
let iPhone_6_Height:CGFloat = 667
let iPhone_13Pro_MAX_Height:CGFloat = 926
let iPhone_11Pro_MAX_Height:CGFloat = 896

// Numbers
let defaultIntValue = 0
let zero = 0
let one = 1
let two = 2
let five = 5

// Colors

let primaryColor = UIColor(displayP3Red: 48/255, green: 140/255, blue: 87/255, alpha: 1)
let primaryColorWithAlpha = UIColor(displayP3Red: 48/255, green: 140/255, blue: 87/255, alpha: 0.2)

let lightGrayColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
let headingColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
let gradientBlackColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
let gradientWhiteColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
