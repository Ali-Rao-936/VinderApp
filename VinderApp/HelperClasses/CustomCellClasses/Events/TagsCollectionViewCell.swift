//
//  TagsCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 26/09/2023.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var selectedView : UIView!
    @IBOutlet weak var deselectedView : UIView!
    @IBOutlet weak var tagImgView : UIImageView!
    @IBOutlet weak var tagLbl : UILabel!
    @IBOutlet weak var cancelBtn : UIButton!
    
    static let identifier = "TagsCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "TagsCollectionViewCell", bundle: nil)
    }

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
