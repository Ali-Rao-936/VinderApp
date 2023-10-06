//
//  MapViewVC.swift
//  VinderApp
//
//  Created by ios Dev on 04/10/2023.
//

import UIKit
import MapKit
import CoreLocation

struct Location{
    var name: String?
    var latitude: Double?
    var longitude: Double?

    init(name: String?, latitude: Double?, longitude: Double?){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

//    func toDictionary()->[String:Any]{
//        let dict:[String:Any] = ["event_id": eventId ?? emptyStr]
//        return dict
//    }
}

class MapViewVC : UIViewController, UISearchBarDelegate {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let locationManager = CLLocationManager()

    var locationArr = [Location]()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        self.searchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing/////,....")

        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing....")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search.......")
        self.performSearchRequest()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel.......")
        self.locationArr.removeAll()
        self.tableView.reloadData()
    }
    
    // MARK: - Button Action

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Method

    func performSearchRequest() {
        let request = MKLocalSearch.Request()
            let locationManager = CLLocationManager()
            guard let coordinate = locationManager.location?.coordinate else { return }

        request.naturalLanguageQuery = self.searchBar.text
        request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 3200, longitudinalMeters: 3200)
            // about a couple miles around you

            MKLocalSearch(request: request).start { (response, error) in
                guard error == nil else { return }
                guard let response = response else { return }
                guard response.mapItems.count > 0 else { return }

                let randomIndex = Int(arc4random_uniform(UInt32(response.mapItems.count)))
                let locationItems = response.mapItems[randomIndex]

                
                print("location Items....", locationItems)
            
                let location = Location(name: locationItems.name, latitude: locationItems.placemark.coordinate.latitude, longitude: locationItems.placemark.coordinate.longitude)
                
                print("location....", location)
                
                self.locationArr.append(location)
                self.tableView.reloadData()
//                for location in response.locationItems {
////                    let location = Location(name: location., latitude: loc, longitude: <#T##Double?#>)
////                    let location = Location(locationName: location.name!, location: "\(gyms.placemark.subLocality!)", "\(gyms.placemark.locality!)")
//                    self.locations.append(location)
//                    self.myTableView.reloadData()
//                }
            }
        }
}

//extension MapViewVC : UITextFieldDelegate{
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//
//        self.performSearchRequest()
//        return true
//    }
//}

// MARK: - TableView delegates & datasource

extension MapViewVC : CLLocationManagerDelegate{
  
    override class func didChangeValue(forKey key: String, withSetMutation mutationKind: NSKeyValueSetMutationKind, using objects: Set<AnyHashable>) {
        print("key....", key)

        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("manager....", manager)

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations....", locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error....", error)

    }
}


//extension ViewController : CLLocationManagerDelegate {
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.requestLocation()
//        }
//    }
//
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//
//
//            let span = MKCoordinateSpan(latitudeDelta: <#T##CLLocationDegrees#>, longitudeDelta: <#T##CLLocationDegrees#>)
//
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            mapView.setRegion(region, animated: true)
//        }
//    }
//
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print("error:: \(error)")
//    }
//}

extension MapViewVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.locationArr.count
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.locationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.locationArr[indexPath.row].name
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let locationObj = self.locationArr[indexPath.row]
        
        // Set data for Passing Data Post Notification - - - - -
        let objToBeSent = "Test Message from Notification"
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: locationObj)
        self.navigationController?.popViewController(animated: true)
    }
    
}


