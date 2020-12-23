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
        
        var sectionArr = [YSListSectionModel]()
        for var dic:[String:Any] in dicArr as! Array {
            let section =  Mapper<YSListSectionModel>().map(JSON: dic)
            sectionArr.append(section!)
        }
        
        return sectionArr as NSArray
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView.init()
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = UIView()
        return table
    }()
    
    // MARK: - *********** 数组相关 ***********
    @objc func twoSum(){
        let nums = [2, 7, 11, 15]
        let taget = 9
        let arr = ArraySolution().twoSum(nums, taget)
        print("【1】两数之和：\(arr)");
    }
    
    @objc func removeDuplicates(){
        var nums = [0,0,1,1,1,2,2,3,3,4]
        let value = ArraySolution().removeDuplicates(&nums)
        print("【26】删除排序数组中的重复项：\(value)");
    }
    
    @objc func removeElement(){
        var nums = [0,0,1,1,1,2,2,3,3,4]
        let val = 1
        let result = ArraySolution().removeElement(&nums, val)
        print("【27】移除元素：\(result)");
    }
    
    @objc func addTwoNumbers(){
        let a = ListNode(4,ListNode(3))
        let oneList = ListNode(2,a)
        
        let b = ListNode(6,ListNode(4))
        let twoList = ListNode(5,b)
        
        let threeList = Solution().addTwoNumbers(oneList,twoList)
        
        print("【2】两数相加的结果：");
        printListNode(threeList)
    }
    
    func printListNode(_ head: ListNode?) {
        if head?.next != nil {
            printListNode(head?.next)
        }
        print(head!.val)
    }
    
    @objc func maxArea(){
        let arr = [1,8,6,2,5,4,8,3,7]
        let area = Solution().maxArea(arr);
        print("【11】盛最多水的容器：\(area)");
    }
    
}

// MARK: - *********** UITableViewDelegate ***********
extension LeetCodeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = self.dataArr[section] as? YSListSectionModel
        return model?.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataArr[section] as? YSListSectionModel
        return model!.list.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: YSTableViewCell? = nil
    
        if cell != nil {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? YSTableViewCell
        }else{
            cell = YSTableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let section = self.dataArr[indexPath.section] as? YSListSectionModel
        let model = section?.list[indexPath.row]
        cell?.model = model
        cell?.textLabel?.text = model?.title
        cell?.detailTextLabel?.text = model?.subTitle
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = self.dataArr[indexPath.section] as? YSListSectionModel
        let model = section?.list[indexPath.row]
        let selector = Selector(model!.event)
        
        if self.responds(to:selector) {
            self.perform(selector)
        }else{
            print("\(selector.description)方法不存在！！！")
        }
    }
}
