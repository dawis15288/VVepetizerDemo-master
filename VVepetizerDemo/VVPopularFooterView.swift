//
//  VVPopularFooterView.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/5.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

import SnapKit

class VVPopularFooterView: UICollectionReusableView, Reuseable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private lazy var titleLabel: UILabel = {
        
        var titleLabel = UILabel()
        titleLabel.text = "-The End -"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
