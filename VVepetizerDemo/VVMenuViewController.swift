//
//  VVMenuViewController.swift
//  VVepetizerDemo
//
//  Created by atom on 2017/1/12.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        
        self.view.addSubview(blurView)
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(UIConstant.UI_NAV_HEIGHT)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    fileprivate let menuViewCellID = "menuViewCellID"
    let itemArray = ["我的缓存", "功能开关", "我要投稿", "更多应用"]
    
    fileprivate lazy var tableView: UITableView = {
    
        let tableView = UITableView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = VVMenuHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 200))
        tableView.sectionHeaderHeight = 200
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        
        return tableView
    
    }()

}

extension VVMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: menuViewCellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: menuViewCellID)
        }
        
        cell?.backgroundColor = UIColor.clear
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = itemArray[indexPath.row]
        return cell!
    }
}
