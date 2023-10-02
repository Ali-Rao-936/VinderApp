//
//  UIButtonFontSize.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//

import UIKit

// UIButton Custom Font class
class UIButtonFontSize: UIButton {

    // MARK: - Methods
    
    override func awakeFromNib() {
        changeSize()
    }
    
    // Change Font size of button according to Screen size
    fileprivate func changeSize() {
        let currentSize = self.titleLabel?.font.pointSize
        let fontDescriptor = self.titleLabel?.font.fontDescriptor
        

        
        if (UIScreen.main.bounds.height > iPhone_6_Height) && (UIScreen.main.bounds.height < iPhone_11Pro_MAX_Height){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!-2)
        }
        if (UIScreen.main.bounds.height <= iPhone_6_Height){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!-2)
        }
    }

}
