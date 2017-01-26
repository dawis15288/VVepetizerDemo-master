//
//  VVPullToRefreshView.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/4.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

var animationDuration: TimeInterval = 0.3

var pullToRefreshHeight: CGFloat = 80

let refreshHeaderTimeKey: String =  "RefreshHeaderView"
let refreshContentOffset: String =  "contentOffset"
let refreshContentSize: String =  "contentSize"

enum PullToRefreshViewType {

    case Header
    
    case Footer
}

enum PullToRefreshViewState {
    
    case nomal
    
    case pulling
    
    case refreshing

}

class VVPullToRefreshView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        loadView = VVLoaderView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        
        loadView.center = self.center
        
        self.addSubview(loadView)
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        if (self.superview != nil) {
            
            self.superview?.removeObserver(self, forKeyPath: refreshContentOffset as String, context: nil)
        
        
        }
        
        if (newSuperview != nil) {
            
            newSuperview?.addObserver(self, forKeyPath: refreshContentOffset as String, options: .new, context: nil)
        
            var rect: CGRect = self.frame
            
            rect.size.width = newSuperview!.frame.size.width
            
            rect.origin.x = 0
            
            self.frame = rect
            
            scrollView = newSuperview as! UIScrollView
            
            scrollViewOriginalInset = scrollView.contentInset
        
        }
        
    }
    
    func isRefresh() -> Bool {
        
        return PullToRefreshViewState.refreshing == state
    
    }
    
    func beginRefreshing() {
        
        if (self.window != nil) {
            
            state = .refreshing
            
        } else {
            
            state = .nomal
            
            super.setNeedsDisplay()
        
        }
    
    }
    
    func endRefreshing() {
        
        if state == .nomal {
            
            return
        
        }
        
        let delayInSeconds: Double = 0.3
        
        //let popTime = DispatchTime(uptimeNanoseconds: UInt64(Int64(delayInSeconds)))
        
        //DispatchTime(uptimeNanoseconds: 999.0)
        
        //let popTime: dispatch_time_t = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(delayInSeconds))
        
        let popTime = DispatchTime(uptimeNanoseconds: UInt64(delayInSeconds))
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            
            self.state = .nomal
            
        }
    
    }
    
    typealias beginRefreshingBlock = () -> Void
    
    var loadView: VVLoaderView!
    
    fileprivate var scrollView: UIScrollView!
    
    fileprivate var scrollViewOriginalInset: UIEdgeInsets!
    
    var beginRefreshingCallBack: beginRefreshingBlock?
    
    var oldState: PullToRefreshViewState! = .nomal
    
    var state: PullToRefreshViewState = .nomal {
        
        willSet {
            
            self.state = newValue
        
        }
        
        didSet {
            
            guard self.state != self.oldState  else {
                
                return
                
            }
            
            switch self.state {
                
            case .nomal:
                
                loadView.stopLoadAnimation()
                
            case .pulling:
                
                break
                
            case .refreshing:
                
                loadView.startLoadingAnimation()
                
                if let callBack = beginRefreshingCallBack {
                    
                    callBack()
                
                }
            }
        
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class VVPullToRefreshHeaderView: VVPullToRefreshView {
    
    class func headerView() -> VVPullToRefreshHeaderView {
    
        return VVPullToRefreshHeaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: pullToRefreshHeight))
        
    
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        var rect: CGRect = self.frame
        
        rect.origin.y = -pullToRefreshHeight
        
        self.frame = rect
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard self.state != .refreshing else {
        
            return
            
        }
        
        guard refreshContentOffset == keyPath else {
        
            return
        
        }
        
        let currentOffsetY: CGFloat = self.scrollView.contentOffset.y + UIConstant.UI_NAV_HEIGHT
        
        if (currentOffsetY) >= 0 {
            
            return
        
        }
        
        if self.scrollView.isDragging {
        
            let happendOffsetY = fabs(currentOffsetY)
            
            if state == .nomal && happendOffsetY > pullToRefreshHeight {
                
                state = .pulling
            
            } else if state == .pulling && happendOffsetY <= pullToRefreshHeight {
                
                state = .nomal
            
            } else if state == .nomal && happendOffsetY < pullToRefreshHeight {
            
                state = .nomal
            }
        
        } else if state == .pulling {
            
            state = .refreshing
        
        }
    }
    
    override var state: PullToRefreshViewState {
        
        willSet {
            
            oldState = state
        
        }
        
        didSet {
            
            switch state {
            case .nomal:
                
                if PullToRefreshViewState.refreshing == oldState {
                    
                    UIView.animate(withDuration: animationDuration, animations: { 
                        
                        var contentInset: UIEdgeInsets = self.scrollView.contentInset
                        
                        contentInset.top = self.scrollViewOriginalInset.top + UIConstant.UI_NAV_HEIGHT
                        
                        self.scrollView.contentInset = contentInset
                    })
                
                }
                
            case .pulling:
                
                break
                
            case .refreshing:
                
                UIView.animate(withDuration: animationDuration, animations: { 
                    
                    let top: CGFloat = self.scrollViewOriginalInset.top + self.frame.size.height
                    
                    var inset: UIEdgeInsets = self.scrollView.contentInset
                    
                    inset.top = top + UIConstant.UI_NAV_HEIGHT
                    
                    self.scrollView.contentInset = inset
                    
                    
                    var offset: CGPoint = self.scrollView.contentOffset
                    
                    offset.y = -top - UIConstant.UI_NAV_HEIGHT
                    
                    self.scrollView.contentOffset = offset
                })
            }
        
        }
    
    }

}
