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
    
    let viewModel = UserViewModel(userType: .allUsers)
   // var arrayOfUsers = [User]()
    var firstTime = true
    var arrayOfSelectedIndex: [IndexPath] = []
    var callBack: ((_ selectedIndex: [IndexPath])-> Void)?
   
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Methods
    func initialSetup(){
        // Register tableView cells
        self.friendListTableView.register(FriendListTableViewCell.nib(), forCellReuseIdentifier: FriendListTableViewCell.identifier)
        friendListTableView.reloadData()
    }
   
    
    // MARK: - Button Actions
    @IBAction func backBtnAction(_ sender: Any) {
        callBack?(arrayOfSelectedIndex)
        self.dismiss(animated: true)
    }
    
    @IBAction func inviteBtnAction(_ sender: Any) {
       // self.navigationController?.popViewController(animated: true)
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
        
        if arrayOfSelectedIndex.isEmpty {
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
