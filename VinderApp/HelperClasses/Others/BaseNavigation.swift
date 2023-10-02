//
//  BaseNavigation.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import UIKit

class BaseNavigation: UINavigationController {

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }

    // MARK: - Methods

    func initialSetup(){
        self.navigationBar.isHidden = true
        self.navigationBar.backgroundColor = UIColor.red
        self.navigationController?.navigationBar.isHidden = true
    }

}
