//
//  ExploreUserVC.swift
//  VinderApp
//
//  Created by ios Dev on 25/09/2023.
//

import UIKit

class ExploreUserVC: UIViewController {

    // MARK: - Outlets & Properties
    
//    @IBOutlet weak var teamImgView: UIImageView!
//    var selectedIndexRow = Int()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
