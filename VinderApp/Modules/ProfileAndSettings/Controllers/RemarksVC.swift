//
//  RemarksVC.swift
//  VinderApp
//
//  Created by ios Dev on 06/10/2023.
//

import UIKit

class RemarksVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var remarksTxtView: UITextView!

    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    
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
    
    @IBAction func giveFeedbackBtnAction(_ sender: Any) {
        let remarks = CommonFxns.trimString(string: self.remarksTxtView.text ?? emptyStr)

        if !remarks.isEmpty{
            let dict = ["remarks": remarks, "rating": 4] as [String : Any]
            self.giveFeedbackAPI(params: dict)
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: emptyStr)
        }
    }
    
    // MARK: - Networking

    private func giveFeedbackAPI(params: [String: Any]) {
       
       self.activityIndicatorStart()

        viewModel.giveFeedback(params: params)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           
           print("data...", data)
           CommonFxns.showConfirmationAlert(title: successStr, message: feedbackSubmittedSuccessfully, cancel: false, vc: self) {
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
