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
    
    var redView : UIView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
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
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        redView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}
