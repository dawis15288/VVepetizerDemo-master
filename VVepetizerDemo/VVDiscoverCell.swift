//
//  VVDiscoverCell.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/24.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVDiscoverCell: UICollectionViewCell, Reuseable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(backgroundImageView)
        
        self.contentView.addSubview(coverButton)
        
        self.addSubview(titleLabel)
        
        backgroundImageView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(self.contentView)
        }
        
        coverButton.snp.makeConstraints { (make) in
            
            make.edges.equalTo(self.contentView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.leading.trailing.equalTo(self.contentView)
            
            make.height.equalTo(20)
            
            make.center.equalTo(self.contentView.center)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: VVDiscoverModel! {
        
        didSet {
            
            //let resource = Resource()
            
            let url = URL(string: model.bgPicture)
            
            self.backgroundImageView.kf.setImage(with: url!)
            
            self.titleLabel.text = model.name
        
        }
    
    }
    
    private lazy var backgroundImageView: UIImageView = {
    
        var backgroundImageView: UIImageView = UIImageView()
        
        return backgroundImageView
    
    }()
    
    private lazy var coverButton: UIButton = {
        
        var coverButton: UIButton = UIButton()
        
        coverButton.isUserInteractionEnabled = false
        
        coverButton.backgroundColor = UIColor.black
        
        coverButton.alpha = 0.3
        
        return coverButton
    
    }()
    
    private lazy var titleLabel: UILabel = {
        
        var titleLabel: UILabel = UILabel()
        
        titleLabel.textColor = UIColor.white
        
        titleLabel.textAlignment = .center
        
        return titleLabel
    
    }()
}
