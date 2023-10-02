//
//  UIViewCustomClass.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//


import UIKit

// UIView Custom class
 class UIViewCustomClass: UIView {

    // Set border width of UIView
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // Set border color of UIView
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    // Set corner radius of UIView
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
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


