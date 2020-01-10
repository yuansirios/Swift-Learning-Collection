//
//  UIColor+Extension.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2020/1/10.
//  Copyright © 2020 yuan. All rights reserved.
//

import UIKit

extension UIColor {
    //随机颜色
    class var randomColor : UIColor {
        return UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
    }
}
