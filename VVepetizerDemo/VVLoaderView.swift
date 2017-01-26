//
//  VVLoaderView.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/4.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVLoaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(eyeBackgroundLoaderView)
        
        self.addSubview(eyeCenterLoaderView)
    }
    
    func startLoadingAnimation() {
        
        self.isHidden = false
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        animation.fromValue = 0
        
        animation.toValue = M_PI * 2
        
        animation.duration = 2
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = HUGE
        
        animation.fillMode = kCAFillModeForwards
        
        animation.isRemovedOnCompletion = false
        
        self.eyeCenterLoaderView.layer.add(animation, forKey: animation.keyPath)
    
    }
    
    func stopLoadAnimation() {
        
        self.eyeCenterLoaderView.layer.removeAllAnimations()
    
    }
    
    fileprivate lazy var eyeBackgroundLoaderView: UIImageView = {
    
        
        let eyeBackgrounLoaderView = UIImageView(image: UIImage(named: "ic_eye_black_outer"))
        
        eyeBackgrounLoaderView.frame = CGRect(x: 0, y: 0, width: self.height, height: self.height)
        
        eyeBackgrounLoaderView.center = self.center
        
        eyeBackgrounLoaderView.contentMode = .scaleAspectFit
        
        eyeBackgrounLoaderView.layer.allowsEdgeAntialiasing = true
        
        return eyeBackgrounLoaderView
    }()
    
    fileprivate lazy var eyeCenterLoaderView: UIImageView = {
    
        let eyeCenterLoaderView = UIImageView(image: UIImage(named: "ic_eye_black_inner"))
        
        eyeCenterLoaderView.frame = CGRect(x: 0, y: 0, width: self.height - UIConstant.UI_MARGIN_5, height: self.height - UIConstant.UI_MARGIN_5)
        
        eyeCenterLoaderView.center = self.center
        
        eyeCenterLoaderView.contentMode = .scaleAspectFit
        
        eyeCenterLoaderView.layer.allowsEdgeAntialiasing = true
        
        return eyeCenterLoaderView
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
