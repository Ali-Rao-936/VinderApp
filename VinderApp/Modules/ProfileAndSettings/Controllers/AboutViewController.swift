//
//  AboutViewController.swift
//  VinderApp
//
//  Created by Qoo on 25/10/2023.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    
    @IBOutlet var txtAbout: UITextField!
    var aboutText : String?
    
    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtAbout.text = aboutText ?? ""
    }


    // MARK: - Button Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        let dict = ["about" : txtAbout.text ?? ""]
            self.updateProfileAPI(params: dict)
    }
    
    
    
    // MARK: - Networking

    private func updateProfileAPI(params: [String:Any]) {
        self.activityIndicatorStart()

        viewModel.updateUserProfile(parameters: params)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
            let user = UserModel(with: data)
            self.updateUserInfoLocally(user: user)
            CommonFxns.showConfirmationAlert(title: successStr, message: AlertMessages.PROFILE_ABOUT_UPDATED, cancel: false, vc: self) {
                self.navigationController?.popViewController(animated: true)
            }
            self.activityIndicatorStop()
        }
    }

    // MARK: - UI Setup
    
    // Code for show activity indicator view
    private func activityIndicatorStart() {
        CommonFxns.showProgress()
    }
    
    // Code for stop activity indicator view
    private func activityIndicatorStop() {
        CommonFxns.dismissProgress()
    }

    func updateUserInfoLocally(user: UserModel){
        let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]

        UserDefaultsToStoreUserInfo.updateUserDetails(user: updatedUser)
    }
}
