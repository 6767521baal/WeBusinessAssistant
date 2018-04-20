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
    
    @IBOutlet weak var labelSell: UILabel!
    
    @IBOutlet weak var labelCount: UILabel!
    
    @IBOutlet weak var labelPurchase: UILabel!
    
    @IBOutlet weak var labelProfit: UILabel!
    
    @IBOutlet weak var labelType: UILabel!
    
    @IBOutlet weak var labelProxy: UILabel!
    
    @IBOutlet weak var labelNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //设置cell是有圆角边框显示
        viewCell.layer.cornerRadius = 2
        viewCell.layer.borderWidth = 1
        viewCell.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        labelName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
