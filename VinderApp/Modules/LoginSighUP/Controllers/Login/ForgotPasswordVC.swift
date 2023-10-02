//
//  ForgotPasswordVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var emailTextField: UITextField!
//    var selectedIndexRow = Int()
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
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendCodeBtnAction(_ sender: Any) {
        let email = CommonFxns.trimString(string: self.emailTextField.text ?? emptyStr)
        
        if !email.isEmpty && CommonFxns.isValidEmail(testStr: email){
            
            self.forgotPasswordAPI(params: ["email" : email])
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.INVALID_EMAIL, title: emptyStr)
        }
    }
    
    // MARK: - Networking

    private func forgotPasswordAPI(params: [String: Any]) {
       
       self.activityIndicatorStart()

        viewModel.forgotPassword(url: enumForAPIsEndPoints.forgotPassword.rawValue, parameters: params)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           
           print("data...", data)
           CommonFxns.showConfirmationAlert(title: successStr, message: forgotPasswordAPISuccessMsg, cancel: false, vc: self) {
               self.navigationController?.popViewController(animated: true)
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
