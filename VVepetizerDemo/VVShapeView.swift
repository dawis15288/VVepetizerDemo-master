//
//  VVShapeView.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/11.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVShapeView: UIView {
    
    var pathLayer: CAShapeLayer!
    
    var animationString: String! {
        
        didSet {
            
            //let pathLayer =
            
        
        }
    
    }
    
    var font: UIFont!
    
    var fontSize: CGFloat!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }
    
    private func setupDefaultLayer() -> CAShapeLayer {
        
        return CAShapeLayer()
    
    }
    
    func startAnimation() {
        
        self.layer.addSublayer(pathLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        //animation.delegate = self
        
        animation.fromValue = 0.0
        
        animation.toValue = 1.0
        
        animation.duration = 0.5
        
        animation.isRemovedOnCompletion = false
        
        self.pathLayer.add(animation, forKey: animation.keyPath)
    }
    
    func stopAnimation() {
        
        self.pathLayer.removeAllAnimations()//
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
