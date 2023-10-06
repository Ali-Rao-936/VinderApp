//
//  SettingsVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

struct SettingsOptions{
    
    let title : String
    let titleImg : String
    let showSwitch: Bool
}

class SettingsVC: UIViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var settingsListTableView: UITableView!
    //    var selectedIndexRow = Int()
    
    var accountSettionsList = [SettingsOptions]()
//    var notificationsSettionsList = [SettingsOptions]()
    var contactUsSettionsList = [SettingsOptions]()
    var otherSettionsList = [SettingsOptions]()
    
    var settingOptionsArr = [[SettingsOptions]]()
    let viewModel = AuthViewModel(apiService: AuthWebServices())
    let headerListArr = [enumForSettingsTitles.account.rawValue, enumForSettingsTitles.contactUs.rawValue, enumForSettingsTitles.others.rawValue]
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register cell
        self.settingsListTableView.register(AppSettingsTableViewCell.nib(), forCellReuseIdentifier: AppSettingsTableViewCell.identifier)
        
        // Table View data setup
        self.accountSettionsList.append(contentsOf: [SettingsOptions(title: enumForSettingsOptions.basicInfo.rawValue, titleImg: enumForSettingsImages
            .basicInfo.rawValue, showSwitch: false),
                                                     SettingsOptions(title: enumForSettingsOptions.appSettings.rawValue, titleImg: enumForSettingsImages.appSettings.rawValue, showSwitch: false)])
        
//        self.notificationsSettionsList.append(contentsOf: [SettingsOptions(title: enumViewAppSettingsOptions.pushNotifications.rawValue, titleImg: enumViewAppSettingsImages.pushNotifications.rawValue, showSwitch: false)])
        self.contactUsSettionsList.append(contentsOf: [SettingsOptions(title: enumForSettingsOptions.helpandSupport.rawValue, titleImg: enumForSettingsImages.helpandSupport.rawValue, showSwitch: false)])
        
        self.otherSettionsList.append(contentsOf: [SettingsOptions(title: enumForSettingsOptions.privacyPolicy.rawValue, titleImg: enumForSettingsImages.privacyPolicy.rawValue, showSwitch: false),
                                      SettingsOptions(title: enumForSettingsOptions.termsAndConditions.rawValue, titleImg: enumForSettingsImages.termsAndConditions.rawValue, showSwitch: false),
                                      SettingsOptions(title: enumForSettingsOptions.givefeedback.rawValue, titleImg: enumForSettingsImages.givefeedback.rawValue, showSwitch: false)])

//        self.accountSettionsList.append()
        self.settingOptionsArr.append(accountSettionsList)
//        self.settingOptionsArr.append(notificationsSettionsList)
        self.settingOptionsArr.append(contactUsSettionsList)
        self.settingOptionsArr.append(otherSettionsList)
        
        self.settingsListTableView.reloadData()
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        CommonFxns.showConfirmationAlert(title: AlertMessages.ALERT_TITLE, message: AlertMessages.LOGOUT_USER, cancel: true, vc: self) {
            // Call Logout user API
            self.logoutUserAPI()
        }
    }
    
    // MARK: - Networking
        
    private func logoutUserAPI() {
        self.activityIndicatorStart()

        viewModel.logoutUserAPI()
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
            CommonFxns.logOutAndPopToInitialVC()
            self.activityIndicatorStop()
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

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingOptionsArr[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40 // 28 + 12
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingOptionsArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let settingsCell = self.settingsListTableView.dequeueReusableCell(withIdentifier: AppSettingsTableViewCell.identifier , for: indexPath) as? AppSettingsTableViewCell else {
            return cell
        }
        
        let dict = self.settingOptionsArr[indexPath.section][indexPath.row]
        settingsCell.titleLbl.text = dict.title
        settingsCell.titleImgView.image = UIImage(named: dict.titleImg)
        settingsCell.permissionSwitch.isHidden = !dict.showSwitch
        
        return settingsCell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headerListArr[section]
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.settingOptionsArr[indexPath.section][indexPath.row].title {
            
        case enumForSettingsOptions.basicInfo.rawValue:
            let otherVCObj = UpdateBasicProfileInfoVC(nibName: enumViewControllerIdentifier.updateBasicProfileInfoVC.rawValue, bundle: nil)
            self.navigationController?.pushViewController(otherVCObj, animated: true)
            
        case enumForSettingsOptions.appSettings.rawValue:
            let otherVCObj = AppSettingsVC(nibName: enumViewControllerIdentifier.appSettingsVC.rawValue, bundle: nil)
            self.navigationController?.pushViewController(otherVCObj, animated: true)
            
        case enumForSettingsOptions.privacyPolicy.rawValue:
            let otherVCObj = ContentVC(nibName: enumViewControllerIdentifier.contentVC.rawValue, bundle: nil)
            otherVCObj.contentType = enumToGetStaticContent.privacyPolicy.rawValue
            otherVCObj.heading = enumForSettingsOptions.privacyPolicy.rawValue
            self.navigationController?.pushViewController(otherVCObj, animated: true)
            
        case enumForSettingsOptions.termsAndConditions.rawValue:
            let otherVCObj = ContentVC(nibName: enumViewControllerIdentifier.contentVC.rawValue, bundle: nil)
            otherVCObj.contentType = enumToGetStaticContent.termsAndConditions.rawValue
            otherVCObj.heading = enumForSettingsOptions.termsAndConditions.rawValue
            self.navigationController?.pushViewController(otherVCObj, animated: true)
            
        case enumForSettingsOptions.helpandSupport.rawValue:
            let otherVCObj = ContentVC(nibName: enumViewControllerIdentifier.contentVC.rawValue, bundle: nil)
            otherVCObj.contentType = enumToGetStaticContent.support.rawValue
            otherVCObj.heading = enumForSettingsOptions.helpandSupport.rawValue
            self.navigationController?.pushViewController(otherVCObj, animated: true)
            
        case enumForSettingsOptions.givefeedback.rawValue:
            let otherVCObj = RemarksVC(nibName: enumViewControllerIdentifier.remarksVC.rawValue, bundle: nil)
            self.navigationController?.pushViewController(otherVCObj, animated: true)
            
        default:
            break
        }

    }

    
    

}



