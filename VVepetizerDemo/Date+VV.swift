//
//  Date+VV.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/4.
//  Copyright © 2016年 atom. All rights reserved.
//

import Foundation

extension Date {
    
    static func getCurrentTimeStamp() -> String {
        
        let timeStamp: String = "\(Int64(floor(Date().timeIntervalSince1970 * 1000)))"
    
        return timeStamp
        
    }

}
