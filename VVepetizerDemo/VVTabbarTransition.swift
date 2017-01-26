//
//  VVTabbarTransition.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/11.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVTabbarTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.4
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.viewController(forKey: .from)?.view
        let toView = transitionContext.viewController(forKey: .to)?.view
        containerView.addSubview(toView!)
        toView?.alpha = 0
        fromView?.alpha = 1
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            toView?.alpha = 1
            fromView?.alpha = 0
        
        }) { (_) -> Void in
        
            transitionContext.completeTransition(true)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
