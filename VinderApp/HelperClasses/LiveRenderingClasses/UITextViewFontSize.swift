//
//  UITextViewFontSize.swift
//  Meem
//
//  Created by Developer on 10/22/19.
//  Copyright © 2019 owt. All rights reserved.
//

import UIKit

// UITextView Custom Font class
class UITextViewFontSize: UITextView {

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
        
        if (UIScreen.main.bounds.height > iPhone_6_Height) && (UIScreen.main.bounds.height < iPhone_11Pro_MAX_Height){
            self.font = self.font!.withSize(currentSize-2)
        }
        if (UIScreen.main.bounds.height <= iPhone_6_Height){
            self.font = self.font!.withSize(currentSize-2)
        }
        

    }

}
