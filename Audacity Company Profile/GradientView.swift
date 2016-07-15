//
//  GradientView.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 12/28/15.
//  Copyright (c) 2015 Audacity IT Solutions. All rights reserved.
//

import UIKit

class GradientView: UIView {

    
    override func drawRect(rect: CGRect) {
       
        let currentContext = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(currentContext);
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
       
        let startColor = Utils.uicolorFromHex(0x000000, alpha: 0) as UIColor
        let startColorComponents = CGColorGetComponents(startColor.CGColor)
        let endColor = Utils.uicolorFromHex(0x000000, alpha: 0.5) as UIColor
        let endColorComponents = CGColorGetComponents(endColor.CGColor)
        
        var colorComponents
        = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        var locations:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradientCreateWithColorComponents(colorSpace,&colorComponents,&locations,2)
        
        let startPoint = CGPointMake(0, 0)
        let endPoint = CGPointMake(0, self.bounds.height)
        
        CGContextDrawLinearGradient(currentContext,gradient,startPoint,endPoint, [])
        
        CGContextRestoreGState(currentContext);
    }
    
}
