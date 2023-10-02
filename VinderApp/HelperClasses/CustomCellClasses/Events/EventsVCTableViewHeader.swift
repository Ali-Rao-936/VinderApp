//
//  EventsVCTableViewHeader.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

protocol EventsVCTableViewHeaderProtocol {
    func createEventBtnSelected(header: EventsVCTableViewHeader)
}

class EventsVCTableViewHeader: UITableViewHeaderFooterView {

    // MARK: - Outlets & Properties

    @IBOutlet weak var createEventBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!

    var delegate: EventsVCTableViewHeaderProtocol?
    
    static let identifier = "EventsVCTableViewHeader"
    static func nib() -> UINib{
        return UINib(nibName: "EventsVCTableViewHeader", bundle: nil)
    }

    // MARK: - Button Actions
    
    @IBAction func createEventBtnSelected(_ sender: Any) {
        self.delegate?.createEventBtnSelected(header: self)
    }

}
