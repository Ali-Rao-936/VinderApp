//
//  MyEventsVC.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit
import JJFloatingActionButton

class MyEventsVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var upcomingEventsList = [Event]()
    var pastEventsList = [Event] ()
    var events = [Event]()

    var upcomingEventViewModel: EventViewModel?
    var pastEventViewModel: EventViewModel?
    
    var firstTime = true
    var eventType: EventType?
    fileprivate let addEventButton = JJFloatingActionButton()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        initialSetup()
        callToViewModelForUIUpdate()
    }
   
    //MARK:- View setup
    func callToViewModelForUIUpdate() {
            eventType = .upcoming
            upcomingEventViewModel = EventViewModel(eventType: .upcoming)
            pastEventViewModel = EventViewModel(eventType: .past)
            
            CommonFxns.showProgress()
            self.upcomingEventViewModel?.bindViewModelToController = {
                self.updateDataSource()
            }
            
            self.pastEventViewModel?.bindViewModelToController = {
                self.updateDataSource()
            }
    }
    
    func updateDataSource() {
        self.upcomingEventsList = upcomingEventViewModel?.eventList?.data ?? []
        self.events = upcomingEventsList // default upcoming events displayed
        self.pastEventsList = pastEventViewModel?.eventList?.data ?? []
        myEventsCollectionView.reloadData()
    }
    
    func reloadEvents() {
        callToViewModelForUIUpdate()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register tableView cells
        self.myEventsCollectionView.register(EventsCollectionViewCell.nib(), forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)

        addEventButton.addItem(title: "Create Event", image: #imageLiteral(resourceName: "addEvent")) { [weak self] item in
            let otherVCObj = CreateEventVC(nibName: enumViewControllerIdentifier.createEventVC.rawValue, bundle: nil)
            otherVCObj.callBackFromEventCreated = self?.reloadEvents
            self?.navigationController?.pushViewController(otherVCObj, animated: true)
        }

        addEventButton.addItem(title: "Accepted Event", image: #imageLiteral(resourceName: "joinedEvent")) { item in
            let otherVCObj = AcceptedEventVC(nibName: enumViewControllerIdentifier.acceptedEventVC.rawValue, bundle: nil)
            self.navigationController?.pushViewController(otherVCObj, animated: true)
        }
        addEventButton.display(inViewController: self)
    }
    
    func showEventDetails(eventType: EventType, index: Int) {
        let eventDetailVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
        eventDetailVCObj.eventType = eventType
        if eventType == .upcoming {
            eventDetailVCObj.selectedEventId = self.upcomingEventsList[index].eventId ?? 0
        }else { // Past Events
            eventDetailVCObj.selectedEventId = self.pastEventsList[index].eventId ?? 0
        }
        self.navigationController?.pushViewController(eventDetailVCObj, animated: true)
    }
    
    // MARK: - Button Actions
    
//    @IBAction func backBtnAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.events = self.upcomingEventsList
            eventType = .upcoming
        }else{
            self.events = self.pastEventsList
            eventType = .past
        }
        self.myEventsCollectionView.reloadData()
    }

    // MARK: - Networking
        
//    private func getEventsList(subUrl: String, upcomingEvent: Bool) {
//        self.activityIndicatorStart()
//
//        viewModel.getEventsList(subUrl: subUrl)
// 
//        viewModel.showAlertClosure = {
//            msg in
//            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
//            self.activityIndicatorStop()
//            self.refreshControl.endRefreshing()
//        }
//    
//        viewModel.didFinishFetchforList = { data in
//            self.refreshControl.endRefreshing()
//            var eventsList = [EventModel]()
//            for item in data {
//                let event = EventModel(with: item)
//                eventsList.append(event)
//                print(event.name ?? emptyStr)
//            }
//
//            if upcomingEvent{
//                self.upcomingEventsList = eventsList
//                self.events = self.upcomingEventsList
//            }else{
//                self.pastEventsList = eventsList
//                self.events = self.pastEventsList
//            }
//            self.myEventsCollectionView.reloadData()
//            self.activityIndicatorStop()
//        }
//    }

//    // MARK: - UI Setup
//    
//    // Code for show activity indicator view
//    private func activityIndicatorStart() {
//        CommonFxns.showProgress()
//    }
//    
//    // Code for stop activity indicator view
//    private func activityIndicatorStop() {
//        CommonFxns.dismissProgress()
//    }

}

// MARK: - CollectionView Delegates & Datasource

extension MyEventsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.identifier, for: indexPath) as? EventsCollectionViewCell else{
            return cell
        }

        let dict = self.events[indexPath.row]
        
        listCell.eventNameLbl.text = dict.name
        listCell.eventCreatedByUserLbl.text = String(dict.userId ?? zero)
        
        listCell.hotEventView.isHidden = true
      
        if segmentControl.selectedSegmentIndex == 0 { // Upcoming
            listCell.completedEventView.isHidden = true
        }else { // Past
            listCell.completedEventView.isHidden = false
        }
        
        listCell.noOfPeopleJoinedLbl.text = "\(dict.peopleJoinedCount ?? 0) People joined"
        listCell.eventCreatedByUserLbl.text = dict.creator?.name ?? emptyStr
        // 2023-10-26
        let date = CommonFxns.changeDateToFormat(date: dict.date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
        print(date)
        listCell.dateTimeLbl.text = "\(date), \(dict.time ?? emptyStr)"
        listCell.viewBtn.tag = indexPath.row
        listCell.viewBtn.addTarget(self, action:#selector(viewEvent(sender:)) , for: .touchUpInside)
        
        let imgrUrl = dict.bannerImage?.image ?? emptyStr
        listCell.eventImgView.sd_setImage(with: URL(string: imgrUrl), placeholderImage:UIImage(named: "defaultEventImg"), options: .allowInvalidSSLCertificates, completed: nil)
        
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: self.myEventsCollectionView.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedEventId = self.events[indexPath.row].eventId
        print("View Btn Sleected....")
        
        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
        otherVCObj.selectedEventId = selectedEventId ?? zero
        otherVCObj.eventType = self.eventType
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
    @objc func viewEvent(sender: UIButton) {
        if segmentControl.selectedSegmentIndex == 0 { //Upcoming
            showEventDetails(eventType: .upcoming, index: sender.tag)
        }else { //Past
            showEventDetails(eventType: .past, index: sender.tag)
        }
        
    }
}
