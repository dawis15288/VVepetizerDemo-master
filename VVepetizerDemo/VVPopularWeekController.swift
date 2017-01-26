//
//  VVPopularWeekController.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/3.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

class VVPopularWeekController: UIViewController, LoadingPresenter {
    
    var loaderView: VVLoaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red

        // Do any additional setup after loading the view.
        
        self.view.addSubview(collectionView)
        
        setupLoaderView()
        
        getData()
        
    }
    
    private func getData(api: String = VVAPIHeaper.API_Popular_Weakly) {
        
        setLoaderViewHidden(hidden: false)
        
        Alamofire.request(api, method: .get).responseData { (response) in
            
           if response.result.isSuccess {
                
                let json = JSON(data: response.result.value!)
                
                let dataDict = json.rawValue as! NSDictionary
            
                let itemArray = dataDict["videoList"] as! NSArray
                
                self.modeList = itemArray.map({ (dict) -> ItemModel in
                    
                    ItemModel(dict: dict as? NSDictionary)
                })
            
                self.collectionView.reloadData()
            }
            
            self.setLoaderViewHidden(hidden: true)
        }
        
        
    }
    
    
    fileprivate var modeList: [ItemModel] = [ItemModel]()
    
    private lazy var collectionView: VVCollectionView = {
        
        let rect = CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGTH - UIConstant.UI_TAB_HEIGHT
         - UIConstant.UI_CHARTS_HEIGHT - UIConstant.UI_NAV_HEIGHT)
        
        var collectionView = VVCollectionView(frame: rect, collectionViewLayout: VVCollectionViewLayout())
        
        let layout = collectionView.collectionViewLayout as! VVCollectionViewLayout
        
        layout.footerReferenceSize = CGSize(width: collectionView.width, height: 50)
        
        collectionView.register(VVPopularFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: VVPopularFooterView.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

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

extension VVPopularWeekController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeList.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! VVChoiceCell
        
        cell.model = modeList[indexPath.row]
        
        cell.index = "\(indexPath.row)"
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VVChoiceCell.reuseIdentifier, for: indexPath) as!  VVChoiceCell
        return cell
    }

}
