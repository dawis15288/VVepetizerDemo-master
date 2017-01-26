//
//  VVVideoDetailPushTransition.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVVideoDetailPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private  var fromVC: VVVideoDetailController!
    
    private var toVC: VVBaseViewController!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! VVVideoDetailController
        let toVC = transitionContext.viewController(forKey: .to) as! VVBaseViewController
        
        let container = transitionContext.containerView
        
        self.fromVC = fromVC
        
        self.toVC = toVC
        
        fromVC.detailView.backButton.alpha = 0
        
        if let snapShotView = fromVC.detailView.albumImageView.snapshotView(afterScreenUpdates: false) {
            
            snapShotView.frame = fromVC.detailView.albumImageView.frame
            
            fromVC.detailView.albumImageView.isHidden = true
            
            fromVC.detailView.blurImageView.isHidden = true
            
            fromVC.detailView.blurView.isHidden = true
            
            fromVC.detailView.bottomToolView.isHidden = true
            
            let cover = UIView(frame: snapShotView.frame)
            
            cover.backgroundColor = UIColor.black
            cover.alpha = 0
            
            if let blurImageView = fromVC.detailView.blurImageView.snapshotView(afterScreenUpdates: false){
                
                blurImageView.frame = fromVC.detailView.blurImageView.frame
                
                let blurEffect = UIBlurEffect(style: .light)
                
                let blurView = UIVisualEffectView(effect: blurEffect)
                
                blurView.frame = blurImageView.frame
                
                
                
                toVC.view.frame = transitionContext.finalFrame(for: toVC)
                
                toVC.selectCell.bacgroundImageView.isHidden = true
                
                toVC.selectCell.titleLabel.alpha = 0
                
                toVC.selectCell.subTitleLabel.alpha = 0
                
                container.addSubview(toVC.view)
                container.addSubview(snapShotView)
                container.addSubview(cover)
                
                container.addSubview(blurView)
                container.addSubview(blurImageView)
                
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
                    
                    let frame = toVC.selectCell.bacgroundImageView.frame
                    
                    let snapShotFrame = container.convert(frame, from: toVC.selectCell)
                    
                    snapShotView.frame = snapShotFrame
                    
                    cover.frame = snapShotFrame
                    cover.alpha = 0.3
                    
                    blurImageView.frame = CGRect(x: 0, y: snapShotFrame.maxY, width: snapShotFrame.width, height: 0)
                    blurView.frame = CGRect(x: 0, y: snapShotFrame.maxY, width: snapShotFrame.width, height: 0)
                    
                }) {[unowned self] (finish: Bool) in
                    toVC.selectCell.bacgroundImageView.isHidden = false
                    fromVC.detailView.backButton.alpha = 1
                    snapShotView.removeFromSuperview()
                    
                    cover.removeFromSuperview()
                    blurImageView.removeFromSuperview()
                    blurView.removeFromSuperview()
                    
                    fromVC.detailView.albumImageView.isHidden = false
                    fromVC.detailView.blurImageView.isHidden = false
                    fromVC.detailView.blurView.isHidden = false
                    fromVC.detailView.bottomToolView.isHidden = false
                    
                    self.titleAnimation()
                    
                    if !fromVC.panIsCancel {
                        
                        self.tabbarAnimation()
                    }
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    
                }
            }
            
            
            
            
            
        }
        
        
        
        
        
    }
    private func tabbarAnimation() {
        
        let tabbarSnapshotView = toVC.tabBarController?.tabBar
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: { 
            tabbarSnapshotView?.y = UIConstant.SCREEN_HEIGTH - UIConstant.UI_TAB_HEIGHT
        }) { (_) in
            
        }
    
    }
    
    private func titleAnimation() {
        
        UIView.animate(withDuration: 0.3) {
            self.toVC.selectCell.titleLabel.alpha = 1
            self.toVC.selectCell.subTitleLabel.alpha = 1
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
