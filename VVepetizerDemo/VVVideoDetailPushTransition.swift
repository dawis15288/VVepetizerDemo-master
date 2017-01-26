//
//  VVVideoDetailPushTransition.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/12.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVVideoDetailPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var toVC: VVVideoDetailController!
    private var fromVC: VVBaseViewController!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from) as! VVBaseViewController
        let toVC = transitionContext.viewController(forKey: .to) as! VVVideoDetailController
        
        self.fromVC = fromVC
        self.toVC = toVC
        
        guard let backgroundSnapshotView = fromVC.view.snapshotView(afterScreenUpdates: false) else {
            
            return
        }
        
        guard let snapshotView = fromVC.selectCell.bacgroundImageView.snapshotView(afterScreenUpdates: false) else {
            
            return
        }
        
        snapshotView.frame = container.convert(fromVC.selectCell.bacgroundImageView.frame, from: fromVC.selectCell)
        fromVC.selectCell.bacgroundImageView.isHidden = true

        guard let coverView = fromVC.selectCell.coverButton.snapshotView(afterScreenUpdates: false) else { return }
        coverView.frame = container.convert(fromVC.selectCell.coverButton.frame, from: fromVC.selectCell)
        
        let blurImageView = UIImageView(image: fromVC.selectCell.bacgroundImageView.image)
        blurImageView.frame = CGRect(x: 0, y: snapshotView.frame.maxY, width: snapshotView.width, height: 0)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = blurImageView.frame
        
        guard let tabbarSnapshotView = fromVC.tabBarController?.tabBar else { return }
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        toVC.detailView.albumImageView.alpha = 0
        toVC.detailView.blurImageView.alpha = 0
        toVC.detailView.backButton.alpha = 0
        toVC.detailView.playImageView.alpha = 0
        toVC.detailView.classifyLabel.alpha = 0
        toVC.detailView.descibeLabel.alpha = 0
        toVC.detailView.bottomToolView.alpha = 0
        
        container.addSubview(toVC.view)
        container.addSubview(backgroundSnapshotView)
        container.addSubview(snapshotView)
        container.addSubview(coverView)
        container.addSubview(blurImageView)
        container.addSubview(blurView)
        
        toVC.detailView.albumImageView.layoutIfNeeded()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: { 
            snapshotView.frame = toVC.detailView.albumImageView.frame
            coverView.frame = toVC.detailView.albumImageView.frame
            coverView.alpha = 0
            
            blurImageView.frame = toVC.detailView.blurImageView.frame
            blurView.frame = toVC.detailView.blurView.frame
        }) {[unowned self] (finish: Bool) in
            
            toVC.detailView.albumImageView.image = fromVC.selectCell.bacgroundImageView.image
            toVC.detailView.albumImageView.alpha = 1
            toVC.detailView.blurImageView.alpha = 1
            
            backgroundSnapshotView.removeFromSuperview()
            coverView.removeFromSuperview()
            snapshotView.removeFromSuperview()
            blurImageView.removeFromSuperview()
            blurView.removeFromSuperview()
            
            self.playButtonAnimation()
            //self.titleAnimation()
            self.subTitleAnimation()
            
            fromVC.selectCell.bacgroundImageView.isHidden = false
            fromVC.selectCell.coverButton.alpha = 0.3
            fromVC.selectCell.titleLabel.alpha = 1
            fromVC.selectCell.subTitleLabel.alpha = 1
            
            transitionContext.completeTransition(true)
            
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveLinear, animations: { 
            tabbarSnapshotView.y = UIConstant.SCREEN_HEIGTH
            fromVC.navigationController?.navigationBar.y = -UIConstant.UI_NAV_HEIGHT
        }) { (_) in
            fromVC.navigationController?.isNavigationBarHidden = true
        }
        
    }
    
    private func playButtonAnimation() {
        
        let playView = toVC.detailView.playImageView
        
        UIView.transition(with: playView, duration: 0.5, options: .curveEaseOut, animations: { 
            self.toVC.detailView.playImageView.alpha = 1
            self.toVC.detailView.backButton.alpha = 1
        }, completion: nil)
    
    }
    
    private func titleAnimation() {
        
        let titleView = toVC.detailView.videoTitleLabel
        titleView.startAnimation()
    }
    
    private func subTitleAnimation() {
    
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: { 
            self.toVC.detailView.classifyLabel.alpha = 1
            self.toVC.detailView.descibeLabel.alpha = 1
            self.toVC.detailView.bottomToolView.alpha = 1
        }, completion: nil)
    }

}
