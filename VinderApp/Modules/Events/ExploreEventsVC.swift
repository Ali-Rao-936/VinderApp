//
//  ExploreEventsVC.swift
//  VinderApp
//
//  Created by ios Dev on 28/09/2023.
//

import UIKit

class ExploreEventsVC: UIViewController, ExploreEventsTableViewCellProtocol, EventsVCTableViewHeaderProtocol {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var eventsListTableView: UITableView!
    
    var hotEventsArr = [EventModel]()
    var allEventsArr = [EventModel]()
    let eventsHeadingsList = ["Hot events", "More events"]
    
    let viewModel = EventsViewModel(apiService: EventsWebServices())
    var firstTime = true

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
        
        self.getEventsList()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register tableView cells
        self.eventsListTableView.register(EventsTableViewCell.nib(), forCellReuseIdentifier: EventsTableViewCell.identifier)
        self.eventsListTableView.register(ExploreEventsTableViewCell.nib(), forCellReuseIdentifier: ExploreEventsTableViewCell.identifier)

        // register tableView header
        self.eventsListTableView.register(EventsVCTableViewHeader.nib(), forHeaderFooterViewReuseIdentifier: EventsVCTableViewHeader.identifier)
        // Add empty space at bottom of the inner scroll view of Table view
        self.eventsListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func segmentControlValuechanged(_ sender: Any) {
    }
    
    // Actions
    func joinBtnSleceted(cell: ExploreEventsTableViewCell, row: Int) {
        print("Join btn sleceted event table view cell....")
        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
        otherVCObj.eventType = eventType.joinEvent.rawValue
        otherVCObj.selectedEventId = self.hotEventsArr[row].eventId ?? 0
        self.navigationController?.pushViewController(otherVCObj, animated: true)

    }

    func viewBtnSleceted(cell: ExploreEventsTableViewCell, row: Int) {
        print("viewBtnSleceted....", viewBtnSleceted)
    }
//
//    func joinBtnSelected(cell: EventsTableViewCell) {
//        print("Join btn sleceted event table view cell....")
//        if let indexPath = self.eventsListTableView.indexPath(for: cell)?.row{
//            let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
//            otherVCObj.eventType = eventType.joinEvent.rawValue
//            otherVCObj.selectedEventId = self.allEventsArr[indexPath].eventId ?? 0
//            self.navigationController?.pushViewController(otherVCObj, animated: true)
//        }
//
//    }
        
    func createEventBtnSelected(header: EventsVCTableViewHeader) {
        print("Create btn of header...")
        let otherVCObj = CreateEventVC(nibName: enumViewControllerIdentifier.createEventVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    // MARK: - Networking
        
    private func getEventsList() {
        self.activityIndicatorStart()

        viewModel.getEventsList(subUrl: enumForAPIsEndPoints.eventsList.rawValue)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetchforList = { data in
        
            print("data...", data)
            var eventsList = [EventModel]()
            for item in data {
                let event = EventModel(with: item)
                eventsList.append(event)
                print("name....", event.name ?? emptyStr)
            }

            self.hotEventsArr = eventsList
            self.allEventsArr = eventsList
            self.eventsListTableView.reloadData()
            self.activityIndicatorStop()

        }
    }

    // MARK: - UI Setup
    
    // Code for show activity indicator view
    private func activityIndicatorStart() {
        CommonFxns.showProgress()
    }
    
    // Code for stop activity indicator view
    private func activityIndicatorStop() {
        CommonFxns.dismissProgress()
    }

}

extension ExploreEventsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // Hot events collection
        default:
            return self.allEventsArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 241 // about
        default:
            return 130 // event
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventsHeadingsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            guard  let hotEventsCell = self.eventsListTableView.dequeueReusableCell(withIdentifier: ExploreEventsTableViewCell.identifier , for: indexPath) as? ExploreEventsTableViewCell else {
                return cell
            }
            if firstTime && self.hotEventsArr.count > 0{
                hotEventsCell.hotEventsCollectionViewCell.reloadData()
                hotEventsCell.configCell(events: hotEventsArr)
                firstTime = false
            }

            hotEventsCell.delegate = self
            return hotEventsCell
            
        default:
            guard  let allEventsCell = self.eventsListTableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier , for: indexPath) as? EventsTableViewCell else {
                return cell
            }
//            allEventsCell.delegate = self
            
            let dict = self.allEventsArr[indexPath.row]
            allEventsCell.eventNameLbl.text = dict.name
            allEventsCell.eventCreatedByUserLbl.text = String(dict.userId ?? zero)
            allEventsCell.noOfPeopleJoinedLbl.text = "\(dict.attendeesCount) People joined"
            allEventsCell.eventCreatedByUserLbl.text = dict.creator.name ?? emptyStr
            // 2023-10-26
            let date = CommonFxns.changeDateToFormat(date: dict.date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
            print(date)
            allEventsCell.dateTimeLbl.text = "\(date), \(dict.time ?? emptyStr)"
            
            let imgrUrl = dict.bannerImage?.threeX ?? emptyStr
            allEventsCell.eventImgView.sd_setImage(with: URL(string: imgrUrl), placeholderImage:UIImage(named: "defaultEventImg"), options: .allowInvalidSSLCertificates, completed: nil)

            return allEventsCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = UITableViewHeaderFooterView()
        
        guard  let headerView = self.eventsListTableView.dequeueReusableHeaderFooterView(withIdentifier: EventsVCTableViewHeader.identifier) as? EventsVCTableViewHeader else {
            
            return cell
        }
        headerView.delegate = self
        headerView.headingLbl.text = self.eventsHeadingsList[section]

        if section == 1{
            headerView.createEventBtn.isHidden = false
        }else{
            headerView.createEventBtn.isHidden = true
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
        otherVCObj.eventType = eventType.joinEvent.rawValue
        otherVCObj.selectedEventId = self.allEventsArr[indexPath.row].eventId ?? 0
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
}


