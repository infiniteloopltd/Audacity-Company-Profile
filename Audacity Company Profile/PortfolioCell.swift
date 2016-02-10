//
//  PortfolioItemCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 1/12/16.
//  Copyright (c) 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class PortfolioItemCell: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemType: UILabel!
    @IBOutlet var itemLike: UIButton!
    
   
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
