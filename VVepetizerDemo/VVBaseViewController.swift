//
//  VVBaseViewController.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVBaseViewController: UIViewController {
    
    var selectCell: VVChoiceCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.delegate = self
        
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

extension VVBaseViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push && toVC is VVVideoDetailController {
        
            return VVVideoDetailPushTransition()
        }
        
        return nil
    }

}
