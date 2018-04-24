//
//  MethodologyCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 1/1/16.
//  Copyright (c) 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class MethodologyCell: UITableViewCell {

    
    @IBOutlet var itemIcon: UIImageView!
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemDetail: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
