//
//  ViewController.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/7.
//  Copyright © 2019 yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,YSListViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift"
        
        //导航栏问题
        self.edgesForExtendedLayout = UIRectEdge.init();
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(self.listView)
    }
    
    // MARK: - 懒加载
    lazy var listView : YSListView = {
        let view = YSListView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
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

