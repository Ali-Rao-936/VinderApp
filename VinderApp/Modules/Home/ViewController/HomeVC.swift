//
//  HomeVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

struct UpdatedUserList{
    let userDetails: UserModel
    let events: [String:Any]
    
    init(userDetails: UserModel, events: [String : Any]) {
        self.userDetails = userDetails
        self.events = events
    }
}

class HomeVC: UIViewController, EventsTableViewCellProtocol, VinderUserAboutInfoTableViewCellProtocol {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var usersListTableView: UITableView!
    @IBOutlet weak var profileImgView: UIImageView!

    var userEvents = [2,0,3]

    var usersList = [UpdatedUserList]()
    
    let viewModel = HomeViewModel(apiService: ExploreUserWebServices())

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // UI Setup
        let user = UserDefaultsToStoreUserInfo.getUser()
        self.profileImgView.sd_setImage(with: URL(string: user?.profileImg ?? emptyStr), placeholderImage: UIImage(named: "smallDefaultUserProfileImg"), options: .allowInvalidSSLCertificates, completed: nil)

        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register tableView cells
        self.usersListTableView.register(EventsTableViewCell.nib(), forCellReuseIdentifier: EventsTableViewCell.identifier)
        self.usersListTableView.register(VinderUserAboutInfoTableViewCell.nib(), forCellReuseIdentifier: VinderUserAboutInfoTableViewCell.identifier)

        // register tableView header
        self.usersListTableView.register(VinderUserInfoTableViewHeader.nib(), forHeaderFooterViewReuseIdentifier: VinderUserInfoTableViewHeader.identifier)
        // Add empty space at bottom of the inner scroll view of Table view
        self.usersListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        // Network call
        self.getUsersList(subUrl: enumForAPIsEndPoints.getUsersList.rawValue)
    }
    
    // MARK: - Button Actions
    
//    @IBAction func backBtnAction(_ sender: Any) {
//    }

    @IBAction func profileBtnAction(_ sender: Any) {
        let otherVCObj = ProfileVC(nibName: enumViewControllerIdentifier.profileVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    // MARK: - Actions

    func joinBtnSelected(cell: EventsTableViewCell) {
        print("Join...")
        
        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
//        otherVCObj.selectedEventId = selectedEventId
        otherVCObj.eventType = eventType.joinEvent.rawValue
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    func likeBtnSelected(cell: VinderUserAboutInfoTableViewCell) {
        print("likeBtnSelected...")

        if let indexPath = self.usersListTableView.indexPath(for: cell){
            self.usersList.remove(at: indexPath.section)
            self.usersListTableView.deleteSections([indexPath.section], with: .left)
        }
    }
    
    func dislikeBtnSelected(cell: VinderUserAboutInfoTableViewCell) {
        print("dislikeBtnSelected...")
    }
    
    
    
    // MARK: - Networking

    private func getUsersList(subUrl: String) {
       
       self.activityIndicatorStart()

        viewModel.getUsersList(subUrl: subUrl)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetchforList = { data in

           var list = [UpdatedUserList]()
           for item in data{
               let user = UserModel(with: item)
//               list.append(user)
               let dict = UpdatedUserList(userDetails: user, events: [:])
               list.append(dict)
           }
           self.usersList.append(contentsOf: list)
           self.usersListTableView.reloadData()
           self.activityIndicatorStop()
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section{
//        case 0:
//            return 1 // about
//        default:
//            return 3 // event
//        }
        
        return self.usersList[section].events.count + 1 + 1 // userInfo in header+ about cell + eventsList
        
    
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension // about
        default:
            return 130 // event
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            
            guard  let aboutCell = self.usersListTableView.dequeueReusableCell(withIdentifier: VinderUserAboutInfoTableViewCell.identifier , for: indexPath) as? VinderUserAboutInfoTableViewCell else {
                return cell
            }
            aboutCell.delegate = self
            
            if indexPath.section == 0{
                aboutCell.userDescLbl.text = "ituytu uytuyu iuytiuytyu tiyutuyt ituytgyut uyt uyt uytiuy utuytut tuytiuyt yiutuytu uytuytu yutuytytiuytyu ytyut ytiuti tuytu tuti tiutiut itiiutiu iutiutiutuiti tiuiu tiut678876876876 6786876876876 iyuyiouy 8798798 iyiyui 89798798 iuyiuy89"
            }else{
                aboutCell.userDescLbl.text = "iou7oiu iouio "
            }
            return aboutCell
            
        default:
            
            guard  let eventCell = self.usersListTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier , for: indexPath) as? EventsTableViewCell else {
                return cell
            }
            eventCell.delegate = self
            return eventCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 430
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = UITableViewHeaderFooterView()
        
        guard  let headerView = self.usersListTableView.dequeueReusableHeaderFooterView(withIdentifier: VinderUserInfoTableViewHeader.identifier) as? VinderUserInfoTableViewHeader else {
            
            return cell
        }
//        headerView.gradientView.addGradient([gradientWhiteColor, gradientBlackColor], locations: [0.0, 0.6], frame: headerView.gradientView.frame)

        let dict = self.usersList[section]
        
        headerView.usernameLbl.text = dict.userDetails.name
    
//        headerView.
//        headerView.tagsView.addTags(["Football"])//, "Tennis", "Cricket", "Football", "Tennis", "Cricket"])
//
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


