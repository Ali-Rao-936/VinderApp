//
//  EventDetailsVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import CoreLocation

enum eventType : Int{    
    case joinEvent = 1
    case alreadyJoined = 2
    case pastEvent = 3
}

class EventDetailsVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var joinEventBtn: UIButton!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventCreateByUserLbl: UILabel!
    @IBOutlet weak var eventJoineesLbl: UILabel!
    @IBOutlet weak var eventDescLbl: UILabel!
    @IBOutlet weak var eventLocationLbl: UILabel!
    @IBOutlet weak var eventDateLbl: UILabel!
    @IBOutlet weak var eventTimeLbl: UILabel!
    @IBOutlet weak var eventPriceLbl: UILabel!
    @IBOutlet weak var eventImagesCollectionView: UICollectionView!

    let viewModel = EventsViewModel(apiService: EventsWebServices())
    
    var selectedEventId = Int()
    var eventType = Int()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
        
        print("eventID...", self.selectedEventId)
        let subUrl = "event/list?event_id=\(self.selectedEventId)"
        self.getEventDetail(subUrl: subUrl)
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register CollectionView cell
        self.eventImagesCollectionView.register(EventImagesCollectionViewCell.nib(), forCellWithReuseIdentifier: EventImagesCollectionViewCell.identifier)
    }
    
    var isAttendingEvent = false
    func showDataOnScreen(event: EventModel){
        self.eventNameLbl.text = event.name
        self.eventDateLbl.text = event.date
        self.eventTimeLbl.text = event.time
        self.eventDescLbl.text = event.description
        if event.isPaid == "0"{
            self.eventPriceLbl.text = "Free"
        }else{
            self.eventPriceLbl.text = "$\(String(describing: event.isPaid))"
        }
        self.isAttendingEvent = event.attending ?? false
        if event.attending ?? false{
            self.joinEventBtn.setTitle("Invite Others  ", for: .normal)
            self.joinEventBtn.layer.borderColor = primaryColor.cgColor
            self.joinEventBtn.layer.borderWidth = 1.0
            self.joinEventBtn.backgroundColor = UIColor.white
            self.joinEventBtn.setTitleColor(primaryColor, for: .normal)
            self.joinEventBtn.tintColor = primaryColor
        }else{
            self.joinEventBtn.setTitle("Join Event  ", for: .normal)
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinEventBtnAction(_ sender: Any) {
        
        if !self.isAttendingEvent{
            let dict = ["event_id" : self.selectedEventId]
            self.joinEvent(dict: dict, subUrl: "user/events/join")
        }
    }

    // MARK: - Networking
        
    private func getEventDetail(subUrl: String) {
        self.activityIndicatorStart()

        viewModel.getEventDetail(subUrl: subUrl)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
        
            print("data...", data)
            let event = EventModel(with: data)
            
            print("event...", event)
            self.showDataOnScreen(event: event)
            print("address...", event.latitude ?? emptyStr, event.longitude ?? emptyStr)

            self.getAddressFromLatLon(pdblLatitude: String(event.latitude ?? 0.0), withLongitude: String(event.longitude ?? 0.0))
            
//            address.trimmingCharacters(in: CharacterSet.newlines)
            self.activityIndicatorStop()
        }
    }
    
    private func joinEvent(dict: [String: Any], subUrl: String) {
        self.activityIndicatorStart()

        viewModel.joinEvent(params: dict, subUrl: subUrl)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
        
            print("data...", data)
            self.navigationController?.popViewController(animated: true)
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
    
    // MARK: - Others
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)") ?? 0.0
            //21.228124
        let lon: Double = Double("\(pdblLongitude)") ?? 0.0
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        print(addressString)
                        self.eventLocationLbl.text = addressString
                  }
            })
        }

}

// MARK: - CollectionView Delegates & Datasource

extension EventDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.eventImagesCollectionView.dequeueReusableCell(withReuseIdentifier: EventImagesCollectionViewCell.identifier, for: indexPath) as? EventImagesCollectionViewCell else{
            return cell
        }
//        listCell.delegate = self
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: self.eventImagesCollectionView.frame.width/2-10, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = self.playersList[indexPath.row]
//        self.goToPlayerDetailScreen(dict: dict)
    }
    
}
