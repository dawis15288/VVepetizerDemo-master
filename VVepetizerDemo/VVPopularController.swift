//
//  VVPopularController.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVPopularController: VVBaseViewController, LoadingPresenter {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "热门排行"
        
        self.view.addSubview(headerView)
        
        headerView.headerViewTitleDidClick {[unowned self] (targetButton, index) in
            
            self.itemDidClick(index: index)
        }
        
        itemDidClick(index: 0)
        
    }
    
    private func itemDidClick(index: Int) {
        
        var actionController: UIViewController!
        
        switch index {
        case 0:
            if weekController == nil {
                
                weekController = VVPopularWeekController()
            }
            
            actionController = weekController
            
            break
        
        case 1:
            
            if monthcontroller == nil {
                
                monthcontroller = VVPopularMonthController()
            }
            
            actionController = monthcontroller
            
            break
            
        case 2:
            
            if historyController == nil {
                
                historyController = VVPopularHistoryViewController()
            
            }
            
            actionController = historyController
            
            break
            
        default:
            break
        }
        
        self.addChildViewController(actionController)
        
        self.view.addSubview(actionController.view)
        
        self.setupControllerFrame(view: actionController.view)
        
        if let currentVC = curreentController {
            
            startAnimation(fromVC: currentVC, toVC: actionController)
            
        } else {
            
            curreentController = actionController
        
        }
        
    }
    
    private func startAnimation(fromVC: UIViewController, toVC: UIViewController) {
        
        toVC.view.alpha = 0
        
        UIView.animate(withDuration: 0.5,animations: {
            
            fromVC.view.alpha = 0
            
            toVC.view.alpha = 1
        }) {[unowned self] (_) in
            
            fromVC.view.removeFromSuperview()
            
            self.curreentController = nil
            
            self.curreentController = toVC
            
        }
    
    }
    
    var loaderView: VVLoaderView!
    
    private var curreentController: UIViewController?
    
    private let titleArray = ["周排行", "月排行", "总排行"]
    
    private lazy var headerView: EYEPopularHeaderView = {
        
        let headerView = EYEPopularHeaderView(frame: CGRect(x: 0, y: UIConstant.UI_NAV_HEIGHT, width: UIConstant.SCREEN_WIDTH, height: UIConstant.UI_CHARTS_HEIGHT), titleArray: self.titleArray)
        
        return headerView
        
    }()
    
    private var weekController: VVPopularWeekController?
    
    private var monthcontroller: VVPopularMonthController?
    
    private var historyController: VVPopularHistoryViewController?
    
    private func setupControllerFrame(view: UIView) {
        
        view.snp.makeConstraints { (make) in
            make.left.trailing.equalTo(self.view)
            make.top.equalTo(self.headerView).offset(headerView.height)
            make.bottom.equalTo(self.view).offset(-UIConstant.UI_TAB_HEIGHT)
        }
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
