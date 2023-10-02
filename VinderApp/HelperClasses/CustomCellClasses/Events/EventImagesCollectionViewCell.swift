//
//  EventImagesCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 30/09/2023.
//

import UIKit

class EventImagesCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var eventImgView : UIImageView!
    
    static let identifier = "EventImagesCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "EventImagesCollectionViewCell", bundle: nil)
    }

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
