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
    @IBOutlet weak var chooseGoal1Lbl: UILabel!
    @IBOutlet weak var chooseGoal2Lbl: UILabel!
    
    @IBOutlet weak var countryTxtField: UITextField!
    fileprivate let pickerView = ToolbarPickerView()

    var selectedGender = String()
    var loginPurpose = String()
    var selectedLocationId = zero
    var locationsArr = [Locations]()
    
    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    let authViewModel = AuthViewModel(apiService: AuthWebServices())
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        hideKeyboardWhenTappedAround() // Hide Keyboard
        
        self.countryTxtField.inputView = self.pickerView
        self.countryTxtField.inputAccessoryView = self.pickerView.toolbar

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
        self.loginPurpose = enumForLoginPurpose.makeNewFriends.rawValue
        
        // Network call
        self.getHomeAPI()
    }
    
    func chooseSportsInterestsScreen(){
        let otherVCObj = ChooseInterestsVC(nibName: enumViewControllerIdentifier.chooseInterestsVC.rawValue, bundle: nil)
        otherVCObj.comingFromCompleteProfileVC = true
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
           
           UserDefaultsToStoreUserInfo.updateUserDetails(user: updatedUser)
           
           self.chooseSportsInterestsScreen()
           self.activityIndicatorStop()
       }
    }
    
    private func getHomeAPI() {
       
       self.activityIndicatorStart()
        
        authViewModel.getAPI(url: enumForAPIsEndPoints.homeAPI.rawValue)
        authViewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
        authViewModel.didFinishFetch = { data in
           print("data...", data)
  
            let countries = data["countries"] as? [[String: Any]] ?? []
            var locations = [Locations]()
            for item in countries{
                let country = Locations(with: item)
                locations.append(country)
            }
            self.locationsArr = locations
           self.activityIndicatorStop()
            self.pickerView.reloadAllComponents()
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

        print(loginPurpose)
        print(selectedLocationId)

        if !loginPurpose.isEmpty && selectedLocationId != zero{
            let dict = ["login_purpose": self.loginPurpose, "gender": selectedGender, "location_id": self.selectedLocationId] as [String : Any]
            print("dict...", dict)
            self.updateUserProfile(params: dict)
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }
    }
    
    @IBAction func chooseGoalBtnAction(_ sender: UIButton) {
        if sender.tag == one{
            self.chooseGoal2Btn.setImage(UIImage(named: "selectedRadioIcon"), for: .normal)
            self.chooseGoal1Btn.setImage(UIImage(named: "unselectedRadioIcon"), for: .normal)
            loginPurpose = enumForLoginPurpose.explore.rawValue

        }else{
            self.chooseGoal1Btn.setImage(UIImage(named: "selectedRadioIcon"), for: .normal)
            self.chooseGoal2Btn.setImage(UIImage(named: "unselectedRadioIcon"), for: .normal)
            
            loginPurpose = enumForLoginPurpose.makeNewFriends.rawValue

        }
    }

}

extension CompleteProfileVC: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.locationsArr.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.locationsArr[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.locationsArr.count > 0{
            self.countryTxtField.text = self.locationsArr[row].name
        }
    }
}

extension CompleteProfileVC: ToolbarPickerViewDelegate {

    func didTapDone() {
        
        if self.locationsArr.count > 0{
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.countryTxtField.text = self.locationsArr[row].name
            self.selectedLocationId = self.locationsArr[row].id ?? 0
        }

        self.countryTxtField.resignFirstResponder()
    }

    func didTapCancel() {
        self.countryTxtField.resignFirstResponder()
    }
}
