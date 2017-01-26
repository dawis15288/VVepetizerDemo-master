//
//  VVVideoDetailController.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVVideoDetailController: UIViewController {
    
    var model: ItemModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(detailView)
        detailView.model = model
        
        navigationController?.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItemWithImg(image: UIImage(named: "ic_action_back"), selectorImg: nil, target: self, action: #selector(leftButtonDidClick))
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftButtonDidClick))
        
        edgePan.edges = UIRectEdge.left
        
        self.view.addGestureRecognizer(edgePan)
        
    }
    
    convenience init(model: ItemModel) {
        
        self.init()
        
        self.model = model
        
        self.title = "VVPelizer"
    
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    
    }
    
    @objc private func leftButtonDidClick() {
        
        let _ = self.navigationController?.popViewController(animated: true)
    
    }
    
    @objc private func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {}
    
    lazy var detailView: VVVideoDetailView = {
    
        var detailView = VVVideoDetailView(frame: self.view.bounds)
        
        detailView.delegate = self
        
        return detailView
    
    }()
    
    fileprivate var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    var panIsCancel: Bool = false

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

extension VVVideoDetailController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop {
            
            return VVVideoDetailPopTransition()
        
        } else {
            
            return nil
        
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController is VVVideoDetailPopTransition {
            
            return self.percentDrivenTransition
        
        } else {
            
            return nil
        
        }
        
    }

}

extension VVVideoDetailController: VVVideoDetailViewDelegate {
    
    func playImageViewClick() {
        
        //let playerController = VVP
        
        
    }
    
    func backBtnDidClick() {
        
        let _ = self.navigationController?.popViewController(animated: true)
        
    }

}
