//
//  CreateEventVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit
import LocationPicker
import CoreLocation
import MapKit

class CreateEventVC: UIViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var sportsCategoryCollectionView: UICollectionView!
    @IBOutlet weak var eventTitleTextField: UITextFieldCustomClass!
    @IBOutlet weak var startEventDateTextField: UITextFieldCustomClass!
    @IBOutlet weak var endEventDateTextField: UITextFieldCustomClass!
    @IBOutlet weak var startEventTimeTextField: UITextFieldCustomClass!
    @IBOutlet weak var endEventTimeTextField: UITextFieldCustomClass!
    @IBOutlet weak var locationTxtField: UITextFieldCustomClass!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var eventDescTxtView: UITextView!
    @IBOutlet weak var addEventImgView: UIImageView!
    @IBOutlet weak var addresstxtField: UITextField!

    fileprivate let pickerView = ToolbarPickerView()
    var selectedCellRow = 0
    var latitude = Double()
    var longitude = Double()

    let viewModel = EventsViewModel(apiService: EventsWebServices())
    var locationsArr = [Locations]()
    let authViewModel = AuthViewModel(apiService: AuthWebServices())
    let profileViewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())

    var selectedLocationId = zero
    var selectedImage: UIImage!
    let imagePicker = UIImagePickerController()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
        
        // add observer in controller(s) where you want to receive data
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register tableView cells
        self.sportsCategoryCollectionView.register(TagsCollectionViewCell.nib(), forCellWithReuseIdentifier: TagsCollectionViewCell.identifier)
        self.sportsCategoryCollectionView.allowsMultipleSelection = false
        self.startEventDateTextField.datePicker(target: self,
                                  doneAction: #selector(doneAction1),
                                  cancelAction: #selector(cancelAction),
                                                datePickerMode: .date)
        self.startEventTimeTextField.datePicker(target: self,
                                                doneAction: #selector(doneAction2),
                                  cancelAction: #selector(cancelAction),
                                                datePickerMode: .time)
        
        self.endEventDateTextField.datePicker(target: self,
                                  doneAction: #selector(doneAction3),
                                  cancelAction: #selector(cancelAction),
                                                datePickerMode: .date)
        
        self.endEventTimeTextField.datePicker(target: self,
                                  doneAction: #selector(doneAction4),
                                  cancelAction: #selector(cancelAction),
                                                datePickerMode: .time)
        
        self.locationTxtField.inputView = self.pickerView
        self.locationTxtField.inputAccessoryView = self.pickerView.toolbar

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
        
        // Network call
        self.getHomeAPI()
        self.getInterestsList()
    }
    
    //MARK: - - - - - Method for receiving Data through Post Notificaiton - - - - -
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Value of notification : ", notification.object ?? [:])
        if let location: Location = notification.object as? Location{
            self.addresstxtField.text = location.name
            self.latitude = location.latitude ?? 0.0
            self.longitude = location.longitude ?? 0.0
        }
    }
    
    // MARK: - Date Picker Actions
    
    @objc
    func cancelAction() {
        self.view.resignFirstResponder()
    }
    
    @objc
    func doneAction1(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.startEventDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.startEventDateTextField.text = dateString
            
            print(datePickerView.date)
            print(dateString)
            
            self.startEventDateTextField.resignFirstResponder()
        }
    }
    
    @objc
    func doneAction2(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.startEventTimeTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"//"yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.startEventTimeTextField.text = dateString
            
            print(datePickerView.date)
            print(dateString)
            
            self.startEventTimeTextField.resignFirstResponder()
            
        }
    }
    
    @objc
    func doneAction3(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.endEventDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.endEventDateTextField.text = dateString
            
            print(datePickerView.date)
            print(dateString)
            
            self.endEventDateTextField.resignFirstResponder()
            
        }
    }
    
    @objc
    func doneAction4(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.endEventTimeTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"//yyyy-MM-dd
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.endEventTimeTextField.text = dateString
            
            print(datePickerView.date)
            print(dateString)
            
            self.endEventTimeTextField.resignFirstResponder()
            
        }
    }
    
    

    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func inviteFriendsBtnAction(_ sender: Any) {
        print("inviteFriendsBtnAction...")
        let otherVCObj = InviteFriendsVC(nibName: enumViewControllerIdentifier.inviteFriendsVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
    }

    @IBAction func createEventBtnAction(_ sender: Any) {
        
        let name = CommonFxns.trimString(string: self.eventTitleTextField.text ?? emptyStr)
        let desc = CommonFxns.trimString(string: self.eventDescTxtView.text ?? emptyStr)
        let address = CommonFxns.trimString(string: self.addresstxtField.text ?? emptyStr)
        let startDate = self.startEventDateTextField.text ?? emptyStr
        let time = self.startEventTimeTextField.text ?? emptyStr

//        let invitees = [Int]()
        let locationId = self.selectedLocationId
        let isPaid = 0 // By default free
        
        let interestId = self.allSportsInterestsList[self.selectedCellRow].id ?? 0
        
        if name.isEmpty || desc.isEmpty || startDate.isEmpty || time.isEmpty || locationId == zero || address.isEmpty{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }else{
            if selectedImage != nil{
//                let dict = CreateEventRequest(name: name, description: desc, locationId: locationId, address: address, date: startDate, time: time, isPaid: isPaid, latitude: latitude, longitude: longitude, interestId: interestId).toDictionary()
//
//                print("dict...", dict)
                
                let dict = ["name": name, "description": desc, "location_id": "\(locationId)", "address": address, "date": startDate, "time_column": time, "is_paid": "\(isPaid)", "latitude": "\(latitude)", "longitude": "\(longitude)", "interest_id": "\(interestId)"] as [String : Any]
                
                print("dict...", dict)
                self.uploadEventImage(params: dict, image: self.selectedImage, subUrl: enumForAPIsEndPoints.createEvent.rawValue)

//                self.createEvent(dict: dict, subUrl: enumForAPIsEndPoints.createEvent.rawValue)
            }else{
                CommonFxns.showAlert(self, message: AlertMessages.CHOOSE_EVENT_IMAGE, title: AlertMessages.ALERT_TITLE)
            }
        }
    }
    
    @IBAction func addEventImgBtnAction(_ sender: Any) {
        
        print("addEventImgBtnAction")
        // To choose image from phone
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func turnOnReminderValueChanged(_ sender: Any) {
    }
    
    // Actions

    @IBAction func endEventTimeBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func startEventTimeBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func startEventDateBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func endEventDateBtnAction(_ sender: Any) {
        
    }
    @IBAction func chooseCountryBtnAction(_ sender: Any) {
    }
    
    @IBAction func chooseAddressBtnAction(_ sender: Any) {
        
        let otherVCObj = MapViewVC(nibName: enumViewControllerIdentifier.mapViewVC.rawValue, bundle: nil)
        self.navigationController?.pushViewController(otherVCObj, animated: true)
                
//        let locationPicker = LocationPickerViewController()
//
//        // you can optionally set initial location
//
//        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.331686, longitude: -122.030656), addressDictionary: nil)
//        let location = Location(name: "1 Infinite Loop, Cupertino", location: nil, placemark: placemark)
//        locationPicker.location = location
//
//        // button placed on right bottom corner
//        locationPicker.showCurrentLocationButton = true // default: true
//
//        // default: navigation bar's `barTintColor` or `UIColor.white`
//        locationPicker.currentLocationButtonBackground = .blue
//
//        // ignored if initial location is given, shows that location instead
//        locationPicker.showCurrentLocationInitially = true // default: true
////        locationPicker.mapView.showsUserLocation = true
//        locationPicker.mapType = .hybrid // default: .Hybrid
//
//        // for searching, see `MKLocalSearchRequest`'s `region` property
//        locationPicker.useCurrentLocationAsHint = true // default: false
//
//        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"
//
//        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"
//
//        locationPicker.searchBarStyle = .default
//
//        // optional region distance to be used for creation region when user selects place from search results
//        locationPicker.resultRegionDistance = 500 // default: 600
//
//        locationPicker.completion = { location in
//            // do some awesome stuff with location
//        }
//
//        navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    // MapViewVC
    @IBAction func eventCreatedBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Networking
    
    private func getInterestsList() {
       
       self.activityIndicatorStart()

        profileViewModel.getInterestsList()
        
        profileViewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
        profileViewModel.didFinishFetchforList = { data in
           print("data...", data)
           
           self.activityIndicatorStop()
           
           let tempData = data as [[String: Any]]
           var interests = [SportsInterests]()
           
           for item in tempData{
               let interest = SportsInterests(with: item)
               interests.append(interest)
           }
           self.allSportsInterestsList = interests
           self.sportsCategoryCollectionView.reloadData()
       }
    }

    private func createEvent(dict: [String: Any], subUrl: String) {
        self.activityIndicatorStart()

        viewModel.postEvent(params: dict, subUrl: subUrl)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
        
            print("data...", data)
            
            self.activityIndicatorStop()
        }
    }
    
    private func uploadEventImage(params: [String: Any], image: UIImage, subUrl: String) {
        self.activityIndicatorStart()

        viewModel.uploadEventImage(params: params, image: image, subUrl: subUrl)
 
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
            self.activityIndicatorStop()
        }
    
        viewModel.didFinishFetch = { data in
                    
            self.successView.isHidden = false
            self.activityIndicatorStop()
        }
    }
    
    private func getHomeAPI() {
       
       self.activityIndicatorStart()
        
        authViewModel.getAPI(url: enumForAPIsEndPoints.homeAPI.rawValue)
        authViewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
           CommonFxns.showAlert(self, message: msg, title:"Alert")
           self.activityIndicatorStop()
       }
       
        authViewModel.didFinishFetch = { data in
           print("data...", data)
  
            let countries = data["countries"] as? [[String: Any]] ?? []
            var locations = [Locations]()
            for item in countries{
                let country = Locations(with: item)
                locations.append(country)
            }
            self.locationsArr = locations
           self.activityIndicatorStop()
            self.pickerView.reloadAllComponents()
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
    
    var allSportsInterestsList = [SportsInterests]()

}

// MARK: - CollectionView Delegates & Datasource

extension CreateEventVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allSportsInterestsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.sportsCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.identifier, for: indexPath) as? TagsCollectionViewCell else{
            return cell
        }
        
        let dict = self.allSportsInterestsList[indexPath.row]
        listCell.tagLbl.text = dict.name
        
        listCell.tagImgView.sd_setImage(with: URL(string: dict.imgUrls?.threeX ?? emptyStr), placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
                
        if indexPath.row != self.selectedCellRow{
            listCell.tagView.layer.borderColor = UIColor.gray.cgColor
            listCell.tagLbl.textColor = UIColor.gray
        }else{
            listCell.tagView.layer.borderColor = primaryColor.cgColor
            listCell.tagLbl.textColor = primaryColor
        }
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 130, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TagsCollectionViewCell{
    
            cell.tagView.layer.borderColor = primaryColor.cgColor
            cell.tagLbl.textColor = primaryColor
        }
        self.selectedCellRow = indexPath.row
        self.sportsCategoryCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TagsCollectionViewCell{
            cell.tagView.layer.borderColor = UIColor.gray.cgColor
            cell.tagLbl.textColor = UIColor.gray
        }
    }
}

extension CreateEventVC: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.locationsArr.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.locationsArr[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.locationsArr.count > 0{
            self.locationTxtField.text = self.locationsArr[row].name
        }
    }
}

extension CreateEventVC: ToolbarPickerViewDelegate {

    func didTapDone() {
        
        if self.locationsArr.count > 0{
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.locationTxtField.text = self.locationsArr[row].name
            self.selectedLocationId = self.locationsArr[row].id ?? 0
        }

        self.locationTxtField.resignFirstResponder()
    }

    func didTapCancel() {
        self.locationTxtField.resignFirstResponder()
    }
}

extension CreateEventVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Choose and Upload video
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

//        dismiss(animated: true, completion: nil)
//        guard let movieUrl = info[.mediaURL] as? URL else { return }
//
//        print("movieUrl....", movieUrl)
//        self.uploadVideo(videoUrl: movieUrl)
//
//
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[.editedImage] as? UIImage else { return }

        self.addEventImgView.contentMode = .scaleAspectFill
        self.addEventImgView.image = image
        self.selectedImage = image
    }
}
