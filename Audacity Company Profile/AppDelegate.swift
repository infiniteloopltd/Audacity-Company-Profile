//
//  AppDelegate.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIGestureRecognizerDelegate {

    var window: UIWindow?
    var centerContainer: MMDrawerController?
    var drawerStateDelegate : DrawerStateDelegate!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        _ = self.window!.rootViewController
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        
        let drawerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("DrawerViewController") as! DrawerViewController
        
        
        
        
        let leftSideNav = UINavigationController(rootViewController: drawerViewController)
        let centerNav = UINavigationController(rootViewController: centerViewController)
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        
        
        centerContainer = MMDrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav)
        
        /*centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningDrawerView
        
        centerContainer!.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionMode.Full*/
        
        centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        centerContainer!.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionMode.Full
        
        centerContainer?.setGestureCompletionBlock({ (centerContainer, tap) -> Void in
            if (centerContainer.visibleLeftDrawerWidth == 280) {
               
                if(self.drawerStateDelegate != nil) {
                    self.drawerStateDelegate.drawerOpened()
                }
                
            } else {
                
                if(self.drawerStateDelegate != nil) {
                    self.drawerStateDelegate.drawerClosed()
                }
                
            }
        })
        
        
        window!.rootViewController = centerContainer
        window!.makeKeyAndVisible()
        
        
        NSThread.sleepForTimeInterval(3.0)
        
        //----------- Google Analytics integration ---------------------
        // Configure tracker from GoogleService-Info.plist.
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // Optional: configure GAI options.
        let gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
        //----------- End of Google Analytics integration --------------
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
       
    }

}


protocol DrawerStateDelegate {
    
    func drawerOpened()
    func drawerClosed()
}

