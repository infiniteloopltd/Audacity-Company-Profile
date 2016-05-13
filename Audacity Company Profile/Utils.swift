//
//  Utils.swift
//  Audacity - Marketing App
//
//  Created by Sourav AITS on 5/13/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//



class Utils {

    class func uicolorFromHex(rgbValue:UInt32, alpha:CGFloat)->UIColor{
            let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
            let blue = CGFloat(rgbValue & 0xFF)/256.0
            return UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }
}
