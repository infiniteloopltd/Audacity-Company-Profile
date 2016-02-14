//
//  BaseViewController.swift
//  Audacity Company Profile
//
//  Created by ZR.Faisal on 2/14/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import Foundation

class BaseViewController: UIViewController {
    
    func trackEvent(type : Int , actionName : String) {
        // type = 1 for screen
        // type = 2 for btn action event
        if(type == 1) {
            let tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value: actionName)
            
            let builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        } else {
            
            let tracker = GAI.sharedInstance().defaultTracker
            
            let event = GAIDictionaryBuilder.createEventWithCategory("Action", action: actionName, label: nil, value: nil)
            
            tracker.send(event.build() as [NSObject : AnyObject])
            
        }
    }

}
