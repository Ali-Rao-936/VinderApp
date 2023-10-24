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
    
    var users = [User]()
    var nearUsersArray = [User]()
    var myMatchUsersArray = [User]()
    
    var nearByUserViewModel: UserViewModel?
    var myMatchUserViewModel: UserViewModel?
    var firstTime = true

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
        callToViewModelForUIUpdate()
    }
    
    // MARK: - Methods
    func initialSetup(){
    //    hideKeyboardWhenTappedAround() // hide keyboard
        headingLbl.text = "Users Near You"
        // Register tableView cells
        self.matchesCollectionView.register(MatchesCollectionViewCell.nib(), forCellWithReuseIdentifier: MatchesCollectionViewCell.identifier)
        
        // Network call
      //  self.getUsersList(subUrl: enumForAPIsEndPoints.getUsersList.rawValue)
    }
    
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
         nearByUserViewModel = UserViewModel(userType: .nearUsers)
         myMatchUserViewModel = UserViewModel(userType: .myMatchUsers)
        
        CommonFxns.showProgress()
        nearByUserViewModel?.bindUserViewModelToController = {
            self.updateDataSource()
        }
        myMatchUserViewModel?.bindUserViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.nearUsersArray = nearByUserViewModel?.userList?.data ?? []
        self.users = nearUsersArray // default near by users displayed
        self.myMatchUsersArray = myMatchUserViewModel?.userList?.data ?? []
        matchesCollectionView.reloadData()
    }
    
    // MARK: - Button Actions
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        if self.segmentControl.selectedSegmentIndex == 0{
            headingLbl.text = "Users Near You"
            self.users = self.nearUsersArray
        }else{
            headingLbl.text = "Your Match List"
            self.users = self.myMatchUsersArray
        }
        self.matchesCollectionView.reloadData()
    }
    
//    // MARK: - Networking
//        
//    private func getUsersList(subUrl: String) {
//       
//       self.activityIndicatorStart()
//
//       viewModel.getUsersList(subUrl: subUrl)
//        
//       viewModel.showAlertClosure = {
//           msg in
//           print("msg....", msg)
//           CommonFxns.showAlert(self, message: msg, title: AlertMessages.ALERT_TITLE)
//           self.activityIndicatorStop()
//       }
//       
//       viewModel.didFinishFetchforList = { data in
//
//           var list = [UserModel]()
//           for item in data{
//               let user = UserModel(with: item)
//               list.append(user)
//           }
//           
//           if self.segmentControl.selectedSegmentIndex == 1{
//               self.myMatchUsersArr = list
//               self.users = self.myMatchUsersArr
//           }else{
//               self.allUsersArr = list
//               self.users = self.allUsersArr
//           }
//           self.matchesCollectionView.reloadData()
//           self.activityIndicatorStop()
//       }
//    }
    
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
        let location = dict.location ?? emptyStr
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
        let otherVCObj = UserDetailVC(nibName: enumViewControllerIdentifier.userDetailVC.rawValue, bundle: nil)
        otherVCObj.selectedUserId = self.users[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
}
