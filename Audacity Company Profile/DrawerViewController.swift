//
//  DrawerViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import MessageUI

class DrawerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    
    @IBOutlet var tableView: UITableView!
    var drawerItem:[String] = ["Home","Overview","Portfolio","Team","Clients","Testimonial","Methodology","Social","FAQ","Rate this App"];
    var drawerItemImage:[String] = ["ic_nav_home.png","ic_nav_overview.png","ic_nav_portfolio.png","ic_nav_team.png","ic_nav_client.png","ic_nav_testimonial.png","ic_nav_methodology.png","ic_nav_social.png","ic_nav_faq.png","ic_nav_overview.png"];
    var totalCount: Int = 0
    var selectedItem:Int = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.backgroundColor = uicolorFromHex(0x21252A)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        
        //let rowToSelect:NSIndexPath = NSIndexPath(forRow: 1, inSection: 0);  //slecting 0th row with 0th section
        //self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None);
        //self.tableView(self.tableView, didSelectRowAtIndexPath: rowToSelect); //Manually trigger the
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return drawerItem.count + 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.row == 0) {
            let itemCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath)  as! DrawerHeaderCell
            itemCell.backgroundColor = uicolorFromHex(0x21252A)
            itemCell.selectionStyle = UITableViewCellSelectionStyle.None
            return itemCell
            
        } else if(indexPath.row == drawerItem.count + 1 ) {
            let  itemCell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath)  as! DrawerFooterCell
            itemCell.backgroundColor = uicolorFromHex(0x21252A)
            itemCell.selectionStyle = UITableViewCellSelectionStyle.None
            return itemCell
            
        } else {
            
            let  itemCell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath)  as! DrawerCell
            itemCell.backgroundColor = uicolorFromHex(0x21252A)
            
            itemCell.itemLabel.text = drawerItem[indexPath.row - 1]
            itemCell.itemImageView.image =  UIImage(named: drawerItemImage[indexPath.row - 1])
            itemCell.itemImageView.image = itemCell.itemImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            itemCell.itemImageView.tintColor = uicolorFromHex(0x99A4B9)
            
            
            return itemCell
        }
        
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(selectedItem != 0 ) {
            let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            cellToDeSelect.contentView.backgroundColor = uicolorFromHex(0x21252A)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.row == 0) {
            return 200.0
        } else if(indexPath.row == (drawerItem.count + 1  )) {
            return 180.0
        } else {
            
            return 50.0
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func callBtnAction(sender: AnyObject) {
        // println("CallBtnPressed")
        
        callNumber("+8801670923581")
        // var url:NSURL? = NSURL(string: "tel://9809088798")
        // UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func mailBtnAction(sender: AnyObject) {
        
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        //picker.setSubject(subjectField.text)
        //picker.setMessageBody(emailBodyField.text, isHTML: true)
        picker.setToRecipients(["founders@audacityit.com"])
        
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func getStartedAction(sender: AnyObject) {
        
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        //picker.setSubject(subjectField.text)
        //picker.setMessageBody(emailBodyField.text, isHTML: true)
        picker.setToRecipients(["founders@audacityit.com"])
        
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func webBtnAction(sender: AnyObject) {
        let url = NSURL(string: "http://www.audacityit.com")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedItem = indexPath.row
        
        if(indexPath.row != 0) {
            let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            //selectedCell.contentView.backgroundColor = UIColor.blackColor()
            //selectedCell.backgroundColor = UIColor.blackColor()
            selectedCell.contentView.backgroundColor = UIColor.blackColor()
            selectedCell.backgroundColor = UIColor.blackColor()
        }
        
        
        
        
        switch(indexPath.row)
        {
            
            /* case 0:
            
            var centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            var centerNavController = UINavigationController(rootViewController: centerViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            //   appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break;
            */
            
        case 1:  // Home
            
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            
            let navController = UINavigationController(rootViewController: viewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = navController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break;
            
        case 2:  // OverView
            
            let overviewController = self.storyboard?.instantiateViewControllerWithIdentifier("OverViewController") as! OverViewController
            
            let overNavController = UINavigationController(rootViewController: overviewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = overNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break;
            
            
        case 3:   // Portfolio
            let portfolioViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PortfolioViewController") as! PortfolioViewController
            
            let portfolioNavController = UINavigationController(rootViewController: portfolioViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = portfolioNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            
            break;
            
        case 4:  // Team
            
            
            let teamViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TeamViewController") as! TeamViewController
            
            let teamNavController = UINavigationController(rootViewController: teamViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = teamNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break;
            
            
        case 5:  // Clients
            
            let clientViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ClientViewController") as! ClientViewController
            
            let clientNavController = UINavigationController(rootViewController: clientViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = clientNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break;
            
        case 6:  // Testimonial
            
            let testimonialViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TestimonialViewController") as! TestimonialViewController
            
            let testimonialNavController = UINavigationController(rootViewController: testimonialViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = testimonialNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            
            
            break;
            
        case 7:  // Methodology
            let methodologyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MethodologyViewController") as! MethodologyViewController
            
            let methodologyNavController = UINavigationController(rootViewController: methodologyViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = methodologyNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break
            
        case 8:  // Social
            let socialViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SocialViewController") as! SocialViewController
            
            let socialNavController = UINavigationController(rootViewController: socialViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = socialNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break
            
        case 9:  // FAQ
            
            let faqViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FAQViewController") as! FAQViewController
            
            let faqlNavController = UINavigationController(rootViewController: faqViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = faqlNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
            
            break
            
        case 10: // Rate This app
            let url = NSURL(string: "http://www.audacityit.com")!
            UIApplication.sharedApplication().openURL(url)
            
            break
        default:
            
            print("");
            
        }
        
        
        
    }
    
    
  
        

}