//
//  ViewController.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/7.
//  Copyright © 2019 yuan. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController,YSListViewDelegate {

    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift"
        
        //导航栏问题
        self.edgesForExtendedLayout = UIRectEdge.init();
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(self.listView)
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            listView.snp_makeConstraints { (maker) in
                maker.edges.equalToSuperview()
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    // MARK: - 懒加载
    lazy var listView : YSListView = {
        let view = YSListView()
        view.backgroundColor = UIColor.green;
//        view.delegate = self
        view.layoutBlock = {
            self.turnToLayoutView()
        }
        return view
    }()
    
    // MARK: - YSListViewDelegate
    func turnToLayoutView() {
        print("跳转自动布局")
        self.navigationController?.pushViewController(YSLayoutViewController(), animated: true)
    }
}

