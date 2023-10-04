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

    let imagePicker = UIImagePickerController()
    let viewModel = ProfileAndSettingsViewModel(apiService: ProfileAndSettingsWebServices())
    var selectedGender = String()
    var selectedAge : Int?
    var selectedLocation: Int?
    
    var latitude = String()
    var longitude = String()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    // MARK: - Methods
    
    func initialSetup(){
        // UI setup
        let user = UserDefaultsToStoreUserInfo.getUser()
        self.fullNameTextField.text = user?.name ?? emptyStr
        self.emailTextField.text = user?.email ?? emptyStr
        self.phoneNumberTextField.text = user?.phoneNumber ?? emptyStr
        self.selectedGender = user?.gender ?? emptyStr
//        self.selectedAge = user?.age
//        self.selectedLocation = user?.locationId
    }
    
    func updateUserInfoLocally(user: UserModel){
        let updatedUser = UserModel(userId: user.userId ?? zero, name: user.name ?? emptyStr, email: user.email ?? emptyStr, about: user.about ?? emptyStr, age: user.age ?? zero, profileImg: user.profileImg ?? emptyStr, phoneNumber: user.phoneNumber ?? emptyStr, gender: user.gender ?? emptyStr, allowNotifications: user.allowNotifications ?? zero, loginPurpose: user.loginPurpose ?? emptyStr, locationId: user.locationId ?? zero, locationName: user.locationName ?? emptyStr, latitude: user.latitude ?? emptyStr, longitude: user.longitude ?? emptyStr, islocationTurnOn: user.islocationTurnOn ?? zero, level: user.level ?? zero, prefferedLanguage: user.prefferedLanguage ?? emptyStr, isBlock: user.isBlock ?? zero, isDeleted: user.isDeleted ?? zero, accessToken: user.accessToken ?? emptyStr, signUpVia: user.signUpVia ?? emptyStr, loginVia: user.loginVia ?? emptyStr, otpVerified: user.otpVerifed ?? zero, sportsInterests: user.sportsInterests ?? []).toAnyObject() as! [String: Any]

        UserDefaultsToStoreUserInfo.updateUserDetails(user: updatedUser)
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
    
    @IBAction func chooseGenderBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func chooseAgeBtnAction(_ sender: Any) {
    }

    @IBAction func chooseLocationBtnAction(_ sender: Any) {
    }

    @IBAction func saveInfoBtnAction(_ sender: Any) {
        let user = UserDefaultsToStoreUserInfo.getUser()
        let name = CommonFxns.trimString(string: self.fullNameTextField.text ?? emptyStr)
        let phoneNumber = CommonFxns.trimString(string: self.phoneNumberTextField.text ?? emptyStr)
        var age : Int!; var location = Int()
        
//        if selectedAge != nil && selectedAge != zero{
//            age = selectedAge!
//        }
//
//        if selectedLocation != nil && selectedLocation != zero{
//            location = selectedLocation!
//        }
        
        let dict = UpdateProfileRequest(name: name, phoneNumber: phoneNumber, loginPurpose: user?.loginPurpose ?? emptyStr, gender: selectedGender, age: age, locationId: location, about: user?.about ?? emptyStr, latitude: user?.latitude ?? emptyStr, longitude: user?.longitude ?? emptyStr).toDictionary()
        
        print("dict......", dict)
        
        
        print("dict......", age , "sakdjlsak", selectedAge)

        let dict2 = ["name": name, "phone_number": phoneNumber, "gender" : selectedGender]
        self.updateProfileInfo(dict: dict2)
        
//        if let dict = ["name": name, "gender" : selectedGender] as? [String: Any]{
//
//        }
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
            
            if let dataDict = data["data"] as? [String: Any]{
            }
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
