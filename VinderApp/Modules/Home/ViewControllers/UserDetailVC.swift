//
//  OtherUserProfileVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import TagListView

class UserDetailVC: UIViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userLocationLbl: UILabel!
    @IBOutlet weak var aboutInfoTextView: UILabel!
    @IBOutlet weak var eventListTableView: UITableView!
    @IBOutlet weak var userLevelLbl: UILabel!
    @IBOutlet weak var interestTagListView: TagListView!
    
    var selectedUserId = Int()
    var viewModel: UserViewModel?
    var userDetail: User?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        self.initialSetup()
        callToViewModelForUIUpdate()
    }
    
    // MARK: - Methods
    func initialSetup(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.eventListTableView.register(EventsTableViewCell.nib(), forCellReuseIdentifier: EventsTableViewCell.identifier)
    }
    
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
        CommonFxns.showProgress()
        self.viewModel = UserViewModel(userType: .userDetail, userID: selectedUserId)
        self.viewModel?.bindUserViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        userDetail = viewModel?.userDetail.data
        userNameLbl.text = userDetail?.name ?? "User"
        userLevelLbl.text = "\(userDetail?.level ?? 0)"
        userLocationLbl.text = userDetail?.location
        aboutInfoTextView.text = userDetail?.about ?? "Welcome to my profile"
        userImgView.sd_setImage(with: URL(string: userDetail?.profileImg ?? emptyStr), placeholderImage:UIImage(named: "smallDefaultUserProfileImg"), options: .allowInvalidSSLCertificates, completed: nil)
        
        if userDetail?.sportsInterest?.isEmpty != true {
            for index in 0...(userDetail?.sportsInterest?.count ?? 0)-1 {
                interestTagListView.addTag(userDetail?.sportsInterest?[index].name?.capitalized ?? "ABC")
            }
        }
        
        self.eventListTableView.reloadData()
    //    print("Frame ------> \(self.eventListTableView.frame.height)")
        DispatchQueue.main.async {
            var frame = self.eventListTableView.frame
            frame.size.height = self.eventListTableView.contentSize.height
            self.eventListTableView.frame = frame
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetail?.eventList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard  let eventsCell = self.eventListTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier , for: indexPath) as? EventsTableViewCell else {
            return cell
        }
        
        let imageURL = userDetail?.eventList?[indexPath.row].bannerImage?.image ?? ""
        let date = CommonFxns.changeDateToFormat(date: userDetail?.eventList?[indexPath.row].date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
        let time = userDetail?.eventList?[indexPath.row].time ?? emptyStr
        
        eventsCell.eventNameLbl.text = userDetail?.eventList?[indexPath.row].name ?? ""
        eventsCell.noOfPeopleJoinedLbl.text = "\(userDetail?.eventList?[indexPath.row].peopleJoinedCount ?? 0)"
        eventsCell.eventImgView.sd_setImage(with: URL(string: imageURL), placeholderImage:UIImage(named: "defaultEventImg"), context: nil)
        eventsCell.dateTimeLbl.text = "\(date), \(time)"
        return eventsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
