//
//  ChooseGenderVC.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit

class ChooseGenderVC: UIViewController {

    // MARK: - Outlets & Properties

    @IBOutlet weak var maleLbl: UILabel!
    @IBOutlet weak var femaleLbl: UILabel!
    @IBOutlet weak var maleBgView: UIView!
    @IBOutlet weak var femaleBgView: UIView!
        
    var selectedGender = String()

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
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if !selectedGender.isEmpty{
            let otherVCObj = CompleteProfileVC(nibName: enumViewControllerIdentifier.completeProfileVC.rawValue, bundle: nil)
            otherVCObj.selectedGender = self.selectedGender
            self.navigationController?.pushViewController(otherVCObj, animated: true)
        }
    }
    
    @IBAction func chooseGenderBtnAction(_ sender: UIButton) {
        if sender.tag == one{
            self.femaleBgView.backgroundColor = primaryColorWithAlpha
            self.femaleBgView.layer.borderColor = primaryColor.cgColor
            self.femaleLbl.textColor = UIColor.white

            self.maleBgView.backgroundColor = UIColor.white
            self.maleBgView.layer.borderColor = UIColor.lightGray.cgColor
            self.maleLbl.textColor = UIColor.lightGray
            
            self.selectedGender = gender.female.rawValue
        }else{
            self.maleBgView.backgroundColor = primaryColorWithAlpha
            self.maleBgView.layer.borderColor = primaryColor.cgColor
            self.maleLbl.textColor = UIColor.white

            self.femaleBgView.backgroundColor = UIColor.white
            self.femaleBgView.layer.borderColor = UIColor.lightGray.cgColor
            self.femaleLbl.textColor = UIColor.lightGray
            self.selectedGender = gender.male.rawValue
        }
    }
    
}
