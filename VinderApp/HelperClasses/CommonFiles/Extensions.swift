//
//  Extensions.swift
//  VinderApp
//
//  Created by ios Dev on 26/09/2023.
//

import Foundation
import UIKit

extension UIView {
   func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero) {

      // Create a new gradient layer
      let gradientLayer = CAGradientLayer()
      
      // Set the colors and locations for the gradient layer
      gradientLayer.colors = colors.map{ $0.cgColor }
      gradientLayer.locations = locations

      // Set the start and end points for the gradient layer
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)

      // Set the frame to the layer
      gradientLayer.frame = frame

      // Add the gradient layer as a sublayer to the background view
      layer.insertSublayer(gradientLayer, at: 0)
   }
}


extension UITextField {
    func addInputViewDatePicker(target: Any, selector: Selector, datePickerMode: UIDatePicker.Mode = .date, fromNowDate: Bool? = true) {
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        if fromNowDate ?? true {
            datePicker.minimumDate = Date()
        }
    
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}
