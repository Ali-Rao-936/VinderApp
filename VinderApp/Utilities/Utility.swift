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
    static let BaseURL = "https://libertysports.xyz/app8/api/v1/"
    static let HistoryBaseURL = "https://libertysports.xyz/tgsh/"
    static let MidURL = "app8/api/v1/sportscore/data/"
    static let MatchList = BaseURL + "sportscore/data/match"
    static let TournamentList = HistoryBaseURL + "worldcups.php"
    // "http://192.168.2.91/history/worldcups.php"
    static let NewsList = BaseURL + "news/data"
    static let ManagerList = BaseURL + "sportscore/data/manager"
    static let SeasonList = BaseURL + "sportscore/data/season"
    static let TeamList = BaseURL + "sportscore/data/team"
    static let LeagueList = BaseURL + "sportscore/data/league"
    static let BannerBaseURL = "https://api996.com/"
    static let BannerList = BannerBaseURL + "api/v1/banner/com.tennis.sports"
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


class ManageLocalization {
    
    static var deviceLang = ""
    class func changeLanguage(lanuageKey : String, OnComplete : @escaping (Bool)-> Void){
        
        
        //   UserInfo.sharedInstance.saveWithKeyWithSingleItem(item: lanuageKey, key: self.DEFAULT_LANGUAGE)
        Constant.defaults.setValue(lanuageKey, forKeyPath: "Language")
        Constant.defaults.synchronize()
        OnComplete(true)
    }
    
    class func getdeviceLangBundle()-> Bundle{
        // To get Language of device ...
        var path : String = String()
        
        let bundleLang = ["en", "zh-Hans", "id", "vi-VN"]
        
        let strActiveLanguage = Constant.defaults.string(forKey: "Language") ?? "en"
        if bundleLang.contains(strActiveLanguage) {
            path = Bundle.main.path(forResource: strActiveLanguage, ofType: "lproj") ?? ""
        }
        else {
            changeLanguage(lanuageKey: Language.English.rawValue) { (_) in }
            path = Bundle.main.path(forResource: Language.English.rawValue, ofType: "lproj") ?? ""
        }
        return Bundle(path: path)!
    }
    
    class func getLocalizedString(key:String)-> String {
        return NSLocalizedString(key, tableName: nil, bundle: getdeviceLangBundle(), value: "", comment: "")
    }
}

extension UIViewController {
    
    func getDate(day: DayModel)-> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        let tommorrow = Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date()
        
        switch day {
        case .Today:
            return dateFormatter.string(from: date)
            
        case .Yesterday:
            return dateFormatter.string(from: yesterday)
            
        case .Tomorrow:
            return dateFormatter.string(from: tommorrow)
        }
    }
   
}

extension String {
    var wordList: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }
}

extension UITabBarController {
    
    func changeTitleLanguage() {
        self.tabBar.items?[0].title = ManageLocalization.getLocalizedString(key: "home")
        self.tabBar.items?[1].title = ManageLocalization.getLocalizedString(key: "tour")
        self.tabBar.items?[2].title = ManageLocalization.getLocalizedString(key: "stats")
        self.tabBar.items?[3].title = ManageLocalization.getLocalizedString(key: "news")
        self.tabBar.items?[4].title = ManageLocalization.getLocalizedString(key: "game_on")
    }
}

