//
//  CreateAccountVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class CreateAccountVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

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
        self.addKeyboardobserversOnScreen()
        self.navigationController?.navigationBar.isHidden = true // hide Default navigation
    }
    
    func addKeyboardobserversOnScreen(){
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func goToMainScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.tabBarVC.rawValue) as! TabBarVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        let email = CommonFxns.trimString(string: self.emailTextField.text ?? emptyStr)
        let password = CommonFxns.trimString(string: self.passwordTextField.text ?? emptyStr)
        let confirmPassword = CommonFxns.trimString(string: self.confirmPasswordTextField.text ?? emptyStr)
        let phoneNumber = CommonFxns.trimString(string: self.phoneNumberTextField.text ?? emptyStr)
        let fullName = CommonFxns.trimString(string: self.fullNameTextField.text ?? emptyStr)

        let deviceId = NSUUID().uuidString //.identifierForVendor?.UUIDString

        print("device Id...", deviceId)
        if !email.isEmpty  && !fullName.isEmpty && !phoneNumber.isEmpty && !password.isEmpty{
            if password == confirmPassword{
                if CommonFxns.isValidEmail(testStr: email){
                    let dict = RegisterRequest(email: email, password: password, phoneNumber: phoneNumber,name: fullName, deviceId: deviceId, token: emptyStr).toDictionary()
                    self.registerUserAPI(params: dict)
                }else{
                    CommonFxns.showAlert(self, message: AlertMessages.INVALID_EMAIL, title: AlertMessages.ALERT_TITLE)
                }
            }else{
                CommonFxns.showAlert(self, message: AlertMessages.PASSWORD_MISMATCH, title: AlertMessages.ALERT_TITLE)
            }
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }
    }

    // MARK: - Networking

    private func registerUserAPI(params: [String: Any]) {
       
       self.activityIndicatorStart()

        viewModel.registerUserAPI(url: enumForAPIsEndPoints.register.rawValue, parameters: params)
        
        viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           
           print("data...", data)
           let user = UserModel(with: data)
           
           self.verifyOtp(authToken: user.accessToken ?? emptyStr)
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

extension CreateAccountVC: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)

            switch textField {
            case self.emailTextField: if updatedText.count > emailTextFieldLength {return false}
                break
            case self.phoneNumberTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            case self.fullNameTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            case self.passwordTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            case self.confirmPasswordTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            default: if updatedText.count > generalTextFieldLength {return false}
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
        case self.emailTextField: self.phoneNumberTextField.becomeFirstResponder()

        case self.phoneNumberTextField: self.fullNameTextField.becomeFirstResponder()
            
        case self.fullNameTextField: self.passwordTextField.becomeFirstResponder()

        case self.passwordTextField: self.confirmPasswordTextField.becomeFirstResponder()
                        
        default: textField.resignFirstResponder()
        }
        return false
    }
}
