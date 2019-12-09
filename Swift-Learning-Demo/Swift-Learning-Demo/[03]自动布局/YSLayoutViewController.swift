//
//  YSLayoutView.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/13.
//  Copyright © 2019 yuan. All rights reserved.
//

import UIKit
import SnapKit

class YSLayoutViewController: UIViewController {
    
    var didSetupConstraints = false
    
    // 保存约束（引用约束）
    var updateConstraint: Constraint?
    var blackW = 100
    
    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    let blackView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let whiteView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let redView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    let yellowView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    let blueView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    let greenView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder))释放了。。。")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        scrollView.addSubview(blackView)
        blackView.addSubview(whiteView)
        
        scrollView.addSubview(redView)
        scrollView.addSubview(yellowView)
        scrollView.addSubview(blueView)
        scrollView.addSubview(greenView)
        view.addSubview(scrollView)
        
        view.setNeedsUpdateConstraints()
        
        let updateButton = UIButton(type: .custom)
        updateButton.backgroundColor = UIColor.brown
        updateButton.frame = CGRect(x: 100, y: 80, width: 50, height: 30)
        updateButton.setTitle("更新", for: .normal)
        updateButton.addTarget(self, action: #selector(updateConstraintMethod), for: .touchUpInside)
        view.addSubview(updateButton)
        
        /*
        redView = UIView()
        self.view.addSubview(redView)
        redView.backgroundColor = UIColor.red
        
        //TODO: 1、label宽度自适应(不设置宽度)
        let label = UILabel()
        redView.addSubview(label)
        label.text = "这是一个绿色label"
        label.backgroundColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 15)
        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(20)
        }
        
        //TODO: 2、并排的两个label，优先让右边的label宽度自适应
        
        // 左边的label
        let leftLabel = UILabel()
        redView.addSubview(leftLabel)
        leftLabel.backgroundColor = UIColor.lightGray
        leftLabel.text = "这是左边的label"
        leftLabel.font = UIFont.systemFont(ofSize: 12)
        
        // 右边的label
        let rightLabel = UILabel()
        redView.addSubview(rightLabel)
        rightLabel.backgroundColor = UIColor.orange
        rightLabel.text = "这是右边的label，优先宽度自适应内容"
        rightLabel.font = UIFont.systemFont(ofSize: 12)
        // 别扯我，谢谢(这就是右边label优先宽度自适应的关键代码)
        rightLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal);
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(label.snp_bottom)
            make.height.equalTo(20)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right)
            make.top.height.equalTo(leftLabel)
            make.right.equalTo(redView.snp_right)
        }
        
        //TODO: 3、动态行高的label
        let lineLabel = UILabel()
        redView.addSubview(lineLabel)
        lineLabel.backgroundColor = UIColor.purple
        lineLabel.text = "123123123131231231231231231231312312312312312312313123123123"
        lineLabel.numberOfLines = 0
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel)
            make.top.equalTo(leftLabel.snp_bottom)
            make.width.equalTo(50)
        }
        
        // 创建约束
        redView.snp.makeConstraints { (make) in
            // 距离上左下右各20
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(lineLabel.snp_bottom)
        }*/
    }
    
    //MAKR:
    // 更新约束
    @objc func updateConstraintMethod() {
        blackW += 10
        if blackW > 200 {
            blackW = 100
        }
        self.updateConstraint?.update(offset: blackW)   // 更新距离父视图上、左为50
    }
    
    //MARK: ********** 布局 ***********
    override func updateViewConstraints() {
           if !didSetupConstraints {
               constraints()
               didSetupConstraints = true
           }
           super.updateViewConstraints()
       }
       
       func constraints() {
           scrollView.snp_makeConstraints { (maker) in
               maker.edges.equalToSuperview()
           }
           
           blackView.snp_makeConstraints { (maker) in
               maker.centerX.equalTo(view.snp_centerX)
               maker.centerY.equalTo(view.snp_centerY).offset(-50)
               self.updateConstraint = maker.width.height.equalTo(blackW).constraint
           }
            
            whiteView.snp_makeConstraints { (maker) in
                maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            }
           
           redView.snp_makeConstraints { (maker) in
               maker.left.greaterThanOrEqualTo(view)
               maker.top.equalTo(blackView.snp_bottom).offset(20)
               maker.size.equalTo(CGSize.init(width: 100, height: 100))
           }
           
           yellowView.snp_makeConstraints { (maker) in
               maker.right.greaterThanOrEqualTo(view)
               maker.top.equalTo(blackView.snp_bottom).offset(20)
               maker.size.equalTo(CGSize.init(width: 100, height: 100))
           }
           
           blueView.snp_makeConstraints { (maker) in
               maker.right.greaterThanOrEqualTo(view)
               maker.bottom.equalTo(blackView.snp_top).offset(-20)
               maker.size.equalTo(CGSize.init(width: 100, height: 100))
           }
           
           greenView.snp_makeConstraints { (maker) in
               maker.left.greaterThanOrEqualTo(view)
               maker.bottom.equalTo(blackView.snp_top).offset(-20)
               maker.size.equalTo(CGSize.init(width: 100, height: 100))
           }
       }
}
