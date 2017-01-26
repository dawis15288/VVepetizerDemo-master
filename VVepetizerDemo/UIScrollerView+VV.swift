//
//  UIScrollerView+VV.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/4.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func headerViewPullToRefresh(callBack:(() -> Void)?) {
     
        let headerView: VVPullToRefreshHeaderView = VVPullToRefreshHeaderView.headerView()
        
        self.addSubview(headerView)
        
        headerView.beginRefreshingCallBack = callBack
        
        headerView.state = .nomal
    }
    
    func headerViewBeginRefreshing() {
        
        for object: AnyObject in self.subviews {
            
            if object is VVPullToRefreshHeaderView {
                
                object.beginRefreshing()
            
            }
        
        }
    
    }
    
    func headerEndRefresh() {
        
        for object: AnyObject in self.subviews {
            
            if object is VVPullToRefreshHeaderView {
                
                object.endRefreshing()
            
            }
        
        }
    
    }

}
