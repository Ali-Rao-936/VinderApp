//
//  LoginVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = AuthViewModel(apiService: AuthWebServices())
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        hideKeyboardWhenTappedAround() // Hide keyboard
        
        self.addKeyboardobserversOnScreen() // add key board observers

        self.navigationController?.navigationBar.isHidden = true // hide Default navigation
    }
    
    func addKeyboardobserversOnScreen(){
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard notifications methods
    
    // Method to show keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - 100 // keyboardSize.height
    }
    
    // Method to hide keyboard

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    // MARK: - Others

    func verifyOtp(authToken: String){
        let otherVCObj = VerifyOtpVC(nibName: enumViewControllerIdentifier.verifyOtpVC.rawValue, bundle: nil)
        otherVCObj.authToken = authToken
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    func goToCreateAccountScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.createAccountVC.rawValue) as! CreateAccountVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    func goToMainScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.tabBarVC.rawValue) as! TabBarVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    // MARK: - Button Actions
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.forgotPasswordVC.rawValue) as! ForgotPasswordVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        let email = CommonFxns.trimString(string: self.emailTextField.text ?? emptyStr)
        let password = CommonFxns.trimString(string: self.passwordTextField.text ?? emptyStr)
        let deviceId = NSUUID().uuidString //.identifierForVendor?.UUIDString

        print("device Id...", deviceId)
        
        if !email.isEmpty && CommonFxns.isValidEmail(testStr: email){
            let dict = LoginRequest(email: email, password: password, deviceId: deviceId, token: emptyStr).toDictionary()
            self.loginUserAPI(params: dict)
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        self.goToCreateAccountScreen()
    }

    // MARK: - Networking

    private func loginUserAPI(params: [String: Any]) {
       
       self.activityIndicatorStart()

        viewModel.loginUserAPI(url: enumForAPIsEndPoints.login.rawValue, parameters: params)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           print("data...", data)
           let user = UserModel(with: data)

           if user.otpVerifed == one{
               let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]
               
               UserDefaultsToStoreUserInfo.saveUserDataInUserDefaults(token: user.accessToken ?? emptyStr, userId: user.userId ?? zero, userDetails: updatedUser)
               self.goToMainScreen()
           }else{
               self.verifyOtp(authToken: user.accessToken ?? emptyStr)
           }
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
    
}

extension LoginVC: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)

            switch textField {
            case self.passwordTextField:
                if updatedText.count > generalTextFieldLength {
                    return false
                }
                break
            default:
                if updatedText.count > emailTextFieldLength {
                    return false
                }
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}
