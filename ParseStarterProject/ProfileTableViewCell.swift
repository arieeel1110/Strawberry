//
//  ProfileTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/20/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var avator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
