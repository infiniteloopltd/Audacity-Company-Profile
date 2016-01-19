//
//  OverviewCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 12/31/15.
//  Copyright (c) 2015 Audacity IT Solutions. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {

    
    @IBOutlet var itemIcon: UIImageView!
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
