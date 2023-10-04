//
//  MyEventsVC.swift
//  VinderApp
//
//  Created by ios Dev on 21/09/2023.
//

import UIKit

class MyEventsVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
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
        // Register tableView cells
        self.myEventsCollectionView.register(EventsCollectionViewCell.nib(), forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)

        // Initial Setup
        self.events = self.upcomingEventsList
        // Network call
        self.getEventsList(subUrl: "events/upcoming", upcomingEvent: true)
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.events = self.upcomingEventsList
        }else{
            if firstTime{
                self.getEventsList(subUrl: "events/past", upcomingEvent: false)
                self.firstTime = false
            }
            self.events = self.pastEventsList
        }
        self.myEventsCollectionView.reloadData()
    }
    
    // Actions
//
//    func joinBtnSelected(cell: EventsCollectionViewCell) {
//        print("joinBtnSelected....")
//
//        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
//        otherVCObj.eventType = eventType.joinEvent.rawValue
//        self.navigationController?.pushViewController(otherVCObj, animated: true)
//    }
//
//    func viewBtnSelected(cell: EventsCollectionViewCell) {
//        print("View Btn Sleected....")
//
//        let otherVCObj = EventDetailsVC(nibName: enumViewControllerIdentifier.eventDetailsVC.rawValue, bundle: nil)
//        otherVCObj.eventType = eventType.alreadyJoined.rawValue
//        self.navigationController?.pushViewController(otherVCObj, animated: true)
//
//    }
    
    // MARK: - Networking
        
    private func getEventsList(subUrl: String, upcomingEvent: Bool) {
        self.activityIndicatorStart()

        viewModel.getEventsList(subUrl: subUrl)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetchforList = { data in
        
            var eventsList = [EventModel]()
            for item in data {
                let event = EventModel(with: item)
                eventsList.append(event)
                print(event.name ?? emptyStr)
            }

            if upcomingEvent{
                self.upcomingEventsList = eventsList
                self.events = self.upcomingEventsList
            }else{
                self.pastEventsList = eventsList
                self.events = self.pastEventsList
            }
            self.myEventsCollectionView.reloadData()
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

// MARK: - CollectionView Delegates & Datasource

extension MyEventsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.events.count
//        switch self.segmentControl.selectedSegmentIndex {
//        case 0:
//            return self.upcomingEventsList.count
//        default:
//            return self.pastEventsList.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.identifier, for: indexPath) as? EventsCollectionViewCell else{
            return cell
        }
//        listCell.delegate = self

        listCell.joinBtn.isHidden = true
        listCell.viewBtn.isHidden = false
        
        let dict = self.events[indexPath.row]
        
        listCell.eventNameLbl.text = dict.name
        listCell.eventCreatedByUserLbl.text = String(dict.userId ?? zero)
        if segmentControl.selectedSegmentIndex == 0{
            listCell.completedEventView.isHidden = true
        }else{
            listCell.completedEventView.isHidden = false
        }
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
        
        otherVCObj.eventType = eventType.alreadyJoined.rawValue
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    
}
