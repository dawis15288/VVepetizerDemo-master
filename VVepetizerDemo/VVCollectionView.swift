//
//  VVCollectionView.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

class VVCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        let itemHeight = 200 * UIConstant.SCREEN_WIDTH / UIConstant.IPHONE5_WIDTH
        
        itemSize = CGSize(width: UIConstant.SCREEN_WIDTH, height: itemHeight)
        
        sectionInset = UIEdgeInsets.zero
        
        minimumLineSpacing = 0
        
        minimumInteritemSpacing = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class VVCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = UIColor.white
        
        //register(VVChoiceCell.self, forCellWithReuseIdentifier: VVChoiceCell.reuseIdentifier)
        registerClass(cellClass: VVChoiceCell.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
