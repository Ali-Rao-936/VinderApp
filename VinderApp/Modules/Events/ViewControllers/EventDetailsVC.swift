//
//  EventDetailsVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import CoreLocation

//enum EventType : Int{
//    case joinEvent = 1
//    case alreadyJoined = 2
//    case pastEvent = 3
//}

class EventDetailsVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var joinEventBtn: UIButton!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventCreateByUserLbl: UILabel!
    @IBOutlet weak var eventJoineesLbl: UILabel!
    @IBOutlet weak var eventDescLbl: UILabel!
    @IBOutlet weak var eventLocationLbl: UILabel!
    @IBOutlet weak var eventDateLbl: UILabel!
    @IBOutlet weak var eventTimeLbl: UILabel!
    @IBOutlet weak var eventPriceLbl: UILabel!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var eventCategoryBtn: UIButton!
    
    var viewModel: EventViewModel?
    
    var selectedEventId = Int()
    var eventType: EventType?
    var isAttendingEvent = false
    var event: Event?
    var callBack : (()-> Void)?
   
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
    
        callToViewModelForUIUpdate()
    }
    
    // MARK: - Methods
    
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
        CommonFxns.showProgress()
        viewModel = EventViewModel(eventType: .eventDetail, eventID: selectedEventId)
        self.viewModel?.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.event = viewModel?.eventDetail.data
        showDataOnScreen()
    }
    
    func showDataOnScreen() {
        let imgrUrl = event?.bannerImage?.image ?? emptyStr
        self.eventImgView.sd_setImage(with: URL(string: imgrUrl), placeholderImage:UIImage(named: "setUpProfileBgImg"), options: .allowInvalidSSLCertificates, completed: nil)
        self.eventNameLbl.text = event?.name
        self.eventDateLbl.text = CommonFxns.changeDateToFormat(date: event?.date ?? emptyStr, format: "dd MMM", currentFormat: "yyyy-mm-dd")
        self.eventTimeLbl.text = event?.time
        self.eventCreateByUserLbl.text = "by \(String(describing: event?.creator?.name))"
        self.eventDescLbl.text = event?.description
        self.eventJoineesLbl.text = "\(event?.peopleJoinedCount ?? 0) people joined"
        self.eventCategoryBtn.setTitle(event?.interest?.name ?? emptyStr, for: .normal)
        AppDelegate.shared.getAddressFromLatLon(latitude: event?.latitude ?? 0.0, longitude: event?.longitude ?? 0.0){ (address) in
            self.eventLocationLbl.text = address
        }
       
      //  self.eventLocationLbl.text = address
        
        if event?.isPaid == 0 {
            self.eventPriceLbl.text = "Free"
        }else{
            self.eventPriceLbl.text = "Paid $\(String(describing: event?.price))"
        }
   
     //   self.isAttendingEvent = event.attending ?? false
        if self.eventType == .upcoming { //User created Upcoming match, so no option of JOIN, only he can invite others
            self.joinEventBtn.isHidden = true
            self.inviteBtn.isHidden = false
        }else if self.eventType == .past || self.eventType == .acceptedEvent {
            self.joinEventBtn.isHidden = true
            self.inviteBtn.isHidden = true
        }else { // hot and All event
            self.joinEventBtn.isHidden = false
            self.inviteBtn.isHidden = true
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinEventBtnAction(_ sender: Any) {
      self.joinEvent()
    }

    @IBAction func inviteBtnAction(_ sender: Any) {
        let otherVCObj = InviteFriendsVC(nibName: enumViewControllerIdentifier.inviteFriendsVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }
    // MARK: - Networking
        
//    private func getEventDetail(subUrl: String) {
//        self.activityIndicatorStart()
//
//        viewModel.getEventDetail(subUrl: subUrl)
// 
//        viewModel.showAlertClosure = {
//            msg in
//            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
//            self.activityIndicatorStop()
//        }
//    
//        viewModel.didFinishFetch = { data in
//
//            let event = EventModel(with: data)
//            
//            self.showDataOnScreen(event: event)
//            print("address...", event.latitude ?? emptyStr, event.longitude ?? emptyStr)
//
//            self.getAddressFromLatLon(pdblLatitude: String(event.latitude ?? 0.0), withLongitude: String(event.longitude ?? 0.0))
//            
//            if let interestData = data["interest"] as? [String: Any]{
//                let interest = SportsInterests(with: interestData)
//                self.eventCategoryBtn.setTitle(interest.name ?? emptyStr, for: .normal)
//            }
//            self.activityIndicatorStop()
//        }
//    }
    
    private func joinEvent() {
        CommonFxns.showProgress()
        
        viewModel = EventViewModel(eventType: .joinEvent, eventID: selectedEventId)
        viewModel?.bindViewModelToController = { [self] in
            let message = viewModel?.eventDetail.messages?.first ?? "Success"
            CommonFxns.showAlert(self, message: message, title: "")
            callBack?()
        }
        self.navigationController?.popViewController(animated: true)
        
//        viewModel.showAlertClosure = {
//            msg in
//            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
//            self.activityIndicatorStop()
//        }
//    
//        viewModel.didFinishFetch = { data in
//        
//            print("data...", data)
//            self.navigationController?.popViewController(animated: true)
//            self.activityIndicatorStop()
//        }
    }

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
    
    // MARK: - Others
    
//    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
//        
//        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//        let lat: Double = Double("\(pdblLatitude)") ?? 0.0
//            //21.228124
//        let lon: Double = Double("\(pdblLongitude)") ?? 0.0
//            //72.833770
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    let pm = placemarks! as [CLPlacemark]
//
//                    if pm.count > 0 {
//                        let pm = placemarks![0]
//                        print(pm.country)
//                        print(pm.locality)
//                        print(pm.subLocality)
//                        print(pm.thoroughfare)
//                        print(pm.postalCode)
//                        print(pm.subThoroughfare)
//                        var addressString : String = ""
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//                        }
//                        if pm.country != nil {
//                            addressString = addressString + pm.country! + ", "
//                        }
//                        if pm.postalCode != nil {
//                            addressString = addressString + pm.postalCode! + " "
//                        }
//
//                        print(addressString)
//                        self.eventLocationLbl.text = addressString
//                  }
//            })
//        }
}

