//
//  EventsTableViewCell.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

protocol EventsTableViewCellProtocol {
    func joinBtnSelected(cell: EventsTableViewCell)
}

class EventsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventCreatedByUserLbl: UILabel!
    @IBOutlet weak var noOfPeopleJoinedLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    
    static let identifier = "EventsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "EventsTableViewCell", bundle: nil)
    }
    var delegate: EventsTableViewCellProtocol?

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
    
    @IBAction func joinBtnSelected(_ sender: Any) {
//        self.delegate?.joinBtnSelected(cell: self)
    }
    
}
