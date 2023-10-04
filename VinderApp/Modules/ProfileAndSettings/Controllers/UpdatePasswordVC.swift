//
//  UpdatePasswordVC.swift
//  VinderApp
//
//  Created by ios Dev on 23/09/2023.
//
import UIKit

class UpdatePasswordVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!

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
    
    @IBAction func updatePasswordBtnAction(_ sender: Any) {
        let oldPassword = CommonFxns.trimString(string: self.oldPasswordTextField.text ?? emptyStr)
        let newPassword = CommonFxns.trimString(string: self.newPasswordTextField.text ?? emptyStr)
        let confirmPassword = CommonFxns.trimString(string: self.confirmNewPasswordTextField.text ?? emptyStr)
        
        if !oldPassword.isEmpty && !newPassword.isEmpty && !confirmPassword.isEmpty{
            let dict = UpdatePasswordRequest(oldPassword: oldPassword, newPassword: newPassword, confirmNewPassword: confirmPassword).toDictionary()
            self.updatePasswordAPI(params: dict)
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: emptyStr)
        }
    }
    
    // MARK: - Networking

    private func updatePasswordAPI(params: [String: Any]) {
       
       self.activityIndicatorStart()

        viewModel.updatePasswordAPI(parameters: params)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           
           print("data...", data)
           CommonFxns.showConfirmationAlert(title: successStr, message: passwordUpdateSuccess, cancel: false, vc: self) {
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


extension UpdatePasswordVC: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)

            switch textField {
            case self.oldPasswordTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            case self.newPasswordTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            case self.confirmNewPasswordTextField: if updatedText.count > generalTextFieldLength {return false}
                break
            default: if updatedText.count > generalTextFieldLength {return false}
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
        case self.oldPasswordTextField: self.newPasswordTextField.becomeFirstResponder()
        case self.newPasswordTextField: self.confirmNewPasswordTextField.becomeFirstResponder()
 
        default: textField.resignFirstResponder()
        }
        return false
    }
    
}
