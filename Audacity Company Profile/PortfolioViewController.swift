//
//  PortfolioViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import MessageUI
import SwiftyJSON

class PortfolioViewController: BaseViewController, MFMailComposeViewControllerDelegate //,  UITableViewDelegate
{
    
    var lastContentOffset : CGFloat = 0
    
    var filterItemSelectedColor : UIColor!
    var filterItemColor: UIColor!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var tableViewFilter: UITableView!
    
    @IBOutlet var blackSheet: UIView!
    var showing:Bool = false
    var height : CGFloat = 0
    var isFabShow: Bool = true;
    
    var count : Int = 0
    
    var fabButtonHide: Bool = false;
    var fabScale:CGFloat = 1;
     var screenWidth:CGFloat!
    
    @IBOutlet var getStartedPage: UIView!
    @IBAction func filterFabAction(sender: AnyObject) {
        showHideFilter()
    }
    @IBAction func getStartedAction(sender: AnyObject) {
        
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("Contact with Audacity IT Solutions via company profile app")
        picker.setToRecipients([Constants.EMAIL])
        
        
        presentViewController(picker, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet var fabBtn: UIButton!
    
    
    var appDelegate:AppDelegate!
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    var cellContentOrginal = [String]()
    var cellImageOrginal = [String]()
    var portfolioImageOrginal = [String]()
    var portfolioNameOrginal = [String]()
    var portfolioTypeOrginal = [String]()
    var cellContent = [String]()
    var cellImage = [String]()
    var portfolioImage = [String]()
    var portfolioName = [String]()
    var portfolioType = [String]()
    
    var filterIcon : String!
    var menuColor : String!
    var menuPressedColor : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadData()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        getStartedPage.hidden = true;
         appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let sizeRect:CGRect = UIScreen.mainScreen().applicationFrame
         screenWidth    = sizeRect.size.width
        UITableViewCell.appearance().backgroundColor = UIColor.clearColor()
        
       
        
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
        
        if tableView == self.tableView {
            return portfolioImage.count;
        } else {
            return cellContent.count;
        }
        
        //  return portfolioImage.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell: PortfolioItemCell
        if tableView == self.tableView  {
            
            if(screenWidth > 700) {
              cell = tableView.dequeueReusableCellWithIdentifier("CellIPad", forIndexPath: indexPath)  as! PortfolioItemCell
            } else {
               cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! PortfolioItemCell
            }
            
            cell.itemImage.image = UIImage(named: portfolioImage[indexPath.row])
            cell.itemName.text = portfolioName[indexPath.row]
            cell.itemType.text = portfolioType[indexPath.row]
            cell.itemImage.backgroundColor = filterItemColor
            
            return cell
            
        } else {
            
            let  cell2 = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! FilterItemCell
            
            cell2.itemName.text = cellContent[indexPath.row]
            cell2.itemImage.setImage(UIImage(named: cellImage[indexPath.row]), forState: UIControlState.Normal)
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clearColor()
            cell2.selectedBackgroundView = backgroundView

            return cell2
            
        }
        
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func onContentSizeChange(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
       let cell = tableView.cellForRowAtIndexPath(indexPath) as! FilterItemCell
        cell.itemImage.backgroundColor = filterItemSelectedColor
        showHideFilter()
        var index:Int = 0
        let selectedType = cellContent[indexPath.row]
        
        if ( selectedType != "All" ) {
            
            portfolioImage.removeAll(keepCapacity: true)
            portfolioName.removeAll(keepCapacity: true)
            portfolioType.removeAll(keepCapacity: true)
            
            let count = portfolioImageOrginal.count
            
            for(var i:Int = 0; i < count ; i++ ) {
                
                let temp = portfolioTypeOrginal[i]
                
                if temp.rangeOfString(selectedType) != nil{
                    portfolioName.append(portfolioNameOrginal[i])
                    portfolioImage.append(portfolioImageOrginal[i])
                    portfolioType.append(portfolioTypeOrginal[i])
                    
                    index++
                    
                }
                
                
            }
            
            if (index == 0) {
                getStartedPage.hidden = false
                self.tableView.hidden = true;
                
            } else {
                self.tableView.reloadData()
                getStartedPage.hidden = true
                self.tableView.hidden = false;
            }
            
            
        } else {
            
            portfolioName = portfolioNameOrginal
            portfolioImage = portfolioImageOrginal
            portfolioType = portfolioTypeOrginal
           
            getStartedPage.hidden = true
            self.tableView.hidden = false;
            self.tableView.reloadData()
            
            
        }
        
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == self.tableView {
            
            if(screenWidth > 700) {
                return 350
            } else {
            
            return 214
            }
        } else {
            return 50
        }
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        trackEvent(1, actionName: "PortfolioView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    
    func showHideFilter() {
        
        if (!showing) {
            
            self.showing = true
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.tableViewFilter.center = CGPointMake(self.tableViewFilter.center.x , self.tableViewFilter.center.y  - (self.tableViewFilter.frame.size.height))
                self.tableViewFilter.alpha = 1
                self.blackSheet.alpha = 1
                
            })
            
        } else {
            showing = false
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.tableViewFilter.center = CGPointMake(self.tableViewFilter.center.x , self.tableViewFilter.center.y  + (self.tableViewFilter.frame.size.height))
                self.tableViewFilter.alpha = 0
                self.blackSheet.alpha = 0
                
            })
        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        self.tableViewFilter.center = CGPointMake(self.tableViewFilter.center.x , self.tableViewFilter.center.y  + (self.tableViewFilter.frame.size.height))
        self.height = self.tableViewFilter.frame.size.height
        
        self.tableViewFilter.alpha = 0
        self.blackSheet.alpha = 0
        
        
        let filterTableHeight = tableViewFilter.frame.height
        let filterContentHeight = tableViewFilter.contentSize.height
        
        if(filterTableHeight > filterContentHeight ) {
            let contentInset = filterTableHeight - filterContentHeight
            
            tableViewFilter.contentInset = UIEdgeInsets(top: contentInset, left: 0, bottom: 0, right: 0)
            tableViewFilter.scrollEnabled = false
        }
        
        
        showHideFilter()
        
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0);  //slecting 0th row with 0th section
        self.tableViewFilter.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None);
        self.tableView(self.tableViewFilter, didSelectRowAtIndexPath: rowToSelect);
        
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.50, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        tableViewFilter.backgroundColor = UIColor.clearColor()
        
    }
   
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("portfolio", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    
                    for(var i:Int = 0; i<jsonObj["projects"].count; i++) {
                        
                        portfolioNameOrginal.append(jsonObj["projects"][i]["name"].string!)
                        portfolioImageOrginal.append(jsonObj["projects"][i]["image"].string!)
                        var type: String = ""
                        for(var j:Int = 0; j<jsonObj["projects"][i]["platforms"].count; j++) {
                            //portfolioTypeOrginal.append(jsonObj["projects"][i]["platforms"][j].string!)
                            type = "\(type)\(jsonObj["projects"][i]["platforms"][j].string!)"
                            if(j != (jsonObj["projects"][i]["platforms"].count - 1)) {
                                type = "\(type), "
                            }
                        }
                        portfolioTypeOrginal.append(type)
                       
                    }
                    
                    portfolioImage = portfolioImageOrginal
                    portfolioName = portfolioNameOrginal
                    portfolioType = portfolioTypeOrginal
                    
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        
        if let path = NSBundle.mainBundle().pathForResource("filter", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    fabBtn.imageView?.image = UIImage(named: jsonObj["filter"]["filter_icon"].string!)
                    filterItemColor = UIColor(hexString: jsonObj["filter"]["menu_color"].string!)
                    fabBtn.imageView?.backgroundColor = filterItemColor
                    filterItemSelectedColor = UIColor(hexString: jsonObj["filter"]["menu_pressed_color"].string!)
                    cellContentOrginal.append("All")
                    cellImageOrginal.append("ic_fab_all.png")

                    for(var i:Int = 0; i<jsonObj["filter"]["options"].count; i++) {
                        
                        cellContentOrginal.append(jsonObj["filter"]["options"][i]["title"].string!)
                        cellImageOrginal.append(jsonObj["filter"]["options"][i]["image"].string!)
                         
                    }
                    
                    cellContent = cellContentOrginal
                    cellImage = cellImageOrginal
                    
                    
                    
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


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
