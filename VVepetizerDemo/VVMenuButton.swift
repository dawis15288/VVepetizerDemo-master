//
//  VVMenuButton.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/4.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

public enum VVMenuButtonType {
    
    case none
    
    case date

}

class VVMenuButton: UIButton {

    fileprivate var type: VVMenuButtonType = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.setTitleColor(UIColor.black, for: .normal)
        
        self.setImage(UIImage(named: "ic_action_menu"), for: .normal)
        
        
    }
    
    convenience init(frame: CGRect, type: VVMenuButtonType) {
    
        self.init(frame: frame)
        
        self.type = type
        
        if type == .date {
            
            self.setTitle("Today", for: .normal)
        
        }
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if type == .date {
            
            return CGRect(x: self.height - UIConstant.UI_MARGIN_10, y: 0, width: self.width - self.height + UIConstant.UI_MARGIN_10, height: self.height)
        
        }
        
        return CGRect.zero
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: self.height, height: self.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
