//
//  VVMenuHeaderView.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/12.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVMenuHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(backgroundIconView)
        backgroundIconView.addSubview(eyeIconView)
        self.addSubview(loginLabel)
        self.addSubview(lineView)
        self.addSubview(collectionLabel)
        self.addSubview(commentLabel)
        
        backgroundIconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_10)
        }
        backgroundIconView.layer.cornerRadius = 50
        eyeIconView.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundIconView)
        }
        loginLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(backgroundIconView.snp.bottom).offset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self.loginLabel.snp.bottom).offset(UIConstant.UI_MARGIN_20)
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        collectionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self.lineView)
            make.top.equalTo(self.loginLabel.snp.bottom).offset(UIConstant.UI_MARGIN_20)
            make.height.equalTo(20)
        }
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.lineView)
            make.right.equalTo(self).offset(-UIConstant.UI_MARGIN_20)
            make.top.equalTo(collectionLabel.snp.top)
            make.height.equalTo(collectionLabel.snp.height)
        }
        
    }
    
    private lazy var backgroundIconView: UIView = {
        
        var backgroundIconView = UIView()
        
        backgroundIconView.backgroundColor = UIColor.lightGray
        backgroundIconView.layer.borderColor = UIColor.white.cgColor
        backgroundIconView.layer.borderWidth = 2
        return backgroundIconView
    
    }()
    
    private lazy var eyeIconView: UIImageView = {
        
        var eyeIconView = UIImageView(image: UIImage(named: "ic_action_focus_white"))
        eyeIconView.contentMode = .scaleAspectFit
        return eyeIconView
    
    }()
    
    private lazy var loginLabel: UILabel = {
        
        var loginLabel: UILabel = UILabel()
        loginLabel.text = "点击登录后可评论"
        loginLabel.textAlignment = .center
        loginLabel.textColor = UIColor.black
        return loginLabel
    
    }()
    
    private lazy var lineView: UIView = {
        
        var lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        return lineView
    
    }()
    
    private lazy var collectionLabel: UILabel = {
        
        var collectionLabel = UILabel()
        collectionLabel.textAlignment = .center
        collectionLabel.text = "我的收藏"
        collectionLabel.textColor = UIColor.black
        return collectionLabel
    }()
    
    private lazy var commentLabel: UILabel = {
        
        var commentLabel = UILabel()
        
        commentLabel.textAlignment = .center
        commentLabel.text = "我的评论"
        commentLabel.textColor = .black
        return commentLabel
    
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
