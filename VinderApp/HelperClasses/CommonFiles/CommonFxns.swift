//
//  CommonFxns.swift
//  PlayersApp
//
//  Created by meem on 20/07/2023.
//

import UIKit
import Foundation
import SystemConfiguration
import SDWebImage
import SwiftyJSON
import MBProgressHUD

class CommonFxns: NSObject {
    
    static var globalHud:MBProgressHUD?
    
    //    // Method to LogOut from App and clear all the saved data
    //    class func directLogOut(){
    //
    //        let domain = Bundle.main.bundleIdentifier!
    //        UserDefaults.standard.removePersistentDomain(forName: domain)
    //        UserDefaults.standard.synchronize()
    //        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    //
    //        CommonFxns.logOutAndPopToInitialVC()
    //    }
    
    // Method to check internet connectivity
    class func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    // Method to Show default Alert view with message
    class func showAlert (_ reference:UIViewController, message:String, title:String){
        var alert = UIAlertController()
        if title == "" {
            alert = UIAlertController(title: nil, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        else{
            alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        reference.present(alert, animated: true, completion: nil)
    }
    
    // Method to Show default Alert view  at window level with message
    class func showAlertOnWindowlevel(message:String, title:String){
        var alert = UIAlertController()
        if title == "" {
            alert = UIAlertController(title: nil, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        else{
            alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController?.present(alert, animated: true)
        
        //        appDelegate.window?.rootViewController?.present(alert, animated: true)
        //        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    // Public method to Generate header for API calls
    class func getAuthenticationToken(authToken: String) -> [String: String]{
        let headers = [
            "Authorization" : String(format: "Bearer \(authToken)")
        ]
        return headers
    }
    
    // Public method to fetch header for API calls
    class func getAuthenticationToken() -> [String: String] {
       //     let token  = userDefault.value(forKey: USER_DEFAULT_token_Key) as? String ?? emptyStr
        let token = "60|qhBeilhnNC15e19dG1TkdJIxxyXmEpEK48NZhHZEa927cd04"
        let headers = [
            "Authorization" : String(format: "Bearer \(token)"),
             "Content-Type" : "application/json"
        ]
        return headers
    }
    
    // Method to check Email Validations
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"// "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    // multipart/form-data; boundary=<calculated when request is sent>
    // Method to check password Validations
    class func isValidPwd(str:String)->Bool{
        var valid = true
        let whitespace = NSCharacterSet.whitespaces
        let range = str.rangeOfCharacter(from: whitespace)
        
        // range will be nil if no whitespace is found
        if range != nil {
            valid = false
        } else {
            valid = true
        }
        return valid
    }
    
    // Method to trim Strings
    class func trimString(string:String) -> String{
        return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
    class func setImage(imageView:UIImageView,urlString:String?,placeHolder:UIImage?){
        imageView.sd_setImage(with: URL(string: urlString ?? ""), placeholderImage:placeHolder, options: .allowInvalidSSLCertificates, completed: nil)
    }
    
    class func showConfirmationAlert(title:String,message:String,okTitle:String = AlertMessages.ALERT_OK,cancel:Bool,cancelTitle:String = AlertMessages.ALERT_CANCEL,vc:UIViewController,success:@escaping(()->Void)){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action: UIAlertAction!) in
            success()
        }))
        if cancel{
            refreshAlert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action: UIAlertAction!) in
                vc.dismiss(animated: true)
            }))
        }
        vc.present(refreshAlert, animated: true, completion: nil)
    }
    
    class func showAlertWithCompletion(title:String,message:String,vc:UIViewController,success:@escaping(()->Void)){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: AlertMessages.ALERT_OK, style: .default, handler: { (action: UIAlertAction!) in
            success()
        }))
        
        vc.present(refreshAlert, animated: true, completion: nil)
    }
    
    class func logOutAndPopToInitialVC(){
        
        
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        
        userDefault.removeObject(forKey: USER_DEFAULT_userInfo_Key)
        userDefault.removeObject(forKey: USER_DEFAULT_token_Key)
        userDefault.synchronize()
        
        let storyboard = UIStoryboard(name:enumStoryBoard.main.rawValue, bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initialVC.rawValue) as! InitialVC
        
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        
        if let rootViewController = window.rootViewController {
            rootViewController.children.forEach {
                $0.willMove(toParent: nil)
                $0.view.removeFromSuperview()
                $0.removeFromParent()
            }
        }
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
    
    class func cleanCompleteStorage(){
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
    class func getDateFromMilliSeconds(mSeconds:Int64) -> String{
        let date = Date(timeIntervalSince1970: (Double(mSeconds) / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        return dateFormatter.string(from: date)
    }
    
    class func getMilliseconds(date:Date)->Int64{
        return Int64((date.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    class func stringFromDate(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        return dateFormatter.string(from: date)
    }
    
    class func getJsonObject(strJson:String) -> JSON{
        if let data = strJson.data(using: .utf8) {
            if let jsonObject = try? JSON(data: data) {
                return jsonObject
            }
        }
        return JSON()
    }
    
    class func changeDateToFormat(date:String, format: String, currentFormat: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        let date = dateFormatter.date(from: date) ?? Date()
        
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    
    
    // Show activity Indicator
    class func showProgress()->Void{
        DispatchQueue.main.async {
            globalHud?.removeFromSuperViewOnHide = true
            globalHud?.hide(animated: false)
            let window:UIWindow = (UIApplication.shared.keyWindow?.windowScene?.windows.first)!
            globalHud = MBProgressHUD.showAdded(to: window, animated: true)
            globalHud?.bezelView.color = UIColor.clear // Your backgroundcolor
            globalHud?.bezelView.style = .solidColor
        }
    }
    
    // Hide activity Indicator
    class func dismissProgress()->Void{
        DispatchQueue.main.async {
            globalHud?.hide(animated: true)
        }
    }
}

// Some common extensions
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
