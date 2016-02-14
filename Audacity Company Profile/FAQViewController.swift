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
    
   /* var cellContent = ["Audacity IT Solutions have a very “Can Do” attitude with a very professional and attention to detail quality in every bit of work they do. The quality of product they have provided for me is world class. Team was always available by phone call or skype to discuss anything I needed to and made every effort to attend to these issues as soon as they could.","Audacity IT Solutions Ltd, UNEXT offshore team is quickly adapting to Japanese work standards which is very hard to maintain even for experienced companies. They are now maintaining an app which has 400,000 paid users. I have very high hopes for the talented engineers in Audacity IT Solutions Ltd."]
    
    //var clientImage = ["img_client_1.jpg", "img_client_2.jpg"]
    
    // var clientPosition = ["CEO of Lock Deals","Manager at U-NEXT"]
    
    
    //var clientUrl = ["http://www.lockdealsapp.com","http://animehodai.my.softbank.jp/"]
    
    
    var question = ["What's Audacity IT Solutions Ltd?", "Why I will work with Audacity IT Solutions Ltd?", "What I will save working with Audacity IT Solutions Ltd?",
        "How can I be confident of the quality and reliability?", "How do you deal with urgent bug fixing?","Do we completely own the source code of project?",
        "How often does company communicate with clients?", "Do you do software testing, verifications and QA services?", "What time zone is \"Audacity IT Solutions Limited\" in?",
        "How many days in a week do you work?", "What are your payment models?","What are your payment terms?", "How do you assure confidentiality?","What if my question is not answered on this FAQ?"]
    
    var ans = ["\"Audacity IT Solutions Limited\" is a 12 people software development company in Bangladesh, providing enterprise & customized web applications and mobile software development services to both local and international clients.\nWe got experience and interest of working for local public and private firms along with small and medium sized clients located in US, Japan, Canada, UK and other European countries.\nWe are focused on creating long-term strategic partnership with Global IT firms whether it’s a large corporation like British Telecom or startups with a tight budget, and help them build and maintain a highly qualitative, timely delivered, and cost-effective offshore software development team.",
        "Corporate IT firm professional but expensive: You can get a great quality project from a corporate IT firm, but you'll have to sell an arm and a leg to afford it!Freelancer cheaper but buggy saddssdsdexpensivebutexpensive: You can get an affordable solution from a freelancer, but it probably won't be as well-made, bug-free and professional.Audacity IT Solutions affordable & professional: You can have it all with “Audacity IT Solutions Limited” affordable, great quality web, mobile & wearable solutions!",
        "Money, Time & Energy.", "At \"Audacity IT Solutions Limited\" quality is a main priority. We do everything to ensure our customers'satisfaction. We \"get into your head\" and develop a deep understanding of your needs, wants and expectations. The result is an exceptional product.",
        "We do our best to avoid programming errors in products delivered to our customers. However, everybody familiar with software development practice knows that from time to time bugs appear even in the highest quality products. We try to fix bugs as soon as possible.",
        "You completely own source code after we receive 100% payment & open-source code used will remain with the respective owners.",
        "After signing an agreement, we will provide you one project manager who will be available 24 hours a day, 7 days a week.",
        "Yes, we do a huge amount of software testing: QA, system testing, functionality & feature testing, integration testing,regression testing, web software testing, compatibility testing on various platforms, load and performance testing,test case preparations, execution of test cases, reporting, etc.",
        "We are located in +6 GMT time zone. The exact time of contact is certainly whatever suits you best, but it is best to make a time at which you can meet daily. A planned daily meeting makes the development process go much more smoothly.",
        "We work 5 days a week. For urgent or emergency situations, a client associate is available to communicate 7 days a week.",
        "We have two payment models i.e Fixed Cost and Hourly Cost.\nFor Fixed Cost, your estimate will be a fixed price that varies with the client requirements.\nFor Hourly Cost, a dedicated developer will work on your project, which may cut down the cost of development.",
        "For Fixed Rate Projects:\nOn Project Approval: 50%\nAfter 50% project completion: 25%\nAfter 100% work delivered: 25%\n\nFor Hourly Rate Project:\nWe charge up front for weekly hours depending on how many hours the dedicated developer would work with your project.",
        "To keep your data and information highly confidential, we sign Non-Disclosure Agreements between the two parties i.e Company & Client, before you disclose any information to us. Data & information will be shared with our employees & contractors only, who are in-line with our legal framework and company policy.",
        "Mail us at founders@audacityit.com"
        
    ]*/
    
    //var cellContent = [String]()
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
        
        return question.count
        // return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! FAQItemCell
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        
        
        // cell.label.text = cellContent[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsZero;
        //cell.preservesSuperviewLayoutMargins = false
        // cell.testimonialLabel.attributedText = attributedString
        cell.questionLabel.text = question[indexPath.row]
        cell.ansLabel.text = ans[indexPath.row]
        
        
        
        
        
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
        
        //  var height:CGFloat = self.calculateHeightForString(cellContent[indexPath.row])
        //   showLine(height)
        
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
    
    
    
    /* func calculateHeightForString(inString:String) -> CGFloat
    {
    let messageString = inString
    let attributes = [UIFont(): UIFont.systemFontOfSize(17.0)]
    let attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: attributes)
    let rect:CGRect = attrString!.boundingRectWithSize(CGSizeMake(300.0,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context:nil )//hear u will get nearer height not the exact value
    let requredSize:CGRect = rect
    return requredSize.height  //to include button's in your tableview
    
    }*/
    
    
    func showLine(height:CGFloat) {
        let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "\(height)  ", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
        trackEvent(1, actionName: "FAQView Controller")
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
        
        
        if let path = NSBundle.mainBundle().pathForResource("faq", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    
                    
                    for(var i:Int = 0; i<jsonObj["faq"].count; i++) {
                        
                        //clientProjectImage.append(jsonObj["clients"][i]["client_name"].string!)
                        //clientName.append(jsonObj["clients"][i]["delegate_name"].string!)
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
