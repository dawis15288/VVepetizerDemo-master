//
//  VVDiscoverController.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/2.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

import Alamofire

import SwiftyJSON

class VVDiscoverController: VVBaseViewController, LoadingPresenter {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(collectionView)
        
        self.title = "发现更多"
        
        setupLoaderView()
        
        getData()

    }
    
    private func getData() {
        
        setLoaderViewHidden(hidden: false)
        
        Alamofire.request(VVAPIHeaper.API_Discover, method: .get).responseJSON { (response) in
            
            switch response.result {
                
                case .success(let value):
                
                    let json = JSON(value)
                
                    let jsonArray = json.arrayValue
                
                    self.modelArray = jsonArray.map({ (dict) -> VVDiscoverModel in
                        
                        return VVDiscoverModel(dict: dict.rawValue as!NSDictionary)
                        
                    })
                
                self.collectionView.reloadData()
                
                case .failure(let error):
                
                    print(error)
            
            }
            
            self.setLoaderViewHidden(hidden: true)
            
        }
    
    }
    
    var modelArray: [VVDiscoverModel] = [VVDiscoverModel]()
    
    var loaderView: VVLoaderView!
    
    private lazy var collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        
        let itemSize = UIConstant.SCREEN_WIDTH/2 - 0.5
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.sectionInset = UIEdgeInsets.zero
        
        layout.minimumLineSpacing = 1
        
        layout.minimumInteritemSpacing = 1
        
        var collectionView: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.register(VVDiscoverCell.self, forCellWithReuseIdentifier: VVDiscoverCell.reuseIdentifier)
        //collectionView.registerClass(cellClass: VVChoiceCell.self)
        
        
        collectionView.backgroundColor = UIColor.white
        
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
     
     
     如何评价周杰伦的《娘子》这首歌？

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VVDiscoverController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as! VVDiscoverCell
        
        cell.model = modelArray[indexPath.row]
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VVDiscoverCell.reuseIdentifier, for: indexPath)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}
