//
//  Utility.swift
//  PlayersApp
//
//  Created by Shailja on 07/07/2023.
//

import Foundation
import UIKit

struct Constant {
    static let defaults = UserDefaults.standard
}

struct APIURL {
    static let BaseURL = "http://45.76.178.21:5070/api/"
    static let AllUserList = BaseURL + "listuser"
    static let LikedUser = BaseURL + "user/like"
    static let MatchUsersList = BaseURL + "user/mymatch/list"
    static let NearUsersList = BaseURL + "listuser"
    static let EventList = BaseURL + "event/list"
    static let HotEventList = BaseURL + "events/hot"
    static let UpcomingEventList = BaseURL + "events/upcoming"
    static let PastEventList = BaseURL + "events/past"
    static let JoinEvent = BaseURL + "user/events/join"
    static let AcceptedEventList = BaseURL + "user/event/attending/list"
    static let SportsInterestList = BaseURL + "user/sports/interest/list"
    static let CreateEvent = BaseURL + "user/events/add"
    static let InviteEvent = BaseURL + "user/events/invite"
}

class Utility {
    class func openDetails(url:String){
        if let url = URL(string: url){
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: { (success) in
                    
                })
            }
        }
    }
}


//class ManageLocalization {
//    
//    static var deviceLang = ""
//    class func changeLanguage(lanuageKey : String, OnComplete : @escaping (Bool)-> Void){
//        
//        
//        //   UserInfo.sharedInstance.saveWithKeyWithSingleItem(item: lanuageKey, key: self.DEFAULT_LANGUAGE)
//        Constant.defaults.setValue(lanuageKey, forKeyPath: "Language")
//        Constant.defaults.synchronize()
//        OnComplete(true)
//    }
//    
//    class func getdeviceLangBundle()-> Bundle{
//        // To get Language of device ...
//        var path : String = String()
//        
//        let bundleLang = ["en", "zh-Hans", "id", "vi-VN"]
//        
//        let strActiveLanguage = Constant.defaults.string(forKey: "Language") ?? "en"
//        if bundleLang.contains(strActiveLanguage) {
//            path = Bundle.main.path(forResource: strActiveLanguage, ofType: "lproj") ?? ""
//        }
//        else {
//            changeLanguage(lanuageKey: Language.English.rawValue) { (_) in }
//            path = Bundle.main.path(forResource: Language.English.rawValue, ofType: "lproj") ?? ""
//        }
//        return Bundle(path: path)!
//    }
//    
//    class func getLocalizedString(key:String)-> String {
//        return NSLocalizedString(key, tableName: nil, bundle: getdeviceLangBundle(), value: "", comment: "")
//    }
//}

extension UIViewController {

   
}

extension String {
    var wordList: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }
}

extension UITabBarController {
    
//    func changeTitleLanguage() {
//        self.tabBar.items?[0].title = ManageLocalization.getLocalizedString(key: "home")
//        self.tabBar.items?[1].title = ManageLocalization.getLocalizedString(key: "tour")
//        self.tabBar.items?[2].title = ManageLocalization.getLocalizedString(key: "stats")
//        self.tabBar.items?[3].title = ManageLocalization.getLocalizedString(key: "news")
//        self.tabBar.items?[4].title = ManageLocalization.getLocalizedString(key: "game_on")
//    }
}

