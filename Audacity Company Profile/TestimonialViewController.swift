//
//  TestimonialViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
class TestimonialViewController: UIViewController , UITableViewDelegate {
    
    
    
    @IBOutlet var tableView: UITableView!
    
    /*var cellContent = ["Audacity IT Solutions have a very “Can Do” attitude with a very professional and attention to detail quality in every bit of work they do. The quality of product they have provided for me is world class. Team was always available by phone call or skype to discuss anything I needed to and made every effort to attend to these issues as soon as they could.","Audacity IT Solutions Ltd, UNEXT offshore team is quickly adapting to Japanese work standards which is very hard to maintain even for experienced companies. They are now maintaining an app which has 400,000 paid users. I have very high hopes for the talented engineers in Audacity IT Solutions Ltd."]
    
    var clientImage = ["img_client_1.jpg", "img_client_2.jpg"]
    
    var clientPosition = ["CEO of Lock Deals","Manager at U-NEXT"]
    var clientName = ["Cody McDowell","Chinmoy Saha"]
    
    var clientUrl = ["http://www.lockdealsapp.com","http://animehodai.my.softbank.jp/"]
    */
    
    var cellContent = [String]()
    var clientImage = [String]()
    var clientPosition = [String]()
    var clientName = [String]()
    var clientUrl = [String]()
    
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
        self.tableView.backgroundColor = uicolorFromHex(0xDBE0E7)
        
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
        
        return cellContent.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! TestimonialCell
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        var attributedString = NSAttributedString(string: cellContent[indexPath.row],
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        
        
        // cell.label.text = cellContent[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsZero;
        //cell.preservesSuperviewLayoutMargins = false
        // cell.testimonialLabel.attributedText = attributedString
        cell.clientName.text = clientName[indexPath.row]
        cell.clientImage.image = UIImage(named: clientImage[indexPath.row])
        cell.clientPosition.text = clientPosition[indexPath.row]
        
        cell.urls = clientUrl[indexPath.row]
        //cell.clientName.attributedText = attributedString
        // cell.clientName.text = cellContent[indexPath.row]
        //cell.label.hidden = true
        
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "ic_testimonial_quote_start.png")
        let startQuote:CGPoint = CGPoint(x:0, y:-5)
        let size = CGSizeMake(20, 20)
        attachment.image! = imageResize(image: attachment.image!, sizeChange: size, origin:startQuote)
        
        
        
        let attachmentString = NSAttributedString(attachment: attachment)
        
        let myString = NSMutableAttributedString(string: " ")
        
        
        myString.appendAttributedString(attachmentString)
        
        
        //---------Attributed String 2
        
        
        
        let attachment2 = NSTextAttachment()
        attachment2.image = UIImage(named: "ic_testimonial_quote_end.png")
        
        
        
        let endQuote:CGPoint = CGPoint(x:0, y:5)
        
        attachment2.image! = imageResize(image: attachment2.image!, sizeChange: size, origin:endQuote)
        
        //  attachment2.image. = CGRectMake(0, 0, 10, 10)
        // attachment2.image?.size.width = 20 as CGSize
        
        //attachment2.image?.size.height = 10 as CGSize
        
        
        
        
        
        let attachmentString2 = NSAttributedString(attachment: attachment2)
        
        let myString2 = NSMutableAttributedString(string: cellContent[indexPath.row])
        myString2.appendAttributedString(attachmentString2)
        //------------------------------------
        
        
        
        
        
        myString.appendAttributedString(myString2)
        cell.testimonialLabel.attributedText = myString
        
        
        
        
        
        
        cell.clientImage.layer.cornerRadius = cell.clientImage.frame.size.width / 2
        cell.clientImage.clipsToBounds  = true
        cell.clientImage.layer.borderWidth = 3
        cell.clientImage.layer.borderColor = UIColor.whiteColor().CGColor// Make image borders rounded
        //cell.clientImage.layer.cornerRadius = 10
        //cell.clientImage.clipsToBounds = true
        //cell.clientImage.layer.borderWidth = 3
        //cell.clientImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        
        
        return cell
    }
    
    /*override func viewDidAppear(animated: Bool) {
    self.tableView.reloadData()
    }
    
    func onContentSizeChange(notification: NSNotification) {
    self.tableView.reloadData()
    }
    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        //  let height:CGFloat = self.calculateHeightForString(cellContent[indexPath.row])
        //  showLine(height)
        
        /* var selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomCellTableViewCell
        //selectedCell.cont
        
        currentSelection = indexPath.row
        if( selectedCell.container.hidden) {
        selectedCell.container.hidden = false
        } else {
        selectedCell.container.hidden = true
        }
        tableView.beginUpdates()
        
        
        tableView.endUpdates()*/
        
    }
    
    
    
    /*    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    var height:CGFloat = self.calculateHeightForString(cellContent[indexPath.row])
    
    return ( height * 2) + 50
    
    }
    */
    
    
    
    /*func calculateHeightForString(inString:String) -> CGFloat
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
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("testimonial", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    
                    
                    for(var i:Int = 0; i<jsonObj["testimonials"].count; i++) {
                        
                        
                        clientName.append(jsonObj["testimonials"][i]["delegate_name"].string!)
                        clientImage.append(jsonObj["testimonials"][i]["delegate_image"].string!)
                        clientPosition.append(jsonObj["testimonials"][i]["delegate_designation"].string!)
                        clientUrl.append(jsonObj["testimonials"][i]["ref_url"].string!)
                        cellContent.append(jsonObj["testimonials"][i]["comment"].string!)
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
