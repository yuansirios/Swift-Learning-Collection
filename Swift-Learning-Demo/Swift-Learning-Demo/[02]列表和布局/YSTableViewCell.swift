//
//  YSTableViewCell.swift
//  Swift-Learning-Demo
//
//  Created by yuan on 2019/5/9.
//  Copyright © 2019 yuan. All rights reserved.
//

import UIKit

class YSTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    var model:YSListModel!{
        didSet{
//            print("title:\(model.title!)")
//            print("subTitle:\(model.subTitle!)")
//            print("event:\(model.event!)")
        }
    }

}
