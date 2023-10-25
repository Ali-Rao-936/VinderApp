//
//  CreateEventVC.swift
//  VinderApp
//
//  Created by iOS Dev on 18/10/2023.
//

import UIKit

class CreateEventVC: UIViewController {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    @IBOutlet weak var friendCollectionView: UICollectionView!
    @IBOutlet weak var eventTitleTextField: UITextFieldCustomClass!
    @IBOutlet weak var startEventDateTextField: UITextFieldCustomClass!
    @IBOutlet weak var endEventDateTextField: UITextFieldCustomClass!
    @IBOutlet weak var startEventTimeTextField: UITextFieldCustomClass!
    @IBOutlet weak var endEventTimeTextField: UITextFieldCustomClass!
    @IBOutlet weak var locationTextField: UITextFieldCustomClass!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var eventDescTextView: UITextView!
    @IBOutlet weak var eventImgView: UIImageView!
    @IBOutlet weak var priceSegmentControl: UISegmentedControl!
    @IBOutlet weak var priceTextField: UITextFieldCustomClass!
    @IBOutlet weak var priceView: UIView!
    
    var viewModel: ProfileViewModel?
    var sportsInterestList = [SportsInterest]()
    var selectedCellRow = 0
    var imagePicker = ImagePicker()
    var selectedImage = UIImage()
    let dateFormatter = DateFormatter()
    var invitedFriendList = [User]()
    var address = String()
    var isPaid: Int = 0
    var price = Float()
    var invitedFriendListIDArray = [Int]()
    var eventRequest: Event!
    var latitude = Double()
    var longitude = Double()
    var eventViewModel: EventViewModel?
    var eventImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Initial Setup
        self.initialSetup()
        callToViewModelForUIUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Methods
    func initialSetup() {
        self.sportsCollectionView.register(TagsCollectionViewCell.nib(), forCellWithReuseIdentifier: TagsCollectionViewCell.identifier)
        self.startEventDateTextField.addInputViewDatePicker(target: self, selector: #selector(startDateDoneAction))
        self.startEventTimeTextField.addInputViewDatePicker(target: self, selector: #selector(startTimeDoneAction), datePickerMode: .time)
        self.endEventDateTextField.addInputViewDatePicker(target: self, selector: #selector(endDateDoneAction))
        self.endEventTimeTextField.addInputViewDatePicker(target: self, selector: #selector(endTimeDoneAction), datePickerMode: .time)
        priceView.isHidden = true
        successView.isHidden = true
        //   priceTextField.i
        imagePicker.imagePick = imagePick
    }
    
    //MARK:- View setup
    func callToViewModelForUIUpdate(){
        viewModel = ProfileViewModel()
        viewModel?.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.sportsInterestList = viewModel?.sportsList?.data ?? []
        sportsCollectionView.reloadData()
    }
    
    // Setting the selected image to eventImageView
    func imagePick(selectedImage : UIImage) {
        eventImage = selectedImage
        eventImgView.image = selectedImage
    }
    
    func getInvitedFriendList(indexArray: [IndexPath]) {
        for index in indexArray {
            invitedFriendList.append(arrayOfUsers[index.row])
        }
        friendCollectionView.reloadData()
    }
    
    func callToViewModelToCreateEvent(request: Event, eventImage: UIImage) {
        eventViewModel = EventViewModel(eventRequest: request, eventImage: eventImage)
        CommonFxns.showProgress()
        self.eventViewModel?.bindViewModelToController = {
            self.updateUser()
        }
    }
    
    func updateUser() {
        var message = eventViewModel?.eventDetail?.messages?.first
        if eventViewModel?.eventDetail?.code == 200 {
            successView.isHidden = false
        }
        print("The create Event--> \(message ?? "FAILURE")")
    }
    
    // MARK: - Button Actions
    
    @objc func startDateDoneAction(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.startEventDateTextField.inputView as? UIDatePicker {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.startEventDateTextField.text = dateString
            self.startEventDateTextField.resignFirstResponder()
        }
    }
    
    @objc func startTimeDoneAction(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.startEventTimeTextField.inputView as? UIDatePicker {
            dateFormatter.dateFormat = "hh:mm:ss"//"yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.startEventTimeTextField.text = dateString
            self.startEventTimeTextField.resignFirstResponder()
        }
    }
    
    @objc func endDateDoneAction(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.endEventDateTextField.inputView as? UIDatePicker {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.endEventDateTextField.text = dateString
            self.endEventDateTextField.resignFirstResponder()
        }
    }
    
    @objc func endTimeDoneAction(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.endEventTimeTextField.inputView as? UIDatePicker {
            dateFormatter.dateFormat = "hh:mm:ss"//yyyy-MM-dd
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.endEventTimeTextField.text = dateString
            self.endEventTimeTextField.resignFirstResponder()
        }
    }
   
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addEventImageBtnAction(_ sender: Any) {
        imagePicker.showActionSheet()
    }
   
    @IBAction func locationBtnAction(_ sender: Any) {
        let mapVC = MapViewVC(nibName: enumViewControllerIdentifier.mapViewVC.rawValue, bundle: nil)
        mapVC.callback = { placemark in
            self.locationTextField.text = "\(placemark.name ?? ""), \(placemark.country ?? "")"
            self.address = "\(placemark.name ?? ""), \(placemark.subThoroughfare ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
            self.latitude = placemark.coordinate.latitude
            self.longitude = placemark.coordinate.longitude
        }
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func inviteFriendBtnAction(_ sender: Any) {
        let inviteFriendVCObj = InviteFriendsVC(nibName: enumViewControllerIdentifier.inviteFriendsVC.rawValue, bundle: nil)
        inviteFriendVCObj.isInvitationWhileCreatingEvent = true
        invitedFriendList.removeAll()
        inviteFriendVCObj.callBack = getInvitedFriendList
        self.present(inviteFriendVCObj, animated: true)
    }
    
    @IBAction func priceSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            priceView.isHidden = true
            isPaid = 0
            price = 0.0
        }else {
            priceView.isHidden = false
            isPaid = 1
            let priceString = Int(priceTextField.text ?? "0")
            price = Float(priceString ?? 0)
        }
    }
    
    @IBAction func eventCreatedBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createEventBtnAction(_ sender: Any) {
        let name = CommonFxns.trimString(string: self.eventTitleTextField.text ?? emptyStr)
        let desc = CommonFxns.trimString(string: self.eventDescTextView.text ?? emptyStr)
        let address = CommonFxns.trimString(string: self.address)
        let date = self.startEventDateTextField.text ?? emptyStr
        let time = self.startEventTimeTextField.text ?? emptyStr

        let interestId = sportsInterestList[self.selectedCellRow].id ?? 0
        
        if !invitedFriendList.isEmpty {
            for index in 0..<invitedFriendList.count {
                invitedFriendListIDArray.append(invitedFriendList[index].id ?? 0)
            }
        }else {
            invitedFriendListIDArray = []
        }
        
        eventRequest = 
        Event(name: name, description: desc, interestId: interestId, latitude: latitude, longitude: longitude, date: date, time: time, address: address, isPaid: isPaid, price: price, invitee: invitedFriendListIDArray)
        
        if name.isEmpty || desc.isEmpty || interestId == 0 || address.isEmpty || date.isEmpty || time.isEmpty || (isPaid == 1 && price == 0.0) {
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }else{
            if eventImage != nil {
                callToViewModelToCreateEvent(request: eventRequest, eventImage: eventImage!)
            }else {
                CommonFxns.showAlert(self, message: AlertMessages.CHOOSE_EVENT_IMAGE, title: AlertMessages.ALERT_TITLE)
            }
        }
    }
}

extension CreateEventVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sportsCollectionView {
            return self.sportsInterestList.count
        }else {  // Invite Friend Collection
            return self.invitedFriendList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.sportsCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.identifier, for: indexPath) as? TagsCollectionViewCell else{
            return cell
        }
        
        if collectionView == sportsCollectionView { // Sports Collection View
            let dict = self.sportsInterestList[indexPath.row]
            listCell.cancelBtn.isHidden = true
            listCell.tagLbl.text = dict.name?.capitalized
            
            listCell.tagImgView.sd_setImage(with: URL(string: dict.sportImage?.image ?? emptyStr), placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
            
            if indexPath.row != self.selectedCellRow {
                listCell.selectedView.isHidden = true
                listCell.deselectedView.isHidden = false
                listCell.tagLbl.textColor = UIColor.gray
            }else{
                listCell.selectedView.isHidden = false
                listCell.deselectedView.isHidden = true
                listCell.tagLbl.textColor = primaryColor
            }
            return listCell
            
        }else { // Friend Collection View
            listCell.tagImgView.image = UIImage(named: "smallDefaultUserProfileImg")
            listCell.cancelBtn.isHidden = false
            listCell.selectedView.isHidden = false
            listCell.deselectedView.isHidden = true
            listCell.tagLbl.textColor = primaryColor
            listCell.tagLbl.text = invitedFriendList[indexPath.row].name ?? "User"
            listCell.cancelBtn.tag = indexPath.row
            listCell.cancelBtn.addTarget(self, action:#selector(deselectUser(sender:)) , for: .touchUpInside)
            return listCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCellRow = indexPath.row
        collectionView.reloadData()
    }
    
    @objc func deselectUser(sender: UIButton) {
        
        invitedFriendList.remove(at: sender.tag)
        self.friendCollectionView.performBatchUpdates({
            self.friendCollectionView.deleteItems(at: [IndexPath(item: sender.tag, section: 0)])
        })
    }
}
