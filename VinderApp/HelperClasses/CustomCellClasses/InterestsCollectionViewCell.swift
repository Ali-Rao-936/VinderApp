//
//  InterestsCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets & Properties
//    
//    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var interestNameLbl: UILabel!
    @IBOutlet weak var interestImgView: UIImageView!
    @IBOutlet weak var bgView: UIView!

    static let identifier = "InterestsCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "InterestsCollectionViewCell", bundle: nil)
    }

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
