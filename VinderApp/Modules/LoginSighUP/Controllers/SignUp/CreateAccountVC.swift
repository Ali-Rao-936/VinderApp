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
        self.navigationController?.navigationBar.isHidden = true // hide Default navigation
    }
    
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
        let phoneNumber = CommonFxns.trimString(string: self.phoneNumberTextField.text ?? emptyStr)
        let fullName = CommonFxns.trimString(string: self.fullNameTextField.text ?? emptyStr)

        let deviceId = NSUUID().uuidString //.identifierForVendor?.UUIDString

        print("device Id...", deviceId)
        if !email.isEmpty && CommonFxns.isValidEmail(testStr: email) && !fullName.isEmpty && !phoneNumber.isEmpty{
            let dict = RegisterRequest(email: email, password: password, phoneNumber: phoneNumber,name: fullName, deviceId: deviceId, token: emptyStr).toDictionary()
            self.registerUserAPI(params: dict)
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
