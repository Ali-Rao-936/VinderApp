//
//  UITextFieldFontSize.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//


import UIKit

// UITextField Custom Font class
class UITextFieldFontSize: UITextField {

    // MARK: - Methods

    override func awakeFromNib() {
        changeSize()
    }
    
    // Change Font size of TextField according to Screen size
    fileprivate func changeSize() {
        let currentSize = self.font!.pointSize
//        if (UIScreen.main.bounds.height < iPhone_8Plus_Height){
//            self.font = self.font!.withSize(currentSize-fontSizeForSmallDevices)
//        }
//        if (UIScreen.main.bounds.height > iPhone_X_Height){
//            self.font = self.font!.withSize(currentSize+fontSizeForLargeDevices)
//        }
//
        if (UIScreen.main.bounds.height > iPhone_6_Height) && (UIScreen.main.bounds.height < iPhone_11Pro_MAX_Height){
            self.font = self.font!.withSize(currentSize-2)
        }
        if (UIScreen.main.bounds.height <= iPhone_6_Height){
            self.font = self.font!.withSize(currentSize-2)
        }


    }

}
