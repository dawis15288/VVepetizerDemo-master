//
//  LoadingPresenter.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/4.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

protocol LoadingPresenter: class {
    
    var loaderView: VVLoaderView! { get set}
}

extension LoadingPresenter where Self: UIViewController {

    
    func setupLoaderView() {
        
        if loaderView == nil {
            
            loaderView = VVLoaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 100))
            
            loaderView.center = CGPoint(x: UIConstant.SCREEN_WIDTH * 0.5, y: UIConstant.SCREEN_HEIGTH * 0.4)
            
            self.view.addSubview(loaderView)
        
        }
    
    }
    
    func setLoaderViewHidden(hidden: Bool) {
        
        if let view = loaderView {
            
            view.isHidden = hidden
            
            if hidden {
                
                view.stopLoadAnimation()
            
            } else {
                
                view.startLoadingAnimation()
            
            }
        
        }
    
    }
    
    func startLoadingAnimation() {
        
        if let view = loaderView {
            
            view.startLoadingAnimation()
        
        }
    
    }
    
    func stopLoadingAnimation() {
        
        if let view = loaderView {
            
            view.stopLoadAnimation()
        
        }
    
    }

}

protocol MenuPresenter: class {
    
    var selector: Selector {get}
    
    var menuButton: VVMenuButton! { get set }
    
}

extension MenuPresenter where Self: UIViewController {
    
    func setupMenuButton(type: VVMenuButtonType = .none) {
        
        menuButton = VVMenuButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: type)
        
        //menuButton.addTarget(self, action: Selector("menuButtonDidClick"), for: .touchUpInside)
        menuButton.addTarget(self, action: selector, for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    
    }

}
