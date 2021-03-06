//
//  TagButton.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 12/24/15.
//  Copyright (c) 2015 Audacity IT Solutions. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class MyCustomButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 15.0;
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.5
        self.tintColor = UIColor.white
        
    }
}

class MyCustomButton2: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 15.0;
        self.layer.borderColor = UIColor.gray as! CGColor
        self.layer.borderWidth = 1.5
        self.tintColor = UIColor.gray
         
    }
}
