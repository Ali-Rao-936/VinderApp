//
//  UITextViewCustomClass.swift
//  VinderApp
//
//  Created by ios Dev on 26/09/2023.
//

import UIKit

// UITextField Custom class
@IBDesignable class UITextViewCustomClass: UITextViewFontSize {
    
    // Set inset of UITextField placeholder
    @IBInspectable var horizontalInset: CGFloat = 0

//    @IBInspectable var placeholderColor: UIColor = UIColor.black {
//        didSet {
//            if let placeholder = self.placeholder {
//                let attributes = [NSAttributedString.Key.foregroundColor: placeholderColor]
//                attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
//            }
//        }
//    }
    
    // Set corner radius of UITextField
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // Set border width of UITextField

    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // Set border color of UITextField
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
//    // Other methods
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: horizontalInset, dy: 0)
//    }
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: horizontalInset, dy: 0)
//    }
    
}

