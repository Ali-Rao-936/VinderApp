//
//  UpdateBasicProfileInfoVC.swift
//  VinderApp
//
//  Created by ios Dev on 20/09/2023.
//

import UIKit

class UpdateBasicProfileInfoVC: UIViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var maleLbl: UILabel!
    @IBOutlet weak var femaleLbl: UILabel!
    @IBOutlet weak var maleBgView: UIView!
    @IBOutlet weak var femaleBgView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    fileprivate let pickerView = ToolbarPickerView()

    let imagePicker = UIImagePickerController()
    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    var selectedGender = String()
    var selectedAge = zero
    var selectedLocation = String()
    var selectedLocationId = zero

    var latitude = String()
    var longitude = String()
    var locationsArr = [Locations]()

    let authViewModel = AuthViewModel(apiService: AuthWebServices())

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        
        self.locationTextField.inputView = self.pickerView
        self.locationTextField.inputAccessoryView = self.pickerView.toolbar

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
        
        self.ageTextField.datePicker(target: self, doneAction: #selector(doneAction), cancelAction: #selector(cancelAction), datePickerMode: .date)
        hideKeyboardWhenTappedAround() // Hide keyboard
        
        self.addKeyboardobserversOnScreen() // add key board observers

        self.showDataOnScreen()
        // Network call
        self.getHomeAPI()
    }
    
    func showDataOnScreen(){
        // UI setup
        let user = UserDefaultsToStoreUserInfo.getUser()
        self.fullNameTextField.text = user?.name ?? emptyStr
        self.emailTextField.text = user?.email ?? emptyStr
        self.phoneNumberTextField.text = user?.phoneNumber ?? emptyStr
        
        self.selectedGender = user?.gender ?? emptyStr
        if selectedGender == gender.male.rawValue{
            self.maleGenderSelected()
        }else{
            self.femaleGenderSelected()
        }
        let age = user?.age ?? 0
        if age != zero{
            self.ageTextField.text = "\(age)"
            self.selectedAge = age
        }
        self.selectedLocation = user?.locationName ?? emptyStr
        self.locationTextField.text = user?.locationName ?? emptyStr
        self.selectedLocationId = user?.locationId ?? 0

        self.profileImgView.sd_setImage(with: URL(string: user?.profileImg ?? emptyStr), placeholderImage: UIImage(named: "smallDefaultUserProfileImg"), options: .allowInvalidSSLCertificates, completed: nil)
    }
    
    func addKeyboardobserversOnScreen(){
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateUserInfoLocally(user: UserModel){
        let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]

        UserDefaultsToStoreUserInfo.updateUserDetails(user: updatedUser)
    }
    
    @objc
    func cancelAction() {
        self.view.resignFirstResponder()
    }
    
    @objc
    func doneAction(textField: UITextField) { // 2023-10-15 , // 03:30:00
        if let datePickerView = self.ageTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
 
            let age = getAgeFromDOF(date: dateString)
            self.ageTextField.text = "\(age)"
            self.selectedAge = age
            self.ageTextField.resignFirstResponder()
        }
    }
    
    func getAgeFromDOF(date: String) -> Int{

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let dateOfBirth = dateFormater.date(from: date)

        let calender = Calendar.current

        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())

        return dateComponent.year!
    }
    
    // MARK: - Keyboard notifications methods
    
    // Method to show keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - 100 // keyboardSize.height
    }
    
    // Method to hide keyboard

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    

    
    // MARK: - Button Actions
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateImageBtnAction(_ sender: Any) {
        // To choose image from phone
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func chooseGenderBtnAction(_ sender: UIButton) {
        
        if sender.tag == zero{
            self.maleGenderSelected()
        }else{
            self.femaleGenderSelected()
        }
    }
    
    func maleGenderSelected(){
        self.maleBgView.layer.borderColor = primaryColor.cgColor
        self.maleBgView.backgroundColor = primaryColorWithAlpha
        self.maleLbl.textColor = UIColor.white
        
        self.femaleBgView.layer.borderColor =  UIColor.gray.cgColor
        self.femaleBgView.backgroundColor = UIColor.white
        self.femaleLbl.textColor = UIColor.gray
        
        self.selectedGender = gender.male.rawValue
    }
    
    func femaleGenderSelected(){
        self.femaleBgView.layer.borderColor = primaryColor.cgColor
        self.femaleBgView.backgroundColor = primaryColorWithAlpha
        self.femaleLbl.textColor = UIColor.white
        
        self.maleBgView.layer.borderColor =  UIColor.gray.cgColor
        self.maleBgView.backgroundColor = UIColor.white
        self.maleLbl.textColor = UIColor.gray
        
        self.selectedGender = gender.female.rawValue
    }

//    var selectedGender = String()
    @IBAction func saveInfoBtnAction(_ sender: Any) {
        let name = CommonFxns.trimString(string: self.fullNameTextField.text ?? emptyStr)
        let phoneNumber = CommonFxns.trimString(string: self.phoneNumberTextField.text ?? emptyStr)

        
        let dict = ["name": name, "phone_number": phoneNumber, "gender" : self.selectedGender, "age" : self.selectedAge, "location_id": selectedLocationId] as [String : Any]
        print("dict....", dict)
        if selectedAge != 0 && selectedLocationId != zero && !selectedGender.isEmpty{
            let dict = ["name": name, "phone_number": phoneNumber, "gender" : self.selectedGender, "age" : self.selectedAge, "location_id": selectedLocationId] as [String : Any]
            print(dict)
            self.updateProfileInfo(dict: dict)
        }else{
            CommonFxns.showAlert(self, message: AlertMessages.ALL_DATA_REQUIRED, title: AlertMessages.ALERT_TITLE)
        }
    }
    
    
    // MARK: - Networking
    
    // uploadProfilePic
    private func uploadProfilePic(image: UIImage) {

        self.activityIndicatorStart()
        viewModel.uploadUserProfilePhoto(image: image)

        viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ALERT_TITLE)
           self.activityIndicatorStop()
        }

        viewModel.didFinishFetch = { data in
            print("uploadProfilePic did finsh...", data)
                    
            let user = UserModel(with: data)
            self.updateUserInfoLocally(user: user)
      
            self.activityIndicatorStop()
        }
    }
    
    // updateProfileInfo
    private func updateProfileInfo(dict: [String:Any]) {

        self.activityIndicatorStart()
        viewModel.updateUserProfile(parameters: dict)

        viewModel.showAlertClosure = {
           msg in
           print("msg....", msg)
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ALERT_TITLE)
           self.activityIndicatorStop()
        }

        viewModel.didFinishFetch = { data in
            print("updateProfileInfo did finsh...", data)
            
            let user = UserModel(with: data)
            self.updateUserInfoLocally(user: user)
            CommonFxns.showConfirmationAlert(title: successStr, message: AlertMessages.PROFILE_INFO_UPDATED, cancel: false, vc: self) {
                self.navigationController?.popViewController(animated: true)
            }
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

    private func activityIndicatorStart() {
        // Code for show activity indicator view
        CommonFxns.showProgress()
        print("start")
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        CommonFxns.dismissProgress()
    }
    

}

extension UpdateBasicProfileInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

        self.profileImgView.image = image
        self.uploadProfilePic(image: image)
    }
}

extension UpdateBasicProfileInfoVC: UIPickerViewDataSource, UIPickerViewDelegate {

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
            self.locationTextField.text = self.locationsArr[row].name
            self.selectedLocationId = self.locationsArr[row].id ?? 0
        }
    }
}

extension UpdateBasicProfileInfoVC: ToolbarPickerViewDelegate {

    func didTapDone() {
        if self.locationsArr.count > 0{
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.locationTextField.text = self.locationsArr[row].name
            self.selectedLocationId = self.locationsArr[row].id ?? 0
        }
        self.locationTextField.resignFirstResponder()
    }

    func didTapCancel() {
        self.locationTextField.resignFirstResponder()
    }
}
