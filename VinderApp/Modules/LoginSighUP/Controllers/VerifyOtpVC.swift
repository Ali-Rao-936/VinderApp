//
//  VerifyCodeVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class VerifyOtpVC: UIViewController, OTPDelegate {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var verifyOtpView: UIView!
    @IBOutlet var resendOtpBtn: UIButton!
    
    let otpStackView = OTPStackView()
    var verifyOtpData: VerifyOtpRequestModel!
    
    let viewModel = AuthViewModel(apiService: AuthWebServices())
    
    var comingFromRegister = Bool()
    var isValidCode = false
    var isResendCode = false
    var isVerifiedPassword = false
    var resendOtpTypeCode = String()
    var authToken = String()
    var email = String()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Setup OTP view
        self.verifyOtpView.addSubview(otpStackView)
        otpStackView.delegate = self
        
        hideKeyboardWhenTappedAround() // Hide keyborad by touch anywhere on the screen
    }
    
    func goToMainScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.tabBarVC.rawValue) as! TabBarVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    func completeProfile(){
        let otherVCObj = ChooseGenderVC(nibName: enumViewControllerIdentifier.chooseGenderVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    func didChangeValidity(isValid: Bool) {
        self.isValidCode = false
        if isValid{
            self.isValidCode = true
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {

        let otp = self.otpStackView.getOTP()
        
        if !authToken.isEmpty && isValidCode && !otp.isEmpty{
            let dict = VerifyOtpRequestModel(otp: otp).toAnyObject()
            self.verifyUserAPI(dict: dict as! [String : Any])
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }
    }
    
    @IBAction func resendOtpBtnAction(_ sender: Any) {
        self.resendOtpAPI()
    }
    
    // MARK: - Networking
    
    private func verifyUserAPI(dict: [String: Any]) {
        
        self.activityIndicatorStart()
        
        viewModel.verifyOtpAPI(token: self.authToken, parameters: dict)
        
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title:"Alert")
            self.activityIndicatorStop()
        }
        
        viewModel.didFinishFetch = { data in
            
            let user = UserModel(with: data)

            let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]
            
            UserDefaultsToStoreUserInfo.saveUserDataInUserDefaults(token: user.accessToken ?? emptyStr, userId: user.userId ?? zero, userDetails: updatedUser)
            self.completeProfile()
//            self.goToMainScreen()
            self.activityIndicatorStop()
        }
    }
    
    private func resendOtpAPI() {
        
        self.activityIndicatorStart()
        
        viewModel.resendOtpAPI(token: self.authToken)

        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title:"Alert")
            self.activityIndicatorStop()
        }
        
        viewModel.didFinishFetch = { data in
            
            self.activityIndicatorStop()
        }
    }
    
    // MARK: - UI Setup
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        CommonFxns.showProgress()
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        CommonFxns.dismissProgress()
    }
    
}
