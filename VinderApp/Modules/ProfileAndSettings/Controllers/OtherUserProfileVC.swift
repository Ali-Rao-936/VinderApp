//
//  OtherUserProfileVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import TagListView

class OtherUserProfileVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userLocationLbl: UILabel!
    @IBOutlet weak var aboutInfoTextView: UILabel!
    @IBOutlet weak var userInterestsView: TagListView!
    @IBOutlet weak var userLevelLbl: UILabel!

    var selectedUserId = Int()
    var selectedUser : UserModel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup(user: selectedUser)
    }
    
    // MARK: - Methods
    
    func initialUISetup(user: UserModel){
        
        self.userNameLbl.text = user.name
        self.userLevelLbl.text = "\(user.level ?? 0)"
        self.userLocationLbl.text = user.locationName
        self.aboutInfoTextView.text = user.about
        
        let profileImg = ""
        self.userImgView.sd_setImage(with: URL(string: user.profileImg ?? emptyStr), placeholderImage:UIImage(named: "smallDefaultUserProfileImg"), options: .allowInvalidSSLCertificates, completed: nil)
    }
    
    
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }



}
