//
//  VVMainTabView.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

protocol VVMainTabViewDelegate {
    
    func tabBarDidSelector(fromSelectorButton from: Int, toSelectorButton to : Int, title:String)
    
}

class VVMainTabView: UIView {

    @IBOutlet weak var choiceButton: UIButton!
    
    @IBOutlet weak var discoverButton: UIButton!

    @IBOutlet weak var popularButton: UIButton!
    
    private weak var selectorButton: UIButton!
    
    var delegate: VVMainTabViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bringSubview(toFront: choiceButton)
        self.bringSubview(toFront: discoverButton)
        self.bringSubview(toFront: popularButton)
        
        setupButtonFont(tabButton: choiceButton)
        
        setupButtonFont(tabButton: discoverButton)
        
        setupButtonFont(tabButton: popularButton)
        
        selectorButton = choiceButton
        
    }
    
    class func tabView() -> VVMainTabView {
        
        return Bundle.main.loadNibNamed("VVMainTabView", owner: nil, options: nil)?.first as! VVMainTabView
    
    }
    
    fileprivate func setupButtonFont(tabButton button: UIButton) {
    
        //button.titleLabel?.font = UIFont.customFont_FZLTXIHJW()
        
        button.setTitleColor(UIColor.lightGray, for: .normal)
        
        button.setTitleColor(UIColor.black, for: [.highlighted, .selected])
        
        button.setTitleColor(UIColor.black, for: .selected)
    }
    
    fileprivate func setupSelectButton(_ selectButton: UIButton) {
        
        guard selectorButton != selectButton else {
            
            return
        
        }
        
        selectorButton.isSelected = false
        
        selectButton.isSelected = true
        
        delegate?.tabBarDidSelector(fromSelectorButton: selectorButton.tag, toSelectorButton: selectButton.tag, title: (selectButton.titleLabel?.text)!)
        
        selectorButton = selectButton
    
    }
    @IBAction func choicButtonClick(_ sender: UIButton) {
        
        setupSelectButton(sender)
        
    }
    @IBAction func discoverButtonClick(_ sender: UIButton) {
        
        setupSelectButton(sender)
    }
    @IBAction func popularButtonClick(_ sender: UIButton) {
        setupSelectButton(sender)
    }
    
}
