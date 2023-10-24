//
//  EventsCollectionViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets & Properties

    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventCreatedByUserLbl: UILabel!
    @IBOutlet weak var noOfPeopleJoinedLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var completedEventView: UIViewCustomClass!
    @IBOutlet weak var hotEventView: UIView!
    
    static let identifier = "EventsCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "EventsCollectionViewCell", bundle: nil)
    }

    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Button Actions
    
    @IBAction func joinBtnSelected(_ sender: Any) {
//
//        print("joinBtnSelected.....")
//        self.delegate?.joinBtnSelected(cell: self)
    }
    
    @IBAction func viewBtnSelected(_ sender: Any) {
//        print("viewBtnSelected...")
//        self.delegate?.viewBtnSelected(cell: self)
    }

}
