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
    }
    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createEventBtnAction(_ sender: Any) {
        let name = CommonFxns.trimString(string: self.eventTitleTextField.text ?? emptyStr)
        let desc = CommonFxns.trimString(string: self.eventDescTxtView.text ?? emptyStr)
        let address = String()
        let date = String()
        let time = String()
        let latitude = String()
        let longitude = String()
        let invitees = [Int]()
        
        let dict = CreateEventRequest(name: name, description: desc, address: address, date: date, time: time, isPaid: 0, latitude: latitude, longitude: longitude, invitees: []).toDictionary()
        self.createEvent(dict: dict, subUrl: "user/events/add")
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
