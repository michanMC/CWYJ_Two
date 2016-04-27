//
//  UIViewExt.swift
//  RGFadeView-Swift
//
//  Created by Arvin on 15/10/29.
//  Copyright © 2015年 com.roroge. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func width() ->CGFloat {
        return self.frame.size.width
    }
    
    func width(let width: CGFloat) {
        var rect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func height() ->CGFloat {
        return self.frame.size.height
    }
    
    func height(let height: CGFloat) {
        var rect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    func top()-> CGFloat {
        return self.frame.origin.y
    }
    
    func top(let top:CGFloat) {
        var rect:CGRect = self.frame
        rect.origin.y = top
        self.frame = rect
    }
    
    func bottom()-> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    func bottom(bottom:CGFloat) {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
}
