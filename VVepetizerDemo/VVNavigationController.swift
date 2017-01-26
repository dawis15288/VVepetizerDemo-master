//
//  VVNavigationController.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            
            interactivePopGestureRecognizer?.delegate = self
            
            //self.navigationBar.titleTextAttributes = ["Font": UIFont.customFont_Lobster(fontSize: UIConstant.UI_FONT_16)]
        
            delegate = self
        
        }
        
        //navigationBar.titleTextAttributes = ["Font": UIFont.customFont_Lobster(fontSize: UIConstant.UI_FONT_16)]
        
        navigationBar.tintColor = UIColor.black
        
        navigationBar.barStyle = .default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) && animated {
            
            interactivePopGestureRecognizer?.isEnabled = false
        
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) && animated {
            
            interactivePopGestureRecognizer?.isEnabled = false
            
        }
        
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) && animated {
            
            interactivePopGestureRecognizer?.isEnabled = false
            
        }
        
        return super.popToViewController(viewController, animated: false)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) && animated {
            
            interactivePopGestureRecognizer?.isEnabled = true
            
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == interactivePopGestureRecognizer {
            
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                
                return false
            
            }
        
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
