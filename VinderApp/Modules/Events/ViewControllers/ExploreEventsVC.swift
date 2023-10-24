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
    
    var hotEventsArr = [Event]()
    var allEventsArr = [Event]()
    let eventsHeadingsList = ["Hot events", "More events"]
    
    var viewModel: EventViewModel?
    var firstTime = true

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        initialSetup()
        callToViewModelForUIUpdate()

    }
    
    // MARK: - Methods
    
    func initialSetup(){
      //  hideKeyboardWhenTappedAround() // hide keyboard
        // Register tableView cells
        self.eventsListTableView.register(EventsTableViewCell.nib(), forCellReuseIdentifier: EventsTableViewCell.identifier)
        self.eventsListTableView.register(ExploreEventsTableViewCell.nib(), forCellReuseIdentifier: ExploreEventsTableViewCell.identifier)

        // register tableView header
        self.eventsListTableView.register(EventsVCTableViewHeader.nib(), forHeaderFooterViewReuseIdentifier: EventsVCTableViewHeader.identifier)
        // Add empty space at bottom of the inner scroll view of Table view
        self.eventsListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
        viewModel = EventViewModel(eventType: .allEvents)
        CommonFxns.showProgress()
        self.viewModel?.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.allEventsArr = viewModel?.eventList.data ?? []
        self.hotEventsArr = viewModel?.eventList.data ?? []
        eventsListTableView.reloadData()
    }
   
    // MARK: - Button Actions

    // Actions
    func joinBtnSleceted(cell: ExploreEventsTableViewCell, row: Int) {
        print("Join btn sleceted event table view cell....")
        let eventDetailVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
      //  eventDetailVCObj.eventType = .
        eventDetailVCObj.selectedEventId = self.hotEventsArr[row].eventId ?? 0
        self.navigationController?.pushViewController(eventDetailVCObj, animated: true)
    }

    func createEventBtnSelected(header: EventsVCTableViewHeader) {
        print("Create btn of header...")
        let otherVCObj = CreateEventVC(nibName: enumViewControllerIdentifier.createEventVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
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
            return 241 // hot events
        default:
            return 130 // all events
        }
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40
//    }
    
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
                hotEventsCell.configCell(events: hotEventsArr)
                hotEventsCell.hotEventsCollectionView.reloadData()
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
            allEventsCell.noOfPeopleJoinedLbl.text = "\(dict.peopleJoinedCount ?? 0) People joined"
            allEventsCell.eventCreatedByUserLbl.text = dict.creator?.name ?? emptyStr
            // 2023-10-26
            let date = CommonFxns.changeDateToFormat(date: dict.date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
            print(date)
            allEventsCell.dateTimeLbl.text = "\(date), \(dict.time ?? emptyStr)"
            
            let imgrUrl = dict.bannerImage?.image ?? emptyStr
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
    //    otherVCObj.eventType = EventType.joinEvent.rawValue
        otherVCObj.selectedEventId = self.allEventsArr[indexPath.row].eventId ?? 0
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
}


// 130
