//
//  VVDiscoverModel.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/24.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

struct VVDiscoverModel {
    
    var id: Int!
    
    var name: String!
    
    var alias: String!
    
    var bgPicture: String!
    
    var bgColor: String!
    
    init(dict: NSDictionary) {
        
        self.id = dict["id"] as? Int ?? 0
        
        self.name = dict["name"] as? String ?? ""
        
        self.alias = dict["alias"] as? String ?? ""
        
        self.bgPicture = dict["bgPicture"] as? String ?? ""
        
        self.bgColor = dict["bgColor"] as? String ?? ""
        
        
    }
    
}
