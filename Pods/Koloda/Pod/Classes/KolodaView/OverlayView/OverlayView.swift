//
//  OverlayView.swift
//  Koloda
//
//  Created by Eugene Andreyev on 4/24/15.
//  Copyright (c) 2015 Eugene Andreyev. All rights reserved.
//

import UIKit

open class OverlayView: UIView {
    
    open var overlayState: SwipeResultDirection?
    @IBOutlet weak var imageView: UIImageView!
    
    open func update(progress: CGFloat) {
        alpha = progress
    }

}
