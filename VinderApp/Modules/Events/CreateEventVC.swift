//
//  CreateEventVC.swift
//  VinderApp
//
//  Created by ios Dev on 19/09/2023.
//

import UIKit

class CreateEventVC: UIViewController, TagsCollectionViewCellProtocol {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var sportsCategoryCollectionView: UICollectionView!
//    var selectedIndexRow = Int()
    @IBOutlet weak var eventTitleTextField: UITextFieldCustomClass!
    @IBOutlet weak var startEventDateTextField: UITextFieldCustomClass!
    @IBOutlet weak var endEventDateTextField: UITextFieldCustomClass!
    @IBOutlet weak var startEventTimeTextField: UITextFieldCustomClass!
    @IBOutlet weak var endEventTimeTextField: UITextFieldCustomClass!

    @IBOutlet weak var eventDescTxtView: UITextView!
    
    let viewModel = EventsViewModel(apiService: EventsWebServices())
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // Register tableView cells
        self.sportsCategoryCollectionView.register(TagsCollectionViewCell.nib(), forCellWithReuseIdentifier: TagsCollectionViewCell.identifier)
        
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
    
    
    @objc
//    func doneAction(textField: UITextField) { // 2023-10-15 , // 03:30:00
//        if let datePickerView = self.startEventDateTextField.inputView as? UIDatePicker {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let dateString = dateFormatter.string(from: datePickerView.date)
//            self.startEventDateTextField.text = dateString
//
//            print(datePickerView.date)
//            print(dateString)
//
//            self.startEventDateTextField.resignFirstResponder()
//        } else if let datePickerView = self.startEventTimeTextField.inputView as? UIDatePicker {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "hh:mm:ss"
//            let dateString = dateFormatter.string(from: datePickerView.date)
//            self.startEventTimeTextField.text = dateString
//
//            print(datePickerView.date)
//            print(dateString)
//
//            self.startEventTimeTextField.resignFirstResponder()
//        } else if let datePickerView = self.endEventDateTextField.inputView as? UIDatePicker {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let dateString = dateFormatter.string(from: datePickerView.date)
//            self.endEventDateTextField.text = dateString
//
//            print(datePickerView.date)
//            print(dateString)
//
//            self.startEventDateTextField.resignFirstResponder()
//        } else if let datePickerView = self.endEventTimeTextField.inputView as? UIDatePicker {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "hh:mm:ss"
//            let dateString = dateFormatter.string(from: datePickerView.date)
//            self.endEventTimeTextField.text = dateString
//
//            print(datePickerView.date)
//            print(dateString)
//
//            self.startEventDateTextField.resignFirstResponder()
//        }
//    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createEventBtnAction(_ sender: Any) {
        let name = CommonFxns.trimString(string: self.eventTitleTextField.text ?? emptyStr)
        let desc = CommonFxns.trimString(string: self.eventDescTxtView.text ?? emptyStr)
        let address = String()
        let startDate = self.startEventDateTextField.text ?? emptyStr
        let time = self.startEventTimeTextField.text ?? emptyStr
        let latitude = String()
        let longitude = String()
        let invitees = [Int]()
        if !name.isEmpty && !desc.isEmpty && !startDate.isEmpty && !time.isEmpty{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }else{
            let dict = CreateEventRequest(name: name, description: desc, address: address, date: startDate, time: time, isPaid: 0, latitude: latitude, longitude: longitude, invitees: []).toDictionary()
            self.createEvent(dict: dict, subUrl: "user/events/add")
        }
    }
    
    @IBAction func addEventImgBtnAction(_ sender: Any) {
    }
    
    @IBAction func turnOnReminderValueChanged(_ sender: Any) {
    }
    
    // Actions
    func chooseSportBtnSelected(cell: TagsCollectionViewCell) {
        print("choose sport btn sleected...")
    }

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
    @IBAction func eventCreatedBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Networking
    
    private func createEvent(dict: [String: Any], subUrl: String) {
        self.activityIndicatorStart()

        viewModel.createEvent(params: dict, subUrl: subUrl)
 
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
}

// MARK: - CollectionView Delegates & Datasource

extension CreateEventVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let listCell = self.sportsCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.identifier, for: indexPath) as? TagsCollectionViewCell else{
            return cell
        }
        listCell.delegate = self
        return listCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 110, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = self.playersList[indexPath.row]
//        self.goToPlayerDetailScreen(dict: dict)
    }
    
}
