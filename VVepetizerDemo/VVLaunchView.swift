//
//  VVLaunchView.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVLaunchView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var blackBgView: UIView!
    
    typealias AnimationDidStopCallBack = (_ launchView: VVLaunchView) -> Void
    
    var callBack: AnimationDidStopCallBack?
    
    class func launchView() -> VVLaunchView {
        
        //let nib = UINib(nibName: "VVLaunchView", bundle: nil)
        
        //let view = nib.instantiate(withOwner: nil, options: nil).first as!VVLaunchView
        
        return Bundle.main.loadNibNamed("VVLaunchView", owner: nil, options: nil)?.first as! VVLaunchView
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startAnimation()
    }
    
    fileprivate func startAnimation() {
        
        UIView.animate(withDuration: 5, delay: 1, options: .curveEaseInOut, animations: {
            
            self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            self.blackBgView.alpha = 0
        
        }) { [unowned self] _ in
        
            self.blackBgView.removeFromSuperview()
            
            if let cb = self.callBack {
                
                cb(self)
            
            }
        
        }
    
    }
    
    func animationDidStop(callBack: AnimationDidStopCallBack?) {
        
        self.callBack = callBack
    
    }
    

}
