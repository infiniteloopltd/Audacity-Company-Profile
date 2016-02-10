//
//  DrawerItemCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 12/23/15.
//  Copyright (c) 2015 Audacity IT Solutions. All rights reserved.
//

import UIKit

class DrawerCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
