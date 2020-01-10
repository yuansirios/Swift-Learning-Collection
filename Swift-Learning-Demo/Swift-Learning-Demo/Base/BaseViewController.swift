//
//  BaseViewController.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2020/1/10.
//  Copyright © 2020 yuan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //导航栏问题
        edgesForExtendedLayout = UIRectEdge.init();
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = UIColor.white
        
        print("<<<<<<<<< \(type(of: self)) -> 加载了 >>>>>>>>>")
    }
    
    deinit {
        print("<<<<<<<<< \(type(of: self)) -> 释放了 >>>>>>>>>")
    }

}
