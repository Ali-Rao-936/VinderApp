//
//  ExploreUserVC.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import UIKit

class ExploreUserVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var matchesCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var headingLbl: UILabel!

    var allUsersArr = [UserModel]()
    var myMatchUsersArr = [UserModel]()
    
    var users = [UserModel]()
    let viewModel = HomeViewModel(apiService: ExploreUserWebServices())
    var firstTime = true

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        hideKeyboardWhenTappedAround() // hide keyboard
        // Register tableView cells
        self.matchesCollectionView.register(MatchesCollectionViewCell.nib(), forCellWithReuseIdentifier: MatchesCollectionViewCell.identifier)
        
        // Network call
        self.getUsersList(subUrl: enumForAPIsEndPoints.getUsersList.rawValue)
    }
    
    // MARK: - Button Actions
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func segmentControlValuechanged(_ sender: Any) {
        if self.segmentControl.selectedSegmentIndex == 0{
            self.users = self.allUsersArr
        }else{
            if firstTime{
                firstTime = false
                self.getUsersList(subUrl: enumForAPIsEndPoints.myMatch.rawValue)
            }
            self.users = self.myMatchUsersArr
        }
        self.matchesCollectionView.reloadData()
    }
    
    // MARK: - Networking
        
    private func getUsersList(subUrl: String) {
       
       self.activityIndicatorStart()

       viewModel.getUsersList(subUrl: subUrl)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title: AlertMessages.ALERT_TITLE)
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetchforList = { data in

           var list = [UserModel]()
           for item in data{
               let user = UserModel(with: item)
               list.append(user)
           }
           
           if self.segmentControl.selectedSegmentIndex == 1{
               self.myMatchUsersArr = list
               self.users = self.myMatchUsersArr
           }else{
               self.allUsersArr = list
               self.users = self.allUsersArr
           }
           self.matchesCollectionView.reloadData()
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

// MARK: - CollectionView Delegates & Datasource

extension ExploreUserVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.matchesCollectionView.dequeueReusableCell(withReuseIdentifier: MatchesCollectionViewCell.identifier, for: indexPath) as? MatchesCollectionViewCell else{
            return cell
        }

        let dict = self.users[indexPath.row]
        listCell.usernameLbl.text = dict.name ?? emptyStr
        let location = dict.locationName ?? emptyStr
        listCell.userLocationLbl.text = location

        if location.isEmpty{
            listCell.locationIcon.isHidden = true
        }else{
            listCell.locationIcon.isHidden = false
        }
        
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: (self.matchesCollectionView.frame.width/3)-10, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let otherVCObj = OtherUserProfileVC(nibName: enumViewControllerIdentifier.otherUserProfileVC.rawValue, bundle: nil)
        otherVCObj.selectedUserId = self.users[indexPath.row].userId ?? 0
        otherVCObj.selectedUser = self.users[indexPath.row]
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
}
