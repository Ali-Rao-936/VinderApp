//
//  AppSettingsVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

struct appSettingsOtpions{
    let name : String
    let flag: String
    
    init(name: String, flag: String) {
        self.name = name
        self.flag = flag
    }
}

class AppSettingsVC: UIViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var languagesListDict = [appSettingsOtpions(name: enumForLanguages.english.rawValue, flag: enumForLanguageFlags.english.rawValue),
                             appSettingsOtpions(name: enumForLanguages.english.rawValue, flag: enumForLanguageFlags.english.rawValue),
                             appSettingsOtpions(name: enumForLanguages.english.rawValue, flag: enumForLanguageFlags.english.rawValue),
                             appSettingsOtpions(name: enumForLanguages.english.rawValue, flag: enumForLanguageFlags.english.rawValue)]
    
    var appSettingsList = [appSettingsOtpions(name: enumForAppSettingsOptions.changePwd.rawValue, flag: enumForAppSettingsImages.changePwd.rawValue),
                           appSettingsOtpions(name: enumForAppSettingsOptions.deleteaccount.rawValue, flag: enumForAppSettingsImages.deleteaccount.rawValue)]
    
    var settingsList = [[appSettingsOtpions]]()
    
    let viewModel = AuthViewModel(apiService: AuthWebServices())

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register Cell
    
        self.settingsTableView.register(ChooseLanguageTableViewCell.nib(), forCellReuseIdentifier: ChooseLanguageTableViewCell.identifier)
        self.settingsTableView.register(AppSettingsTableViewCell.nib(), forCellReuseIdentifier: AppSettingsTableViewCell.identifier)
        
        // Set up table view data
        self.settingsList.append(self.languagesListDict)
        self.settingsList.append(self.appSettingsList)
 
        self.settingsTableView.reloadData()
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Networking

    private func deleteUserAccount() {
       
       self.activityIndicatorStart()

       viewModel.deleteAccountAPI()
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           
           print("data...", data)
           CommonFxns.logOutAndPopToInitialVC()
           self.activityIndicatorStop()
       }
    }
    
    private func updatePassword(dict: [String:Any]) {
       
       self.activityIndicatorStart()

       viewModel.updatePasswordAPI(parameters: dict)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           print("data...", data)
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

// MARK: - TableView Delegates & Datasource

extension AppSettingsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 36
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard  let listCell = self.settingsTableView.dequeueReusableCell(withIdentifier: AppSettingsTableViewCell.identifier , for: indexPath) as? AppSettingsTableViewCell else {
            return cell
        }
        let dict = self.settingsList[indexPath.section][indexPath.row]
        
        listCell.titleLbl.text = dict.name
        listCell.tag = indexPath.row
        listCell.titleImgView.image = UIImage(named: dict.flag)
//        listCell.titleImgView.sd_setImage(with: URL( string:))
        if indexPath.section == 0{
            listCell.permissionSwitch.isHidden = false
            listCell.forwardImgView.isHidden = true
        }else{
            listCell.permissionSwitch.isHidden = true
            listCell.forwardImgView.isHidden = false
        }
        return listCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return enumForAppSettingsHeaderTitles.languages.rawValue
        default:
            return enumForAppSettingsHeaderTitles.security.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.settingsList[section].count
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = self.settingsList[indexPath.section][indexPath.row]
        
        if indexPath.section == zero{
            // Update Language.....
        }else{
            switch dict.name {
            case enumForAppSettingsOptions.deleteaccount.rawValue:
                CommonFxns.showConfirmationAlert(title: AlertMessages.ALERT_TITLE, message:AlertMessages.DELETE_ACCOUNT , cancel: true, vc: self) {
                    self.deleteUserAccount()
                }
            case enumForAppSettingsOptions.changePwd.rawValue:
                let otherVCObj = UpdatePasswordVC(nibName: enumViewControllerIdentifier.updatePasswordVC.rawValue, bundle: nil)
                self.navigationController?.pushViewController(otherVCObj, animated: true)
            default: break
            }
        }

    }
}

