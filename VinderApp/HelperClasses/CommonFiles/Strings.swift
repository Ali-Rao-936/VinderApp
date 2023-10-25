//
//  Strings.swift
//  PlayersApp
//
//  Created by meem on 20/07/2023.
//

import Foundation
import UIKit


let emptyStr = ""

// Common Strings

let successStr = "Success"
let okayStr = "Okay"
let cancelStr = "Cancel"
let forgotPasswordAPISuccessMsg = "Your Request has been submitted. Please check your Email and reset the password."
let profileUpdateSuccess = "Your profile has been updated successfully."
let passwordUpdateSuccess = "Your account password is updated successfully. please logout and login again."
let feedbackSubmittedSuccessfully = "Your feedback has been submitted sucessfully!"

let locationStr = "Location"
let addEventSuccess = "Event has been created successfully"

struct AlertMessages {
    
    static let ALERT_TITLE = "Alert"
    static let GENERAL_ERROR = "There was a problem, please check your internet connection and try again."
    static let ERROR_TITLE = "Error"
    static let CAST_ERROR = "Please try again later"
    static let ALERT_OK = "Okay"
    static let ALERT_CANCEL = "Cancel"
    static let ALERT_YES = "Yes"
    static let ALERT_NO = "No"
    static let ALL_DATA_REQUIRED = "Please enter all the required details."
    static let INVALID_EMAIL = "Please enter a valid Email."
    static let INVALID_PASSWORD = "Please enter a valid Password."
    static let PASSWORD_MISMATCH = "Password is not matched."

    static let LOGOUT_USER = "Are you sure you want to logout?"
    static let DELETE_ACCOUNT = "Are you sure you want to Delete your account?"
    static let PROFILE_INFO_UPDATED = "Your profile info has been updated successfully!"
    static let CHOOSE_INTERESTS = "Please choose some Interests to find more matches."
    static let CHOOSE_EVENT_IMAGE = "Please choose Event image for better understanding."

}

enum gender: String {
    case male = "male"
    case female = "female"
}


enum enumForSettingsTitles: String {
    
    case account = "Account"
//    case notifications = "Notifications"
    case contactUs = "Contact us"
    case others = "Others"
}

enum enumForSettingsOptions: String {
    
    case basicInfo = "Basic Info"
    case appSettings = "App Settings"
    case pushNotifications = "Push Notifications"
    case helpandSupport = "Help & supports"
    case privacyPolicy = "Privacy Policy"
    case termsAndConditions = "Terms & Conditions"
    case givefeedback = "Give Feedback"
    case rateUs = "Rate us"
}

enum enumForSettingsImages: String {
    
    case basicInfo = "basicInfoIcon"
    case appSettings = "appSettingsIcon"
    case pushNotifications = "notificationsIcon"
    case helpandSupport = "helpIcon"
    case privacyPolicy = "privacyPolicyIcon"
    case termsAndConditions = "termsIcon"
    case givefeedback = "giveFeedbackIcon"
    case rateUs = "rateUsIcon"
}


enum enumForLanguages: String{
    case english = "English"
    case chinese = "Standard Chinese"
    case vietnamese = "Vietnamese"
    case indonesian = "Indonesian"
}

enum enumForLanguageFlags: String{
    case english = "englishFlagImg"
    case chinese = "chinaFlagImg"
    case vietnamese = "vietnamFlagImg"
    case indonesian = "indonesiaFlagImg"
}

enum enumForAppSettingsOptions: String{
    case changePwd = "Change Password"
    case deleteaccount = "Delete Account"
}

enum enumForAppSettingsImages: String{
    case changePwd = "privacyPolicyIcon"
    case deleteaccount = "termsIcon"
}

enum enumForAppSettingsHeaderTitles: String{
    case languages = "Languages"
    case security = "Security"
}

enum UserType {
    case allUsers
    case nearUsers
    case myMatchUsers
    case likedUser
    case userDetail
}

enum EventType {
    case allEvents
    case hotEvents
    case upcoming
    case past
    case eventDetail
    case joinEvent
    case inviteEvent
    case acceptedEvent
}
