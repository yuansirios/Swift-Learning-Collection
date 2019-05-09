//
//  YSListView.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/8.
//  Copyright © 2019 yuan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct YSListModel :Mappable {
    var title : String!
    var subTitle : String!
    var event : String!
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        subTitle <- map["subTitle"]
        event <- map["event"]
    }
    
    init?(map: Map) {
    
    }
}

private let cellIdentifier = "cellIdentifier"

class YSListView : UIView,UITableViewDelegate,UITableViewDataSource{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
    }
    
    //MARK:- 懒加载
    lazy var dataArr : NSArray = {
        let jsonData = dataForJson(fileName: "YSList.json")
        
        var dicArr = try! JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as! [[String:AnyObject]]
        print("打印所有数据:\(dicArr)")
        
        var modelArr = [YSListModel]()
        
        for var item in dicArr{
            let model =  Mapper<YSListModel>().map(JSON: item as [String : Any])
            modelArr.append(model!)
        }
        return modelArr as NSArray
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: self.bounds, style:.plain)
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = UIView()
        table.register(YSTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return table
    }()
    
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! YSTableViewCell
        
        let model = self.dataArr[indexPath.row] as? YSListModel
        cell.model = model
        cell.textLabel?.text = model?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArr[indexPath.row] as? YSListModel
        print("点击了:\(model?.title)")
    }
}
