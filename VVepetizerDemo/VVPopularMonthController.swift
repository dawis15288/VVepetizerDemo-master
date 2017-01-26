//
//  VVPopularMonthController.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/3.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

class VVPopularMonthController: UIViewController, LoadingPresenter {
    
    var loaderView: VVLoaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blue
        
        self.view.addSubview(collectionView)
        
        setupLoaderView()
        
        getData()
        
    }
    
    private func getData() {
    
        setLoaderViewHidden(hidden: false)
        
        Alamofire.request(VVAPIHeaper.API_Popular_Monthly, method: .get).responseData { [unowned self] (response) in
            
            if response.result.isSuccess {
            
                let json = JSON(data: response.data!)
                
                let dataDict = json.rawValue as! NSDictionary
                
                let itemArray = dataDict["videoList"] as! NSArray
                
                self.modelList = itemArray.map({ (dict) -> ItemModel in
                    ItemModel(dict: dict as? NSDictionary)
                })
                
                self.collectionView.reloadData()
            }
            
            self.setLoaderViewHidden(hidden: true)
        }
    
    }
    
    var modelList: [ItemModel] = [ItemModel]()
    
    private lazy var collectionView: VVCollectionView = {
        
        let rect = CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGTH - UIConstant.UI_TAB_HEIGHT - UIConstant.UI_CHARTS_HEIGHT - UIConstant.UI_NAV_HEIGHT)
        
        let collectionView = VVCollectionView(frame: rect, collectionViewLayout: VVCollectionViewLayout())
        
        collectionView.register(VVChoiceHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: VVChoiceHeaderView.reuseIdentifier)
        collectionView.register(VVPopularFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: VVPopularFooterView.reuseIdentifier)
        
        let layout = collectionView.collectionViewLayout as! VVCollectionViewLayout
        
        layout.footerReferenceSize = CGSize(width: collectionView.width, height: 50)
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        return collectionView
        
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


extension VVPopularMonthController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! VVChoiceCell
        
        cell.model = modelList[indexPath.row]
        
        cell.index = "\(indexPath.row + 1)"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VVChoiceCell.reuseIdentifier, for: indexPath)
        
        return cell
    }

}
