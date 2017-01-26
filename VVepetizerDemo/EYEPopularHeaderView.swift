//
//  EYEPopularHeaderView.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/3.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class EYEPopularHeaderView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
    }
    
    convenience init(frame: CGRect, titleArray: [String]) {
        
        self.init(frame: frame)
        
        self.titleArray = titleArray
        
        let itemWidth = (self.width - 2 * UIConstant.UI_MARGIN_20) / CGFloat(titleArray.count)
        
        for i in 0..<titleArray.count {
            
            let title = titleArray[i]
            
            let titleButton = UIButton(frame: CGRect(x: UIConstant.UI_MARGIN_20 + CGFloat(i) * itemWidth, y: 0, width: itemWidth, height: self.height))
            titleButton.backgroundColor = UIColor.clear
            titleButton.setTitleColor(UIColor.black, for: .normal)
            titleButton.tag = i
            titleButton.setTitle(title, for: .normal)
            titleButton.addTarget(self, action: #selector(titleButtonDidClick(button:)), for: .touchUpInside)
            self.addSubview(titleButton)
            self.titleLabelArray.append(titleButton)
        }
        
        self.currentButton = self.titleLabelArray.first
        
        self.addSubview(topLineView)
        self.addSubview(bottomLineView)
    
    }
    
    private var titleArray: [String] = [String]()
    
    private var titleLabelArray = [UIButton]()
    private var isAnimation: Bool! = false
    private var currentButton: UIButton!
    
    @objc private  func titleButtonDidClick(button: UIButton){
    
        guard isAnimation == false && button != self.currentButton else {
            return
        }
        
        self.startAnimation(index: button.tag)
        
        if let _ = block {
            
            self.block!(currentButton, button.tag)
        
        }
        
         self.currentButton = button
    
    }
    
    func headerViewTitleDidClick(block: HeaderViewButtonClickBlock?) {
        
        self.block = block
    }
    
    private func startAnimation(index: Int) {
        
        self.isAnimation = true
        
        let button = self.titleLabelArray[index]
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: { 
            self.topLineView.center.x = button.center.x
            self.bottomLineView.center.x = button.center.x
        }) { (_) in
            self.isAnimation = false
        }
    }
    
    typealias HeaderViewButtonClickBlock = (_ targetButton: UIButton, _ index: Int) -> Void
    
    private var block: HeaderViewButtonClickBlock?
    
    private lazy var topLineView: UIView = {
    
        let topLineView = UIView()
        
        topLineView.backgroundColor = UIColor.black
        topLineView.frame = CGRect(x: 0, y: 0, width: 35, height: 0.5)
        topLineView.center = CGPoint(x: self.titleLabelArray.first!.center.x, y: 12)
        return topLineView
    }()
    private lazy var bottomLineView: UIView = {
        
        let bottomLineView = UIView()
        
        bottomLineView.backgroundColor = UIColor.black
        bottomLineView.frame = CGRect(x: 0, y: 0, width: 35, height: 0.5)
        bottomLineView.center = CGPoint(x: self.titleLabelArray.first!.center.x, y: self.height - 12)
        return bottomLineView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
