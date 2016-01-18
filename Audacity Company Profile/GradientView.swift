//
//  GradientView.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 12/28/15.
//  Copyright (c) 2015 Audacity IT Solutions. All rights reserved.
//

import UIKit

class GradientView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        // 1
        let currentContext = UIGraphicsGetCurrentContext()
        
        // 2
        CGContextSaveGState(currentContext);
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
       // var startColor = UIColor.redColor();
        
        let startColor = uicolorFromHex1(0x000000) as UIColor
        let startColorComponents = CGColorGetComponents(startColor.CGColor)
        //var endColor = UIColor.blueColor();
         let endColor = uicolorFromHex2(0x000000) as UIColor
        let endColorComponents = CGColorGetComponents(endColor.CGColor)
        
        // 5
        var colorComponents
        = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        // 6
        var locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradientCreateWithColorComponents(colorSpace,&colorComponents,&locations,2)
        
        //var startPoint = CGPointMake(0, self.bounds.height)
        //var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
        
        let startPoint = CGPointMake(0, 0)
        let endPoint = CGPointMake(0, self.bounds.height)
        
        
        // 8
        CGContextDrawLinearGradient(currentContext,gradient,startPoint,endPoint, [])
        
        // 9
        CGContextRestoreGState(currentContext);
    }
    

    func uicolorFromHex1(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:0.0)
    }
    
    func uicolorFromHex2(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:0.5)
    }
    
    
    
}
