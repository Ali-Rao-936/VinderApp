//
//  AcceptedEventVC.swift
//  VinderApp
//
//  Created by iOS Dev on 18/10/2023.
//

import UIKit

class AcceptedEventVC: UIViewController {
    
    @IBOutlet weak var eventsListTableView: UITableView!
    
    var acceptedEventViewModel: EventViewModel?
    var eventArray = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        initialSetup()
        callToViewModelForUIUpdate()
    }
    
    func initialSetup(){
        // Register tableView cells
        self.eventsListTableView.register(EventsTableViewCell.nib(), forCellReuseIdentifier: EventsTableViewCell.identifier)
    }
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
        acceptedEventViewModel = EventViewModel(eventType: .acceptedEvent)
        
        CommonFxns.showProgress()
        self.acceptedEventViewModel?.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.eventArray = acceptedEventViewModel?.eventList?.data ?? []
        eventsListTableView.reloadData()
    }
}

extension AcceptedEventVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard  let allEventsCell = self.eventsListTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier , for: indexPath) as? EventsTableViewCell else {
            return cell
        }
        let dict = self.eventArray[indexPath.row]
        allEventsCell.viewBtn.isHidden = true
        allEventsCell.eventNameLbl.text = dict.name?.capitalized
        allEventsCell.eventCreatedByUserLbl.text = String(dict.userId ?? zero)
        allEventsCell.noOfPeopleJoinedLbl.text = "\(dict.peopleJoinedCount ?? 0) People joined"
        allEventsCell.noOfPeopleJoinedLbl.textColor = .darkGray
        allEventsCell.eventCreatedByUserLbl.text = dict.creator?.name ?? emptyStr
        // 2023-10-26
        let date = CommonFxns.changeDateToFormat(date: dict.date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
        print(date)
        allEventsCell.dateTimeLbl.text = "\(date), \(dict.time ?? emptyStr)"
        
        let imgrUrl = dict.bannerImage?.image ?? emptyStr
        allEventsCell.eventImgView.sd_setImage(with: URL(string: imgrUrl), placeholderImage:UIImage(named: "defaultEventImg"), options: .allowInvalidSSLCertificates, completed: nil)
        
        return allEventsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
        eventDetailVCObj.eventType = .acceptedEvent
        eventDetailVCObj.selectedEventId = self.eventArray[indexPath.row].eventId ?? 0
        self.navigationController?.pushViewController(eventDetailVCObj, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 130 // all events
    }
    
}
