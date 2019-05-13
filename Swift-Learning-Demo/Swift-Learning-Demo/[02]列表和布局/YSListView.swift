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

//声明代理协议
protocol YSListViewDelegate {
    //代理方法
    func turnToLayoutView()
}

class YSListView : UIView,UITableViewDelegate,UITableViewDataSource{
    
    //代理属性
    public var delegate:YSListViewDelegate?
    
    //定义block
    typealias turnToLayoutViewBlock = () ->()
    //创建block变量
    var layoutBlock:turnToLayoutViewBlock!
    
    //MARK:- 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
    }
    
    //MARK:- 懒加载
    lazy var dataArr : NSArray = {
        let jsonData = dataForJson(fileName: "Array.json")
        let jsonStr = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        let dicArr = getArrayFromJSONString(jsonString: jsonStr! as String)
    
        print("打印所有数据:\(dicArr)")
        
        var modelArr = [YSListModel]()
        for var item in dicArr{
            let model =  Mapper<YSListModel>().map(JSON: item as! [String : Any])
            modelArr.append(model!)
        }
        return modelArr as NSArray
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: self.bounds, style:.plain)
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = UIView()
        return table
    }()
    
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: YSTableViewCell? = nil
    
        if cell != nil {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? YSTableViewCell
        }else{
            cell = YSTableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let model = self.dataArr[indexPath.row] as? YSListModel
        cell?.model = model
        cell?.textLabel?.text = model?.title
        cell?.detailTextLabel?.text = model?.subTitle
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArr[indexPath.row] as? YSListModel
        let selector = Selector(model!.event)
        
        if self.responds(to:selector) {
            self.perform(selector)
        }else{
            print("\(selector.description)方法不存在！！！")
        }
    }
    
    //MARK: - EventList
    
    // 函数前必须加 @objc关键字
    @objc func event() {
        ObjTest().showInfo()
    }
    
    @objc func event2() {
        let jsonData = dataForJson(fileName: "Array.json")
        let jsonStr = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        let arr = getArrayFromJSONString(jsonString: jsonStr! as String)
        print("json转数组 :\(arr)")
        
        let arrJson = getJSONStringFromArray(array: arr as NSArray)
        print("数组转json :\(arrJson)")
        
        let jsonData2 = dataForJson(fileName: "Dictionary.json")
        let jsonStr2 = NSString(data: jsonData2 as Data, encoding: String.Encoding.utf8.rawValue)
        let dic = getDictionaryFromJSONString(jsonString: jsonStr2! as String)
        print("json转字典 :\(dic)")
        
        let dicJson = getJSONStringFromDictionary(dictionary: dic as NSDictionary)
        print("字典转json :\(dicJson)")
    }
    
    @objc func event3(){
        if delegate != nil {
            delegate?.turnToLayoutView()
        }
        
        if let _ = layoutBlock{
            layoutBlock()
        }
    }
}
