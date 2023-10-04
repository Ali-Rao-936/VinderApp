//
//  MapViewVC.swift
//  VinderApp
//
//  Created by ios Dev on 04/10/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print("didUpdateFocus")
    }
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var mapView: MKMapView!
//    var selectedIndexRow = Int()
    var locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        self.mapViewSetup()
    }
    
    // Add this function to your program
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        print("didUpdateLocations///", locations)
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // set the value of lat and long
        latitude = location.latitude
        longitude = location.longitude
        
        
        // MAP View Setup
        mapView.mapType = MKMapType.standard

          // 2)
          // 3)
          let span = MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)//MKCoordinateSpanMake(0.05, 0.05)
          let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)

          // 4)
          let annotation = MKPointAnnotation()
          annotation.coordinate = location
          annotation.title = "iOSDevCenter-Kirit Modi"
          annotation.subtitle = "Ahmedabad"
        mapView.addAnnotation(annotation)

    }
    
    func mapViewSetup(){
        

        // in the function you want to grab the user's location from
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        // You will need to update your .plist file to request the authorization
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        

    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
