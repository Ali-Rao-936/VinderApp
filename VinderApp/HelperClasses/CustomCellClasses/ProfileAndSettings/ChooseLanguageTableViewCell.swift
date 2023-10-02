//
//  ChooseLanguageTableViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit

class ChooseLanguageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets & Properties

    @IBOutlet weak var languageNameLbl: UILabel!
    @IBOutlet weak var flagImgview: UIImageView!
    @IBOutlet weak var radioBtn: UIButton!

    static let identifier = "ChooseLanguageTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ChooseLanguageTableViewCell", bundle: nil)
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
