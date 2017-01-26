//
//  VVChoiceHeaderView.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import  SnapKit

class VVChoiceHeaderView: UICollectionReusableView, Reuseable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        
        self.addSubview(imageView)
        
        titleLabel.snp.makeConstraints { [unowned self] (make) in
            
            make.edges.equalTo(self)
            
        }
        
        imageView.snp.makeConstraints { [unowned self] (make) in
            
            make.leading.trailing.equalTo(self)
            
            make.top.equalTo(self).offset(self.height * 0.25)
            
            make.height.equalTo(self.height * 0.5)
            
        }
    }
    
    
    
    fileprivate lazy var titleLabel: UILabel = {
        
        var titleLabel: UILabel = UILabel()
        
        titleLabel.textAlignment = .center
        
        //textLabel.font
        
        return titleLabel
    
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        
        var imageView: UIImageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
