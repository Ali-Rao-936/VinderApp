//
//  EventsVCTableViewHeader.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

class EventsVCTableViewHeader: UITableViewHeaderFooterView {

    // MARK: - Outlets & Properties
    @IBOutlet weak var headingLbl: UILabel!

    static let identifier = "EventsVCTableViewHeader"
    static func nib() -> UINib{
        return UINib(nibName: "EventsVCTableViewHeader", bundle: nil)
    }

    // MARK: - Button Actions
   
}
