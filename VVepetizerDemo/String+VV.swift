//
//  String+VV.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import Foundation


extension Int {
    
    static func durationToTimer(duration: Int) -> String {
        
        return "\(String(format: "%02d", duration/60))' \(String(format: "%02d", duration%60))\""
    
    }

}
