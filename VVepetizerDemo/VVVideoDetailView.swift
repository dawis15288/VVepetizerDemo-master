//
//  VVVideoDetailView.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/7.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit
import Kingfisher

protocol VVVideoDetailViewDelegate {
    func playImageViewClick()
    func backBtnDidClick()
}

class VVVideoDetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.addSubview(albumImageView)
        self.addSubview(blurImageView)
        self.addSubview(blurView)
        self.addSubview(backButton)
        self.addSubview(playImageView)
        self.addSubview(videoTitleLabel)
        self.addSubview(lineView)
        self.addSubview(classifyLabel)
        self.addSubview(descibeLabel)
        self.addSubview(bottomToolView)
        
        
        let itemSize: CGFloat = 80
        
        for i in 0..<bottomImgArray.count {
            
            let btn = BottomItemButton(frame: CGRect(x: UIConstant.UI_MARGIN_15 + CGFloat(i) * itemSize, y: 0, width: itemSize, height: bottomToolView.height), title: "0", image: bottomImgArray[i]!)
            
            itemArray.append(btn)
            
            bottomToolView.addSubview(btn)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: ItemModel! {
    
    
        didSet {
        
            self.blurImageView.kf.setImage(with: URL(string: model.feed), placeholder: UIImage(named: "7e42a62065ef37cfa233009fb364fd1e_0_0"))
            videoTitleLabel.animationString = model.title
            
            self.classifyLabel.text = model.subTitle
            
            self.itemArray.first?.setTitle("\(model.collectionCount!)", for: .normal)
            self.itemArray[1].setTitle("\(model.shareCount!)", for: .normal)
            self.itemArray[2].setTitle("\(model.replyCount!)", for: .normal)
            self.itemArray.last?.setTitle("缓存", for: .normal)
            
            self.descibeLabel.text = model.description
            
            let size = self.descibeLabel.bounding(with: descibeLabel.size)
            self.descibeLabel.frame = CGRect(x: descibeLabel.x, y: descibeLabel.y, width: size.width, height: size.height)
        }
    
    }
    
    var  delegate: VVVideoDetailViewDelegate?
    
    
    
    lazy var albumImageView: UIImageView = {
        
        let photoW: CGFloat = 1222.0
        
        let photoH: CGFloat = 777.0
        let albumImageViewH = self.height * 0.6
        let albumImageViewW = photoW * albumImageViewH / photoH
        
        let albumImageViewX = (albumImageViewW - self.width) * 0.5
        let albumImageView = UIImageView(frame: CGRect(x: -albumImageViewX, y: 0, width: albumImageViewW, height: albumImageViewH))
        albumImageView.clipsToBounds = true
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.isUserInteractionEnabled = true
        
        return albumImageView
    
    }()
    
    lazy var blurImageView: UIImageView = {
        
        var blurImageView = UIImageView(frame: CGRect(x: 0, y: self.albumImageView.height, width: self.width, height: self.height - self.albumImageView.height))
        
        return blurImageView
    
    }()
    
    lazy var blurView: UIVisualEffectView = {
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.blurImageView.frame
        return blurView
    }()
    
    lazy var backButton: UIButton = {
        
        var backButton = UIButton(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: UIConstant.UI_MARGIN_20, width: 40, height: 40))
        
        backButton.setImage(UIImage(named: "play_back_full"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonDidClick), for: .touchUpInside)
        return backButton
    
    }()
    
    lazy var playImageView: UIImageView = {
        
        var playImageView = UIImageView(image: UIImage(named: "ic_action_play"))
        
        playImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        playImageView.center = self.albumImageView.center
        
        playImageView.contentMode = .scaleAspectFit
        
        playImageView.viewAddTarget(target: self, action: #selector(playImageViewDidClick))
        
        return playImageView
    }()
    
    lazy var videoTitleLabel: VVShapeView = {
        
        let rect = CGRect(x: UIConstant.UI_MARGIN_10, y: self.albumImageView.frame.maxY + UIConstant.UI_MARGIN_10, width: self.width - 2*UIConstant.UI_MARGIN_10, height: 20)
        
        var videoTitleLabel = VVShapeView(frame: rect)
        
        videoTitleLabel.fontSize = UIConstant.UI_FONT_16
        
        return videoTitleLabel
    
    }()
    
    private lazy var lineView: UIView = {
        
        var lineView = UIView(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: self.videoTitleLabel.frame.maxY + UIConstant.UI_MARGIN_10, width: self.width - 2*UIConstant.UI_MARGIN_10, height: 0.5))
        
        lineView.backgroundColor = UIColor.white
        
        return lineView
    
    }()
    
    lazy var classifyLabel: UILabel = {
        
        var classifyLabel = UILabel(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: self.lineView.frame.maxY + UIConstant.UI_MARGIN_10, width: self.width - 2*UIConstant.UI_MARGIN_10, height: 20))
        
        classifyLabel.textColor = UIColor.white
        
        return classifyLabel
    
    }()
    
    lazy var descibeLabel: UILabel = {
        
        var descibeLabel = UILabel(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: self.classifyLabel.frame.maxY + UIConstant.UI_MARGIN_10, width: self.width - 2*UIConstant.UI_MARGIN_10, height: 200))
        
        descibeLabel.numberOfLines = 0
        
        descibeLabel.textColor = UIColor.white
        
        return descibeLabel
    
    }()
    
    lazy var bottomToolView: UIView = {
        
        var bottomToolView = UIView(frame: CGRect(x: 0, y: self.height - 50, width: self.width, height: 30))
        
        bottomToolView.backgroundColor = UIColor.clear
        
        return bottomToolView
    
    }()
    
    private var itemArray: [BottomItemButton] = [BottomItemButton]()
    
    private var bottomImgArray = [UIImage(named: "ic_action_favorites_without_padding"), UIImage(named: "ic_action_share_without_padding"), UIImage(named: "ic_action_reply_nopadding"), UIImage(named: "action_download_cut")]
    
    private class BottomItemButton: UIButton {
        
        private var title: String!
        private var image: UIImage!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.white, for: .normal)
        }
        
        convenience init(frame: CGRect, title: String, image: UIImage) {
            
            self.init(frame: frame)
            
            self.title = title
            
            self.image = image
            
            self.setImage(image, for: .normal)
            self.setTitle(title, for: .normal)
        
        }
        
        override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
            return CGRect(x: self.height - 8, y: 0, width: self.width - self.height + 8, height: self.height)
        }
        
         override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
            return CGRect(x: 0, y: 8, width: self.height - 16, height: self.height - 16)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    }
    
    
    
    @objc private func playImageViewDidClick() {
        
        delegate?.playImageViewClick()
    }
    
    @objc private func backButtonDidClick(){
    
        
        delegate?.backBtnDidClick()
    
    }
    
    
    

}
