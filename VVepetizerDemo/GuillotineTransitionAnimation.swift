//
//  GuillotineTransitionAnimation.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/12.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

@objc protocol GuillotineMenu: NSObjectProtocol {
    @objc optional var dismissButton: UIButton! { get}
    @objc optional var titleLabel: UILabel! {get}
}

@objc protocol GuillotineTransitionAnimationDelegate: NSObjectProtocol {
    
    @objc optional func animatorDidFinishPresentation(animator: GuillotineTransitionAnimation)
    @objc optional func animatorDidFinishDismissal(animator: GuillotineTransitionAnimation)
    @objc optional func animatorDWillStartPresentation(animator: GuillotineTransitionAnimation)
    @objc optional func animatorDWillStartDismissal(animator: GuillotineTransitionAnimation)

}

class GuillotineTransitionAnimation: NSObject {
    
    enum Mode { case Presentation, Dismissal }
    
    weak var animationDelegate: GuillotineTransitionAnimationDelegate?
    
    var mode: Mode = .Presentation
    var supportView: UIView?
    var presentButton: UIView?
    var duration = 0.6
    
    private var chromeView: UIView?
    
    private var containerMenuButton: UIButton? {
    
        didSet {
            
            presentButton?.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        
        }
    }
    
    //private let myContext = UnsafeMutableRawPointer()

}
