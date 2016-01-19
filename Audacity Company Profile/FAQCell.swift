//
//  FAQItemCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 1/15/16.
//  Copyright (c) 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class FAQItemCell: UITableViewCell {

    @IBOutlet var arrowBtn: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var ansLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
