//
//  VinderUserInfoTableViewHeader.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit
import TagListView

class VinderUserInfoTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Outlets & Properties
//
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var tagsView: TagListView!

    static let identifier = "VinderUserInfoTableViewHeader"
    static func nib() -> UINib{
        return UINib(nibName: "VinderUserInfoTableViewHeader", bundle: nil)
    }

    // MARK: - Methods

}
