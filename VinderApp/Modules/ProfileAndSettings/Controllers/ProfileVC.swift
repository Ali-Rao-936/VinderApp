//
//  ProfileVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import TagListView

class ProfileVC: UIViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var aboutDescLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var userLevelLbl: UILabel!
    @IBOutlet weak var tagsListView: TagListView!

    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Initial Setup
        self.initialSetup()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Show user data on screen
        self.showInfoOnScreen()
        
        // Network calls
        self.getProfielInfoAPI()
    }
    
    func showInfoOnScreen(){
        
        // UI Setup
        let user = UserDefaultsToStoreUserInfo.getUser()
        print("user...", user)
        self.fullNameLbl.text = user?.name
        self.locationLbl.text = user?.locationName ?? locationStr
        
        self.aboutDescLbl.text = user?.about
    }
    
    func showPopUpToEditAboutDesc(){
        let alertController = UIAlertController(title: "Edit your profile description", message: "Say something about you so that other people can understand you better.", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Describe yourself..."
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Update", style: .default) { _ in

            // this code runs when the user hits the "save" button
            let aboutDesc = alertController.textFields![0].text ?? emptyStr

            let dict = ["about" : aboutDesc]
            self.updateProfileAPI(params: dict)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func updateUserInfoLocally(user: UserModel){
        let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]

        UserDefaultsToStoreUserInfo.updateUserDetails(user: updatedUser)
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func settingsBtnAction(_ sender: Any) {
        let otherVCObj = SettingsVC(nibName: enumViewControllerIdentifier.settingsVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    @IBAction func editAboutDescBtnAction(_ sender: Any) {
        self.showPopUpToEditAboutDesc()
    }

    @IBAction func editInterestsBtnAction(_ sender: Any) {
        let otherVCObj = ChooseInterestsVC(nibName: enumViewControllerIdentifier.chooseInterestsVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    // MARK: - Networking
        
    private func getProfielInfoAPI() {
        self.activityIndicatorStart()

        viewModel.getProfileInfo()
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
            self.activityIndicatorStop()
                    
            if let sportsInterests = data["sports_interest"] as? [[String:Any]]{
                for item in sportsInterests{
                    let interest = SportsInterests(with: item)
                    print(interest.name ?? emptyStr)
                    self.tagsListView.addTag(interest.name ?? emptyStr)
                }
//                self.tagsListView.addTag()
            }
            let user = UserModel(with: data)
                
            print("user...", user)
            self.updateUserInfoLocally(user: user)

            self.showInfoOnScreen()
        }
    }

    
    private func updateProfileAPI(params: [String:Any]) {
        self.activityIndicatorStart()

        viewModel.updateUserProfile(parameters: params)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
            self.activityIndicatorStop()
            print("data...", data)
            let user = UserModel(with: data)
            self.updateUserInfoLocally(user: user)
            self.showInfoOnScreen()
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


}
