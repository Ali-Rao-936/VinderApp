//
//  VinderUserAboutInfoTableViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit

protocol VinderUserAboutInfoTableViewCellProtocol {
    func likeBtnSelected(cell: VinderUserAboutInfoTableViewCell)
    func dislikeBtnSelected(cell: VinderUserAboutInfoTableViewCell)
}

class VinderUserAboutInfoTableViewCell: UITableViewCell {
    
    // MARK: - Outlets & Properties
//
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var userDescLbl: UILabel!

    static let identifier = "VinderUserAboutInfoTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "VinderUserAboutInfoTableViewCell", bundle: nil)
    }

    var delegate: VinderUserAboutInfoTableViewCellProtocol?
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func likeBtnAction(_ sender: Any) {
        self.delegate?.likeBtnSelected(cell: self)
    }
    
    @IBAction func dislikeBtnAction(_ sender: Any) {
        self.delegate?.dislikeBtnSelected(cell: self)
    }
    
}
