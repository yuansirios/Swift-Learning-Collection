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
import SwiftyJSON
import HandyJSON

struct YSListModel : Mappable {
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

class BasicTypes: HandyJSON {
    var id : String!
    var title : String!
    var subTitle : String!
    var event : String!
    var sub : BasicTypes?

    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.id <-- "B_id"
        mapper <<<
            self.event <-- "B.event"
    }
}

private let cellIdentifier = "cellIdentifier"

//声明代理协议
protocol YSListViewDelegate {
    //代理方法
    func turnToLayoutView()
}

class YSListView : UIView{
    
    var didSetupConstraints = false
    //代理属性
    public var delegate:YSListViewDelegate?
    //定义block
    typealias turnToLayoutViewBlock = () ->()
    //创建block变量
    var layoutBlock:turnToLayoutViewBlock!
    
    // MARK: - *********** 初始化 ***********
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            tableView.snp_makeConstraints { (maker) in
                maker.edges.equalToSuperview()
            }
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    // MARK: - *********** EventList ***********
    // 函数前必须加 @objc关键字
    @objc func event() {
        ObjTest().showInfo()
    }
    
    @objc func event2() {
        
        /**
         HandyJSON
         */
        let jsonData = dataForJson(fileName: "Array.json")
        let jsonArrayString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as String?
        //JSON字符串转模型
        if let list = [BasicTypes].deserialize(from: jsonArrayString) {
            list.forEach({ (BasicTypes) in
                if let title = BasicTypes?.title {
                    print("JSON字符串转模型:\(title)")
                }
                
                if let sub = BasicTypes?.sub {
                    print("sub:\(sub.title ?? "")")
                }
                
                if let bid = BasicTypes?.id {
                    print("bid:\(bid)")
                }
                
                if let event = BasicTypes?.event {
                    print("event:\(event)")
                }
                
                //模型转JSON
                if let jsonStr = BasicTypes?.toJSONString()!{
                    print("模型转化为JSON:\(jsonStr)")
                }
            })
        }
        /**
         SwiftJSON
         
        let jsonData = dataForJson(fileName: "Array.json")
        let jsonObj = JSON(jsonData)
        if jsonObj.type == .array{
            //Data转JSONData
            print("Data转JSONData :\(jsonObj[0]["title"])")
            
            //JSON转化为String字符串
            if let jsonStr = jsonObj.rawString() {
                print("JSON转化为String字符串 :\(jsonStr)")
            }
            
            //JSON转化为Array数组（[AnyObject]?）
            if let arr = jsonObj.arrayObject {
                print("JSON转化为Array数组 :\(arr)")
            }
        }
        */
        
        /*原生方式
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
        print("字典转json :\(dicJson)")*/
    }
    
    // MARK: - *********** 代理和Block尝试 ***********
    @objc func event3(){
        if delegate != nil {
            delegate?.turnToLayoutView()
        }
        
        if let _ = layoutBlock{
            layoutBlock()
        }
    }
    
    @objc func event4(){
//        YSNetwork().testGetRequest()
//        YSNetwork().testPostRequest()
        YSNetwork().testUploadFile()
    }
    
    // MARK: - *********** 懒加载 ***********
    lazy var dataArr : NSArray = {
        let jsonData = dataForJson(fileName: "Array.json")
        let jsonStr = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
        let dicArr = getArrayFromJSONString(jsonString: jsonStr! as String)
        
        //数组转模型
        var modelArr = [YSListModel]()
        for var item in dicArr{
            let model =  Mapper<YSListModel>().map(JSON: item as! [String : Any])
            modelArr.append(model!)
        }
        return modelArr as NSArray
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView.init()
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = UIView()
        return table
    }()
}

// MARK: - *********** UITableViewDelegate ***********
extension YSListView:UITableViewDelegate,UITableViewDataSource{
    
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
}
