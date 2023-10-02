//
//  MatchesCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets & Properties
//
//    @IBOutlet weak var ratingLbl: UILabel!
//    @IBOutlet weak var usernameLbl: UILabel!
    
    static let identifier = "MatchesCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "MatchesCollectionViewCell", bundle: nil)
    }

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
