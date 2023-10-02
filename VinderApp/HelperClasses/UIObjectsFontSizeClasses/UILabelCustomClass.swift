//
//  UILabelCustomClass.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//


import UIKit

// UILabel Custom class
@IBDesignable class UILabelCustomClass: UILabelFontSize {
    
    // Set border width of UILabel
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // Set border color of UILabel
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    // Set corner radius of UILabel
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
       
    @IBInspectable var shadowOpacity: Float{
       set {
           layer.shadowOpacity = newValue
       }
       get{
           return layer.shadowOpacity
       }
    }

    @IBInspectable var shadowRadius: CGFloat{
       set {
           layer.shadowRadius = newValue
       }
       get{
           return layer.shadowRadius
       }
    }

}
