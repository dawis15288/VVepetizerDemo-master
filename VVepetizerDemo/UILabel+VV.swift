//
//  UILabel+VV.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/11.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

extension UILabel {
    
    func bounding(with size: CGSize) -> CGSize {
        
        let attribute = [NSFontAttributeName: self.font]
        
        let textsize = (self.text! as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attribute, context: nil).size
        
        return textsize
    
    }

}
