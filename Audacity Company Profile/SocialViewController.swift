//
//  SocialViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class SocialViewController: BaseViewController {
    
    var appDelegate:AppDelegate!
    
    var socialLink = ["https://www.facebook.com/audacityit/?fref=ts",
        "https://www.linkedin.com/company/audacity-it-solution",
        "https://twitter.com/audacity_it_ltd",
        "https://www.youtube.com/channel/UC9-vBIn_JticiYOP70m-mdg"]
    
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    

    @IBAction func facebookBtn(sender: AnyObject) {
        
        let url = NSURL(string: socialLink[0])!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    @IBAction func linkedInBtn(sender: AnyObject) {
        
        let url = NSURL(string: socialLink[1])!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    @IBAction func twitterBtn(sender: AnyObject) {
        let url = NSURL(string: socialLink[2])!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    @IBAction func youtubeBtn(sender: AnyObject) {
        let url = NSURL(string: socialLink[3])!
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
        trackEvent(1, actionName: "SocialView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
}
