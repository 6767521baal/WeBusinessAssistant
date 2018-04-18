//
//  DetailTableViewCell.swift
//  WeBusinessAssistant
//
//  Created by 刘启 on 2018/4/18.
//  Copyright © 2018年 刘启. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelType: UILabel!
    
    @IBOutlet weak var labelPurchase: UILabel!
    
    @IBOutlet weak var labelPurchase_other: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //设置cell是有圆角边框显示
        viewCell.layer.cornerRadius = 5
        viewCell.backgroundColor = UIColor.cyan
        labelName.textColor = UIColor.darkGray
        labelType.textColor = UIColor.darkText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
