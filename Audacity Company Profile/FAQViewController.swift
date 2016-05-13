//
//  FAQViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
class FAQViewController: BaseViewController, UITableViewDelegate {
    
    
    
    @IBOutlet var tableView: UITableView!
    
    var question = [String]()
    var ans = [String]()
    
    
    var appDelegate:AppDelegate!
    
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
        
        self.tableView.estimatedRowHeight = 10
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.reloadData()
        self.tableView.backgroundColor = Utils.uicolorFromHex(0xDBE0E7, alpha: 1)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        UITableViewCell.appearance().backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return question.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! FAQItemCell
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.questionLabel.text = question[indexPath.row]
        cell.ansLabel.text = ans[indexPath.row]
        
        
        
        
        
        return cell
    }
    

    func showLine(height:CGFloat) {
        let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "\(height)  ", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        trackEvent(1, actionName: "FAQView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func imageResize (image image:UIImage, sizeChange:CGSize, origin:CGPoint)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: origin, size: sizeChange))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("faq", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    
                    for(var i:Int = 0; i<jsonObj["faq"].count; i++) {
                        
                        question.append(jsonObj["faq"][i]["q"].string!)
                        ans.append(jsonObj["faq"][i]["a"].string!)
                        
                    }
                    
                    
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }

    
    
}
