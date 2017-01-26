//
//  VVChoiceCell.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import Kingfisher

import SnapKit

class VVChoiceCell: UICollectionViewCell, Reuseable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(bacgroundImageView)
        
        self.contentView.addSubview(coverButton)
        
        self.contentView.addSubview(titleLabel)
        
        self.contentView.addSubview(subTitleLabel)
        
        self.contentView.addSubview(indexView)
        
        bacgroundImageView.snp.makeConstraints {[unowned self] (make) in
            
            make.leading.trailing.top.bottom.equalTo(self.contentView)
            
        }
        
        coverButton.snp.makeConstraints {[unowned self] (make) in
            
            make.leading.trailing.top.bottom.equalTo(self.contentView)
            
        }
        
        titleLabel.snp.makeConstraints {[unowned self] (make) in
            
            make.leading.trailing.equalTo(self.contentView)
            
            make.height.equalTo(20)
            
            make.center.equalTo(self.contentView.center)
            
        }
        
        subTitleLabel.snp.makeConstraints { [unowned self] (make) in
            
            make.leading.trailing.equalTo(self.contentView)
            
            make.height.equalTo(20)
            
            make.top.equalTo(self.titleLabel).offset(15)
        }
        
        indexView.snp.makeConstraints {[unowned self] (make) in
            
            make.left.right.equalTo(self.contentView)
            
            make.bottom.equalTo(self.contentView).offset(-30)
            
            make.height.equalTo(30)
        }
        
        indexLabel.snp.makeConstraints {[unowned self] (make) in
            
            make.edges.equalTo(self.indexView)
        }
        
        topLine.snp.makeConstraints {[unowned self] (make) in
            
            make.top.equalTo(self.indexView)
            
            make.height.equalTo(0.5)
            
            make.width.equalTo(30)
            
            make.centerX.equalTo(self.indexView.center)
        }
        
        bottomLine.snp.makeConstraints {[unowned self] (make) in
            
            make.bottom.equalTo(self.indexView)
            
            make.leading.trailing.equalTo(self.topLine)
            
            make.size.equalTo(self.topLine)
        }
    }
    
    var model: ItemModel! {
    
        didSet {
            
            if let feed = model.feed {
            
                
                self.bacgroundImageView.kf.setImage(with: URL(string: feed)!)
            
            } else {
                
                if let image = model.image {
                    
                    self.bacgroundImageView.kf.setImage(with: URL(string: image)!)
                    
                    self.subTitleLabel.isHidden = true
                
                }
            
            }
        
            self.titleLabel.text = model.title
            
            self.subTitleLabel.text = model.subTitle
        
        }
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        self.bacgroundImageView.image = nil
    }
    
    var index: String! {
        
        didSet {
            
            self.indexView.isHidden = false
            
            self.indexLabel.text = index
        
        }
    
    }
    
     lazy var bacgroundImageView: UIImageView = {
        
        var background: UIImageView = UIImageView()
        
        return background
    
    }()
    
     lazy var coverButton: UIButton = {
        
        var coverButton: UIButton = UIButton()
        
        coverButton.isUserInteractionEnabled = false
        
        coverButton.backgroundColor = UIColor.black
        
        coverButton.alpha = 0.3
        
        return coverButton
    
    }()
    
     lazy var titleLabel: UILabel = {
        
        var titleLabel: UILabel = UILabel()
        
        titleLabel.textAlignment = .center
        
        titleLabel.text = "标题"
        
        titleLabel.textColor = UIColor.white
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        return titleLabel
    
    }()
    
     lazy var  subTitleLabel: UILabel = {
        
        var subTitleLabel = UILabel()
        
        subTitleLabel.textAlignment = .center
        
        subTitleLabel.text = "副标题"
        
        subTitleLabel.textColor = UIColor.white
        
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        return subTitleLabel
    
    }()
    
     lazy var topLine: UIView = {
        
        var topLine = UIView()
        
        topLine.backgroundColor = UIColor.white
        
        return topLine
    
    }()
    
     lazy var bottomLine: UIView = {
    
        
        var bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.white
        
        return bottomLine
        
    }()
    
     lazy var indexLabel: UILabel = {
        
        var indexLabel = UILabel()
        
        indexLabel.textColor = UIColor.white
        
        indexLabel.textAlignment = .center
        
        indexLabel.font = UIFont.systemFont(ofSize: 14)
        
        return indexLabel
    
    }()
    
     lazy var indexView: UIView = {
        
        var indexView: UIView = UIView()
        
        indexView.isHidden = true
        
        indexView.backgroundColor = UIColor.clear
        
        indexView.addSubview(self.indexLabel)
        
        indexView.addSubview(self.topLine)
        
        indexView.addSubview(self.bottomLine)
        
        return indexView
    
    }()
}
