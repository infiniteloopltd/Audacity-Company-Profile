//
//  ClientViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController , UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var selectedIndexPath : NSIndexPath?
    
    var clicked :Bool = false;
    
    var clientProjectName = ["Monasa Learning Centre", "Amar Phonebook", "Colours FM", "U-NEXT", "Lock Deals"]
    
    var projectType = [["Website"],["Android","iOS"], ["Android"], ["Android", "iOS"], ["Website", "Android"]]
    
    var projectUrl = [["http://www.monasalearning.com"],
        ["play.google.com/store/apps/details?id=com.audacityit.amarphonebook", "https://itunes.apple.com/us/app/amar-phonebook-bangladeshs/id1044979290?mt=8"],
        ["https://play.google.com/store/apps/details?id=com.audacityit.coloursfm"],
        ["https://play.google.com/store/apps/details?id=jp.softbank.mb.animehodai", "https://itunes.apple.com/jp/app/anime-fang-ti/id959884819?mt=8"],
        ["http://www.lockdealsapp.com", "https://play.google.com/store/apps/details?id=com.audacityit.lockdeals"]]
    
    var clientName = ["Samad Miraly", "Empire Group", "ADCOMM LTD.", "U-NEXT", "Cody McDowell"]
    
    var countryName = ["BANGLADESH", "BANGLADESH", "BANGLADESH", "JAPAN", "AUSTRALIA"]
    
    
    
    var clientProjectImage = ["img_client_3.jpg", "img_client_4.jpg", "img_client_5.jpg", "img_client_6.jpg", "img_client_7.png"]
    
    //var clientPosition = ["CEO of Lock Deals","Manager at U-NEXT"]
    
    
    //var clientUrl = ["http://www.lockdealsapp.com","http://animehodai.my.softbank.jp/"]
    
    
    // class var observerStatus: Bool = false
    
    static var observerStatus:Bool = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        //self.tableView.backgroundColor = uicolorFromHex(0xDBE0E7)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // ClientViewController.observerStatus = true;
        
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
        
        /*var attributedString = NSAttributedString(string: cellContent[indexPath.row],
        attributes: [
        NSParagraphStyleAttributeName: paragraphStyle,
        NSBaselineOffsetAttributeName: NSNumber(float: 0)
        ])
        */
        
        // cell.label.text = cellContent[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsZero;
        //cell.preservesSuperviewLayoutMargins = false
        // cell.testimonialLabel.attributedText = attributedString
        cell.clientName.text = clientName[indexPath.row]
        cell.clientProjectName.text = clientProjectName[indexPath.row]
        cell.clientImage.image = UIImage(named: clientProjectImage[indexPath.row])
        cell.clientCountry.text = countryName[indexPath.row]
        
        cell.projectTypeView.hidden = true
        
        cell.link = projectUrl[indexPath.row]
        cell.projectType = projectType[indexPath.row]
        cell.setButtonText()
        
        
        //cell.clientName.attributedText = attributedString
        // cell.clientName.text = cellContent[indexPath.row]
        //cell.label.hidden = true
        
        
        
        
        
        
        cell.clientImage.layer.cornerRadius = cell.clientImage.frame.size.width / 2
        cell.clientImage.clipsToBounds  = true
        cell.clientImage.layer.borderWidth = 3
        cell.clientImage.layer.borderColor = UIColor.whiteColor().CGColor// Make image borders rounded
        //cell.clientImage.layer.cornerRadius = 10
        //cell.clientImage.clipsToBounds = true
        //cell.clientImage.layer.borderWidth = 3
        //cell.clientImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    
    
    /* func calculateHeightForString(inString:String) -> CGFloat
    {
    let messageString = inString
    let attributes = [UIFont(): UIFont.systemFontOfSize(17.0)]
    let attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: attributes)
    let rect:CGRect = attrString!.boundingRectWithSize(CGSizeMake(300.0,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context:nil )//hear u will get nearer height not the exact value
    let requredSize:CGRect = rect
    return requredSize.height  //to include button's in your tableview
    
    }
    */
    
    func showLine(height:CGFloat) {
        let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "\(height)  ", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
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
        //     if(clicked) {
        //    println("willDisplayCell")
        
        //ClientViewController.observerStatus = true
        (cell as! ClientItemCell).watchFrameChanges()
        
        // }
        
        
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // if(clicked) {
        //   println("didEndDisplayingCell")
        (cell as! ClientItemCell).ignoreFrameChanges()
        // ClientViewController.observerStatus = false
        //  }
    }
    
    
    
}
