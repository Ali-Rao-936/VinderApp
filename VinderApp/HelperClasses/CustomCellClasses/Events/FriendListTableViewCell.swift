//
//  FriendListTableViewCell.swift
//  VinderApp
//
//  Created by iOS Dev on 09/10/2023.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {
    // MARK: - Outlets & Properties
    
  //  @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
   // @IBOutlet weak var noOfPeopleJoinedLbl: UILabel!
    @IBOutlet weak var selectedView: UIViewCustomClass!
    
    static let identifier = "FriendListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "FriendListTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
