//
//  LeetCodeListView.swift
//  Swift-Learning-Demo
//
//  Created by yuan xiaodong on 2020/12/4.
//  Copyright © 2020 yuan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ObjectMapper

private let cellIdentifier = "cellIdentifier"

class LeetCodeViewController: BaseViewController{
    
    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LeetCode"
        view.addSubview(self.tableView)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.snp_makeConstraints { (maker) in
                maker.edges.equalToSuperview()
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    // MARK: - *********** 懒加载 ***********
    lazy var dataArr : NSArray = {
        let jsonData = dataForJson(fileName: "leetCode.json")
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
    
    @objc func twoSum(){
        let nums = [2, 7, 11, 15]
        let taget = 9
        let arr = Solution().twoSum(nums, taget);
        print("twoSum的结果是\(arr)");
    }
}

// MARK: - *********** UITableViewDelegate ***********
extension LeetCodeViewController:UITableViewDelegate,UITableViewDataSource{
    
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
