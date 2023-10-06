//
//  ContentVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class ContentVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    var contentType = String()
    var heading = String()
    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        self.titleLbl.text = self.heading
        
        // Network call
        self.getContent(url: enumForAPIsEndPoints.getContent.rawValue + contentType)
    }
    
    func readHTMLText(htmlText: String){
        let encodedData = htmlText.data(using: String.Encoding.utf8)!
        var attributedString: NSAttributedString

        do {
            attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
            
            self.contentLbl.attributedText = attributedString
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("error")
        }
    }
    
    // MARK: - Networking

    private func getContent(url: String) {
       
       self.activityIndicatorStart()

       viewModel.getContent(subUrl: url)
        
       viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
       viewModel.didFinishFetch = { data in
           
           print("data...", data)
           let text = data["text"] as? String ?? emptyStr
           self.readHTMLText(htmlText: text)
           self.activityIndicatorStop()
       }
    }
    
    // MARK: - UI Setup

    private func activityIndicatorStart() {
       // Code for show activity indicator view
//        self.loader.startAnimating()
       CommonFxns.showProgress()
    }

    private func activityIndicatorStop() {
       // Code for stop activity indicator view
//        self.loader.stopAnimating()
       CommonFxns.dismissProgress()
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
