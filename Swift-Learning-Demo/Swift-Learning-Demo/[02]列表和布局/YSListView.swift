//
//  YSListView.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/8.
//  Copyright © 2019 yuan. All rights reserved.
//

import Foundation
import UIKit

class YSListView : UIView,UITableViewDelegate,UITableViewDataSource{
    
    var dataArr = NSArray()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dataArr = ["1","2"]
        
        self.addSubview(self.tableView)
    }
    
    //MARK:- 懒加载
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: self.bounds, style:.plain)
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = UIView()
        return table
    }()
    
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style:.default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = dataArr[indexPath.row] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let value = dataArr[indexPath.row] as! String
        print("点击了:\(value)")
    }
}
