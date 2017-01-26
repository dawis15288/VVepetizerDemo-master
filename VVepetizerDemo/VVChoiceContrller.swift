//
//  VVChoiceContrller.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

class VVChoiceContrller: VVBaseViewController, LoadingPresenter, MenuPresenter {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "每日精选"
        
        self.view.addSubview(collectionView)
        
        setupLoaderView()
        
        getData(api: VVAPIHeaper.API_Choice, params: ["date": Date.getCurrentTimeStamp(), "num": "7"])
        
        setLoaderViewHidden(hidden: false)
        
        setupMenuButton()
        
        collectionView.headerViewPullToRefresh { [unowned self ] in
            
            self.getData(api: VVAPIHeaper.API_Choice, params: ["data": Date.getCurrentTimeStamp(), "num": "7"])
        
        }
    
    }
    
    fileprivate func getData(api: String, params: [String: String]? = nil) {
        
        Alamofire.request(api, method: .get, parameters: params).responseJSON {[unowned self] (response) in
            
            var issueArray: [[String: AnyObject]]?
            
            if response.result.isSuccess {
                
                if let value = response.result.value {
                    
                    let json = JSON(arrayLiteral: value)
                    
                    let array = json.rawValue as! [[String: AnyObject]]
                    
                    for dict in array {
                        
                        self.nextPageURL = dict["nextPageUrl"] as? String
                        
                        issueArray = dict["issueList"] as? [[String: AnyObject]]
                        
                    }
                
                }
                
                let list = issueArray?.map({ (dict) -> IssueModel in
                    
                    return IssueModel(dict: dict as NSDictionary)
                    
                })
                
                if let _ = params {
                    
                    self.issueList = list!
                    
                    self.collectionView.headerEndRefresh()
                
                } else {
                    
                    //self.issueList.append(list)
                
                }
                
                self.setLoaderViewHidden(hidden: true)
                
                self.collectionView.reloadData()
            
            }
        }
    
    }
    
    //解决协议扩展中menuButton.addTarget(self, action: Selector("menuButtonDidClick"), for: .touchUpInside)xcode报错
    
    var selector: Selector = #selector(menuButtonDidClick)
    
    @objc fileprivate func menuButtonDidClick() {
        
        let menuController = VVMenuViewController()
        //menuController.modalPresentationStyle = .custom
       // menuController.transitioningDelegate = self
        self.present(menuController, animated: true, completion: nil)
    
    }
    
    var issueList: [IssueModel] = [IssueModel]()
    
    var loaderView: VVLoaderView!
    
    var nextPageURL: String?
    
    var menuButton: VVMenuButton!
    
    fileprivate lazy var collectionView: VVCollectionView = {
        
        var collectionview: VVCollectionView = VVCollectionView(frame: self.view.bounds, collectionViewLayout: VVCollectionViewLayout())
        
        collectionview.register(VVChoiceHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: VVChoiceHeaderView.reuseIdentifier)
        
        collectionview.delegate = self
        
        collectionview.dataSource = self
        
        return collectionview
    
    }()
    
    private lazy var presentationAnimation = GuillotineTransitionAnimation()

}

extension VVChoiceContrller: UICollectionViewDataSource, UICollectionViewDelegate {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return issueList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       let issueModel: IssueModel = issueList[section]
        
        let itemList = issueModel.itemList
        
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as! VVChoiceCell
        
        let issueModel = issueList[indexPath.section]
        
        cell.model = issueModel.itemList[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VVChoiceCell = collectionView.dequeueReusableCell(withReuseIdentifier: VVChoiceCell.reuseIdentifier, for: indexPath) as! VVChoiceCell
        
        return cell
        
        
    }

}
extension VVChoiceContrller: UIViewControllerTransitioningDelegate {
    
    /*func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //presentationnima
    }*/

}
