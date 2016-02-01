//
//  SocialViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController {
    
    var appDelegate:AppDelegate!
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    

    @IBAction func facebookBtn(sender: AnyObject) {
        
        let url = NSURL(string: "https://www.facebook.com")!
        UIApplication.sharedApplication().openURL(url)
        
    }
    
    
    @IBAction func linkedInBtn(sender: AnyObject) {
        
        let url = NSURL(string: "https://www.linkedin.com")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    @IBAction func twitterBtn(sender: AnyObject) {
        let url = NSURL(string: "https://www.twitter.com")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    @IBAction func youtubeBtn(sender: AnyObject) {
        let url = NSURL(string: "https://www.youtube.com")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
}
