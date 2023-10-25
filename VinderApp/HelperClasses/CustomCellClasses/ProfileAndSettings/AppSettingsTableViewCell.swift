//
//  AppSettingsTableViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit
import MOLH

class AppSettingsTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet var langSwitch: UISwitch!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var permissionSwitch: UISwitch!
    @IBOutlet weak var forwardImgView: UIImageView!
    
    var position = 0

    static let identifier = "AppSettingsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "AppSettingsTableViewCell", bundle: nil)
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
    
    @IBAction func switchValueChanged(_ sender: Any) {
     
    }
    
}
