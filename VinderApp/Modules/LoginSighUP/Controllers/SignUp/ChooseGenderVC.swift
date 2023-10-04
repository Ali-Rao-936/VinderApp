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
        
        if sender.tag == zero{
            self.maleBgView.layer.borderColor = primaryColor.cgColor
            self.maleBgView.backgroundColor = primaryColorWithAlpha
            self.maleLbl.textColor = UIColor.white
            
            self.femaleBgView.layer.borderColor =  UIColor.gray.cgColor
            self.femaleBgView.backgroundColor = UIColor.white
            self.femaleLbl.textColor = UIColor.gray
            
            self.selectedGender = gender.male.rawValue
        }else{
            self.femaleBgView.layer.borderColor = primaryColor.cgColor
            self.femaleBgView.backgroundColor = primaryColorWithAlpha
            self.femaleLbl.textColor = UIColor.white
            
            self.maleBgView.layer.borderColor =  UIColor.gray.cgColor
            self.maleBgView.backgroundColor = UIColor.white
            self.maleLbl.textColor = UIColor.gray
            
            self.selectedGender = gender.male.rawValue
        }
    }
    
}
