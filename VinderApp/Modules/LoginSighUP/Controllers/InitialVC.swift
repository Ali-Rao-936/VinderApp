//
//  InitialVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class InitialVC: UIViewController {

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginWithEmailBtnAction(_ sender: Any) {
//        let otherVCObj = LoginVC(nibName: enumViewControllerIdentifier.loginVC.rawValue, bundle: nil)
//        self.navigationController?.pushViewController(otherVCObj, animated: true)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.loginVC.rawValue) as! LoginVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }
    
    @IBAction func createAccountBtnAction(_ sender: Any) {

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.createAccountVC.rawValue) as! CreateAccountVC
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }

}
