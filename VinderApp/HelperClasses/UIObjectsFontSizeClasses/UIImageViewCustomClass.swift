//
//  UIImageViewCustomClass.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//


import UIKit

// UIImageView Custom class
@IBDesignable class UIImageViewCustomClass: UIImageView {

    // Set corner radius of UIImageView
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // Set border width of UIImageView
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // Set border color of UIImageView
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    // Set round UIImageView property from storyboard
    fileprivate var _round = false
    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }
    
    override internal var frame: CGRect {
        set {
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
    }

    fileprivate func makeRound() {
        if self.round == true {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.frame.width*0.5
        }
        else {
            self.layer.cornerRadius = 0
        }
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
