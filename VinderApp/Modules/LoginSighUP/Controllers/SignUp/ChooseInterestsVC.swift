//
//  ChooseInterestsVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class ChooseInterestsVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var  interestsCollectionView: UICollectionView!
    
    var allSportsInterestsList = [SportsInterests]()
    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    
    var selectedIds = [Int]()
    var comingFromCompleteProfileVC = false
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register Cell
        self.interestsCollectionView.register(InterestsCollectionViewCell.nib(), forCellWithReuseIdentifier: InterestsCollectionViewCell.identifier)
        
        // Network call
        self.getInterestsList()
    }
    
    func updateUserInfoLocally(user: UserModel){
        let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]

        UserDefaultsToStoreUserInfo.updateUserDetails(user: updatedUser)
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if self.selectedIds.count > 0{
            
            var dict = [String: Any]()
            for i in self.selectedIds.indices{
                dict["sport_id[\(i)]"] = self.selectedIds[i]
            }
            self.updateProfileInfo(params: dict)
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.CHOOSE_INTERESTS, title: AlertMessages.ERROR_TITLE)
        }
    }
    
    // MARK: - Networking
    
    private func getInterestsList() {
       
       self.activityIndicatorStart()

       viewModel.getInterestsList()
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetchforList = { data in
           print("data...", data)
           
           self.activityIndicatorStop()
           
           let tempData = data as [[String: Any]]
           var interests = [SportsInterests]()
           
           for item in tempData{
               let interest = SportsInterests(with: item)
               interests.append(interest)
           }
           self.allSportsInterestsList = interests
           self.interestsCollectionView.reloadData()
       }
    }
    
    private func updateProfileInfo(params: [String: Any]) {
        self.activityIndicatorStart()

        viewModel.updateUserProfile(parameters: params)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
            self.activityIndicatorStop()
            print("data...", data)
            
            if !self.comingFromCompleteProfileVC{
                self.navigationController?.popViewController(animated: true)
            }else{
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.tabBarVC.rawValue) as! TabBarVC
                self.navigationController?.pushViewController(signUpVcObj, animated: true)
            }
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

// MARK: - CollectionView Delegates & Datasource

extension ChooseInterestsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return one
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allSportsInterestsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.interestsCollectionView.dequeueReusableCell(withReuseIdentifier: InterestsCollectionViewCell.identifier, for: indexPath) as? InterestsCollectionViewCell else{
            return cell
        }

        let dict = self.allSportsInterestsList[indexPath.row]
        listCell.interestNameLbl.text = dict.name
//        print("url....",dict.imgUrls ,dict.imgUrls?.threeX ?? emptyStr)
        listCell.interestImgView.sd_setImage(with: URL( string: dict.imgUrls?.threeX ?? emptyStr))
        
        if let selectedIdIndex = selectedIds.enumerated().filter({ $0.element == dict.id }).map({ $0.offset }).first{
            listCell.bgView.layer.borderColor = primaryColor.cgColor
            listCell.bgView.backgroundColor = primaryColorWithAlpha
        }else{
            listCell.bgView.layer.borderColor = UIColor.lightGray.cgColor
            listCell.bgView.backgroundColor = UIColor.white
        }
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("size.....")
        let width = (self.interestsCollectionView.frame.width/3)-30
        return CGSize(width: width, height: width+14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id = self.allSportsInterestsList[indexPath.row].id ?? zero
        
        if let selectedIdIndex = selectedIds.enumerated().filter({ $0.element == id }).map({ $0.offset }).first{
            print("selectedIdIndex...", selectedIdIndex)
            self.selectedIds.remove(at: selectedIdIndex)
        }else{
            self.selectedIds.append(id)
        }
        print("selected ids...", self.selectedIds)

        self.interestsCollectionView.reloadData()
    }
}


