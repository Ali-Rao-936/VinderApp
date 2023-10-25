//
//  InviteFriendsVC.swift
//  VinderApp
//
//  Created by ios Dev on 22/09/2023.
//

import UIKit

class InviteFriendsVC: UIViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var friendListTableView: UITableView!
    @IBOutlet weak var inviteButton: UIButtonCustomClass!
    var upcomingEventsList = [Event]()
    var pastEventsList = [Event]()
    var events = [Event]()
    
    var viewModel: EventViewModel!
    // var arrayOfUsers = [User]()
    var firstTime = true
    var arrayOfSelectedIndex: [IndexPath] = []
    var callBack: ((_ selectedIndex: [IndexPath])-> Void)?
    var isInvitationWhileCreatingEvent: Bool = false
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Methods
    func initialSetup(){
        // Register tableView cells
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.friendListTableView.register(FriendListTableViewCell.nib(), forCellReuseIdentifier: FriendListTableViewCell.identifier)
        friendListTableView.reloadData()
    }
    
    func callToViewModelForUIUpdate() {
        viewModel = EventViewModel(eventType: .inviteEvent)
        viewModel?.bindViewModelToController = { [self] in
            let message = viewModel?.eventList.messages?.first ?? ""
            CommonFxns.showAlert(self, message: message, title: "")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateDataSource() {
        if viewModel.eventList.code == 200 {
            
        }
    }
    
    // MARK: - Button Actions
    @IBAction func backBtnAction(_ sender: Any) {
        if self.presentingViewController != nil {
            self.dismiss(animated: true)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        callBack?(arrayOfSelectedIndex)
    }
    
    @IBAction func inviteBtnAction(_ sender: Any) {
        // self.navigationController?.popViewController(animated: true)
        callToViewModelForUIUpdate()
    }
}

extension InviteFriendsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let friendCell = self.friendListTableView.dequeueReusableCell(withIdentifier: FriendListTableViewCell.identifier , for: indexPath) as? FriendListTableViewCell else {
            return cell
        }
        
        friendCell.nameLbl.text = arrayOfUsers[indexPath.row].name ?? "User"
        friendCell.locationLbl.text = arrayOfUsers[indexPath.row].location ?? ""
        friendCell.levelLbl.text = "\(arrayOfUsers[indexPath.row].level ?? 0)"
        
        if arrayOfSelectedIndex.contains(indexPath) {
            friendCell.selectedView.isHidden = false
        }else {
            friendCell.selectedView.isHidden = true
        }
        
        return friendCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? FriendListTableViewCell
        
        if arrayOfSelectedIndex.contains(indexPath) {
            arrayOfSelectedIndex = arrayOfSelectedIndex.filter { $0 != indexPath}
            
            cell?.selectedView.isHidden = true
        }else {
            arrayOfSelectedIndex.append(indexPath)
            
            cell?.selectedView.isHidden = false
        }
        
        if arrayOfSelectedIndex.isEmpty || isInvitationWhileCreatingEvent {
            inviteButton.isHidden = true
        }else {
            inviteButton.isHidden = false
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86.0
    }
    
}
