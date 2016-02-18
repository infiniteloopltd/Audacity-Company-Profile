//
//  ClientViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

class ClientViewController: BaseViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var selectedIndexPath : NSIndexPath?
    
    var clicked :Bool = false;
    
    var clientProjectName = [String]()
    var projectType = [[String]]()
    var projectUrl = [[String]]()
    var clientName = [String]()
    var countryName = [String]()
    var clientProjectImage = [String]()

    
    
    
    
    
    
    
    static var observerStatus:Bool = false;
    var appDelegate:AppDelegate!
    
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
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
       return clientProjectName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! ClientItemCell
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.clientName.text = clientName[indexPath.row]
        cell.clientProjectName.text = clientProjectName[indexPath.row]
        cell.clientImage.image = UIImage(named: clientProjectImage[indexPath.row])
        cell.clientCountry.text = countryName[indexPath.row].uppercaseString
        cell.projectTypeView.hidden = true
        
        cell.link = projectUrl[indexPath.row]
        cell.projectType = projectType[indexPath.row]
        cell.setButtonText()
        
        cell.clientImage.layer.cornerRadius = cell.clientImage.frame.size.width / 2
        cell.clientImage.clipsToBounds  = true
        cell.clientImage.layer.borderWidth = 3
        cell.clientImage.layer.borderColor = UIColor.whiteColor().CGColor// Make image borders rounded
        
        
        cell.selectionStyle = .None
        
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
        trackEvent(1, actionName: "ClientView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func imageResize (image image:UIImage, sizeChange:CGSize, origin:CGPoint)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        //image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        image.drawInRect(CGRect(origin: origin, size: sizeChange))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(!clicked) {
            return ClientItemCell.defaultHeight
        }
        if indexPath == selectedIndexPath {
            
            return ClientItemCell.expandedHeight
           
            
        } else {
            return ClientItemCell.defaultHeight
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        clicked = true;
        
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        
        var indexPaths : Array<NSIndexPath> = []
        
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
           
        }
        
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! ClientItemCell).watchFrameChanges()
        
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! ClientItemCell).ignoreFrameChanges()
        
    }
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("client", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    for(var i:Int = 0; i<jsonObj["clients"].count; i++) {
                        
                        clientProjectName.append(jsonObj["clients"][i]["client_name"].string!)
                        clientName.append(jsonObj["clients"][i]["delegate_name"].string!)
                        countryName.append(jsonObj["clients"][i]["country"].string!)
                        clientProjectImage.append(jsonObj["clients"][i]["image"].string!)
                        
                
                        var temp = [String]()
                        var tempUrl = [String]()
                        for( var j:Int = 0; j<jsonObj["clients"][i]["project_info"].count; j++) {
                            temp.append(jsonObj["clients"][i]["project_info"][j]["platform"].string!)
                            tempUrl.append(jsonObj["clients"][i]["project_info"][j]["url"].string!)
                        }
                        
                        projectType.append(temp)
                        projectUrl.append(tempUrl)
                        
                        
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
