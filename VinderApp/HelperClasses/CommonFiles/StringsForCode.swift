//
//  StringsForCode.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//

import Foundation
import UIKit
import SwiftUI

// All the strings using for app code
// MARK: - App mains

let appName = "Vinder" // App name
let baseUrl = "http://45.76.178.21:5070/api/"
let appDisplayName = "Vinder"

// MARK: - Common

// App display mode strings
let lightMode = "light"
let darkMode = "dark"

// MARK: - Api's keys

let userId_API_key = "userId"
let name_API_key = "name"

// contacts

let action_API_key = "action"
let status_API_key = "status"

// MARK: - Enum_StoryBoard

enum enumStoryBoard:String {
    case main = "Main"
}

// MARK: - NETWORK's Strings


// MARK: - End Points

extension String{
    var localized:String{
        return NSLocalizedString(self, comment: "")
    }
}

enum enumViewControllerIdentifier: String {
    case tabBarVC = "TabBarVC"
    case onboardingVC = "OnboardingVC"

    case homeVC = "HomeVC"
    case profileVC = "ProfileVC"
    case settingsVC = "SettingsVC"
    case AboutViewController = "AboutViewController"
    case appSettingsVC = "AppSettingsVC"
    case eventsVC = "EventsVC"
    case eventDetailsVC = "EventDetailsVC"
    case updateBasicProfileInfoVC = "UpdateBasicProfileInfoVC"
    case createAccountVC = "CreateAccountVC"
    case forgotPasswordVC = "ForgotPasswordVC"
    
    case chooseGenderVC = "ChooseGenderVC"
    case chooseInterestsVC = "ChooseInterestsVC"
    case completeProfileVC = "CompleteProfileVC"
    case loginVC = "LoginVC"
    case verifyOtpVC = "VerifyOtpVC"
    case updatePasswordVC = "UpdatePasswordVC"

    case userDetailVC = "UserDetailVC"
    case contentVC = "ContentVC"

    case exploreEventsVC = "ExploreEventsVC"
    case myEventsVC = "MyEventsVC"
    case createEventVC = "CreateEventVC"
    case acceptedEventVC = "AcceptedEventVC"
    case inviteFriendsVC = "InviteFriendsVC"
    case mapViewVC = "MapViewVC"
    case remarksVC = "RemarksVC"
    case initialVC = "InitialVC"
}

enum enumToGetStaticContent: String {
    
    case termsAndConditions = "TC"
    case aboutUs = "US"
    case support = "SC"
    case privacyPolicy = "PP"
}

enum enumForCodingKeys: String {
    case status = "status"
}

enum enumForLoginPurpose: String {
    case makeNewFriends = "makefriends"
    case explore = "explore"
}

// eventsTableView
enum enumForAPIsEndPoints: String {
    case login = "login"
    case register = "register"
    case socialLogin = "social/login"
    case forgotPassword = "forgetPass"
    case changePassword = "change-password"

    case getProfileInfo = "profile"
    case updateProfile = "user/profile/update"
    case getUsersList = "listuser" // /listuser?latitude=25.10472711211466&longitude=55.148879593356746&radius=60
    case verifyOtp = "verifyotp"
    case resendOtp = "resendotp"
    case logout = "logout"
    case addSportsInterests = "user/sports/interest/create"

    case deleteAccount = "delete/account"
    
    case homeAPI = "home"
    case getContent = "getContent?content_type="

    case getAllInterestsList = "sports/interest/list"

    // Interest
//    case removeInterest = "/user/sports/interest/create"
    case getUserInterestsList = "user/sports/interest/list"
    case rateApp = "user/rate/app"

    // Events
    case createEvent = "user/events/add"
    case joinEvent = "user/events/join"
    case eventsList = "event/list"
    case myEvents = "user/events/list?page=2&event_id=1" // user/events/list?page=2&event_id=1
    case upcomingEvents = "user/events/list?upcoming"
    case pastEvents = "user/events/list?past"
    
    // User Actions
    case likeUser = "user/like"
    case myMatch = "user/mymatch/list" //?latitude=25.10472711211466&longitude=55.148879593356746&radius=60"
}

