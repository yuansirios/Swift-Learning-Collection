//
//  ViewController.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/7.
//  Copyright © 2019 yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift"
        self.view.addSubview(self.listView)
    }
    
    // TODO:懒加载
    lazy var listView : YSListView = {
        let view = YSListView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.backgroundColor = UIColor.green;
        return view
    }()
}

