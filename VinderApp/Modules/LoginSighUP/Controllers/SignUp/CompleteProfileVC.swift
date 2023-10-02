//
//  CompleteProfileVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class CompleteProfileVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var chooseGoal1Btn: UIButton!
    @IBOutlet weak var chooseGoal2Btn: UIButton!

    @IBOutlet weak var countryLbl: UILabel!

//    @IBOutlet weak var selectedGender

    var selectedGender = String()
    var loginPurpose = String()
    var locationId = Int()

    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        
    }
    
    func chooseSportsInterestsScreen(){
        let otherVCObj = ChooseInterestsVC(nibName: enumViewControllerIdentifier.chooseInterestsVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    // MARK: - Networking

    private func updateUserProfile(params: [String: Any]) {
       
       self.activityIndicatorStart()

        viewModel.updateUserProfile(parameters: params)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           print("data...", data)
           let user = UserModel(with: data)
           
           let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]
           
           UserDefaultsToStoreUserInfo.saveUserDataInUserDefaults(token: user.accessToken ?? emptyStr, userId: user.userId ?? zero, userDetails: updatedUser)
           
           self.chooseSportsInterestsScreen()
           self.activityIndicatorStop()
       }
    }
    
    // MARK: - UI Setup

    private func activityIndicatorStart() {
       // Code for show activity indicator view
//        self.loader.startAnimating()
       CommonFxns.showProgress()
    }

    private func activityIndicatorStop() {
       // Code for stop activity indicator view
//        self.loader.stopAnimating()
       CommonFxns.dismissProgress()
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveBtnAction(_ sender: Any) {
        let user = UserDefaultsToStoreUserInfo.getUser()
        let dict = UpdateProfileRequest(name: user?.name ?? emptyStr, phoneNumber: user?.phoneNumber ?? emptyStr, loginPurpose: user?.loginPurpose ?? emptyStr, gender: selectedGender, age: user?.age, locationId: locationId, about: user?.about ?? emptyStr, latitude: user?.latitude ?? emptyStr, longitude: user?.longitude ?? emptyStr).toDictionary()
        
        print("dict...", dict)
        self.updateUserProfile(params: dict)
    }
    
    @IBAction func chooseCountryBtnAction(_ sender: Any) {
        
    }
    
    
    @IBAction func chooseGoalBtnAction(_ sender: Any) {
        
    }

}
