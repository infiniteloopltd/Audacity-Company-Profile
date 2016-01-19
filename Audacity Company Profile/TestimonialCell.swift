//
//  TestimonialCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 1/11/16.
//  Copyright (c) 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class TestimonialCell: UITableViewCell {

    @IBOutlet var clientName: UILabel!
    @IBOutlet var clientPosition: UILabel!
    @IBOutlet var clientImage: UIImageView!
    @IBOutlet var testimonialLabel: UILabel!
    
    var urls:String = ""
    
    @IBAction func clientWebsite(sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var urlAction: UIButton!
    
    @IBAction func urlActionBtn(sender: AnyObject) {
        let url = NSURL(string: urls)!
        UIApplication.sharedApplication().openURL(url)
    }

}
