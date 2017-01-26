//
//  Reuseable.swift
//  VVepetizerDemo
//
//  Created by atom on 2016/12/3.
//  Copyright © 2016年 atom. All rights reserved.
//

import UIKit

public protocol Reuseable: class {
    
    static var reuseIdentifier: String { get }

}

extension Reuseable {

    
    static var reuseIdentifier: String {
    
        return String(describing: self)
    }
}

public extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(cellClass: T.Type) where T: Reuseable {
        
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    
    }

}
