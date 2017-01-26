//
//  UIView+Frame.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

extension UIView {
    
    public func viewAddTarget(target: AnyObject, action: Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        
        self.isUserInteractionEnabled = true
        
        self.addGestureRecognizer(tap)
    }
    public var x: CGFloat {
        
        get {
            
            return self.frame.origin.x
        }
        
        set {
        
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    
    }
    
    public var y: CGFloat {
        
        get {
            
            return self.frame.origin.y
        }
        
        set {
            
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
    }
    
    public var height: CGFloat {
        
        get {
        
            return self.frame.size.height
        }
        
        set {
            
            var frame = self.frame
            
            frame.size.height = newValue
            
            self.frame = frame
        
        }
    
    }
    
    public var width: CGFloat {
        
        get {
            
            return self.frame.size.width
        }
        
        set {
            
            var frame = self.frame
            
            frame.size.width = newValue
            
            self.frame = frame
            
        }
        
    }
    
    public var size: CGSize {
        
        get {
            
            return self.frame.size
        }
        set {
        
            var frame = self.frame
            
            frame.size = newValue
            
            self.frame = frame
        }
    
    }

}
