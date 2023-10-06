//
//  TagsCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 26/09/2023.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var tagView : UIView!
    @IBOutlet weak var tagImgView : UIImageView!
    @IBOutlet weak var tagLbl : UILabel!

    static let identifier = "TagsCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "TagsCollectionViewCell", bundle: nil)
    }

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Button Actions
    


}
