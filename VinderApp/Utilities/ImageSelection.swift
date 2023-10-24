//
//  ProfileImageSelection.swift
//  Passenger
//
//  Created by cis on 13/08/19.
//  Copyright © 2019 cis. All rights reserved.
//

import Foundation
import UIKit

class ImagePicker : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let picker = UIImagePickerController()
    var imagePick: ((_ chosenImage : UIImage) -> Void)?
    var flag : Bool?
    
    override init() {
        super.init()
        flag = true
        picker.delegate = self
    }
    
    // Show alert to choose the option for Camera or Photo Album
    func showActionSheet() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        })
        alert.addAction(cameraAction)
        
        let albumAction = UIAlertAction(title: "Gallery", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
            
        })
        alert.addAction(albumAction)
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        [cameraAction, albumAction, cancelAction].forEach {$0?.setValue(UIColor.black, forKey: "titleTextColor")}
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // MARK: -
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        flag = false
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
         imagePick!(chosenImage)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
