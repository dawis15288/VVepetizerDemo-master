//
//  VVMainViewController.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        delegate = self
        
        tabBar.addSubview(tabView)
        
        addChildVC()
        
        view.addSubview(launchView)
        
        launchView.animationDidStop { [unowned self] (launchView) in
            
            self.launchViewRemoveAnimation()
            
        }
        
    }
    
    fileprivate lazy var launchView: VVLaunchView = {
        
        var launchView = VVLaunchView.launchView()
        
        return launchView
    
    }()

    fileprivate func addChildVC() {
        
        let choiceController = VVChoiceContrller()
        
        let disoverController  = VVDiscoverController()
        
        let popularController = VVPopularController()
        
        setChildController(vc: choiceController)
        
        setChildController(vc: disoverController)
        
        setChildController(vc: popularController)
    
    }
    
    fileprivate func setChildController(vc: UIViewController) {
        
        //vc.title = "VVEpetizer"
        
        self.addChildViewController(VVNavigationController(rootViewController: vc))
        
        self.view.bringSubview(toFront: vc.view)
    
    }
    
    fileprivate func launchViewRemoveAnimation() {
        
        UIView.animate(withDuration: 1, animations: {
            
            self.launchView.alpha = 0
        
        }) { [unowned self] _ in
            
            self.launchView.removeFromSuperview()
        
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for button in self.tabBar.subviews {
            
            if button is UIControl {
            
                button.removeFromSuperview()
            
            }
        
        }
    }
    
    fileprivate lazy var tabView: VVMainTabView = {
    
        var tabView: VVMainTabView = VVMainTabView.tabView()
        
        tabView.frame = self.tabBar.bounds
        
        tabView.delegate = self
        
        return tabView
    
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VVMainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return VVTabbarTransition()
    }

}

extension VVMainViewController: VVMainTabViewDelegate {
    
    func tabBarDidSelector(fromSelectorButton from: Int, toSelectorButton to: Int, title: String) {
        
        self.selectedIndex = to
        
    }

}
