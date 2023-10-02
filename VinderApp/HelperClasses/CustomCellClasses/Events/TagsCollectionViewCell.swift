//
//  TagsCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 26/09/2023.
//

import UIKit

protocol TagsCollectionViewCellProtocol{
    func chooseSportBtnSelected(cell: TagsCollectionViewCell)
}

class TagsCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var tagBtn : UIButton!
    
    static let identifier = "TagsCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "TagsCollectionViewCell", bundle: nil)
    }
    var delegate: TagsCollectionViewCellProtocol?

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Button Actions
    
    @IBAction func chooseSportBtnSelected(_ sender: Any) {
        self.delegate?.chooseSportBtnSelected(cell: self)
    }

}
