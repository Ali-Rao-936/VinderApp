//
//  InviteFriendsVC.swift
//  VinderApp
//
//  Created by ios Dev on 22/09/2023.
//

import UIKit

class InviteFriendsVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var listTableView: UITableView!
    
    var upcomingEventsList = [EventModel]()
    var pastEventsList = [EventModel] ()
    var events = [EventModel] ()

    let viewModel = EventsViewModel(apiService: EventsWebServices())
    var firstTime = true
    
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
    
    @IBAction func sendInvitationBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
