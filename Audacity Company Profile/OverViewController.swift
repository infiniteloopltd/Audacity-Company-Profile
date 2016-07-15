//
//  OverViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
class OverViewController: BaseViewController, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var parallaxImageView: UIImageView!
    var counter: Int = 0
    var counterDown: Int = 0
    var previousTranslation : CGFloat = 0.0
    var scrollDirection : Bool = false   // up = false down = true
    var scrollFire : Bool = false
    var step : Int = 0
    var scrollToTop : Bool = false;
    var needScroll : Bool = true
    var tableOrginalHeight : CGFloat = 0.0
    
    
    var tableViewOriginY: CGFloat!
    var parallaxHeaderHeight: CGFloat!
    
    var totalScreenHeight : CGFloat!
    
    
    @IBOutlet var companyIcon: UIImageView!
    
    @IBOutlet var companyName: UILabel!
    
    
    @IBOutlet weak var inQueueLebel: UILabel!
    @IBOutlet weak var inQueueCounterLebel: UILabel!
    @IBOutlet weak var developingLebel: UILabel!
    @IBOutlet weak var developingCounterLebel: UILabel!
    @IBOutlet var companyMoto: UILabel!
    @IBOutlet weak var completedCounterLebel: UILabel!
    @IBOutlet weak var completedLebel: UILabel!
    
    @IBOutlet var navigationDrawerIcon: UIButton!
    
    
     var appDelegate:AppDelegate!
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    @IBAction func navigationDrawerIconAction(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var hiddenContainer: UIView!
    
    
    var stopFlag : Bool = false
    @IBOutlet var headerView: UIView!
    var itemTitle = [String]()
    var itemImage = [String]()
    var cellContent = [String]()
    
    var companyIconName: String!
    var backgroundImage: String!
    var compName: String!
    var companyTag: String!
    
    var counterName = [String] ()
    var counterNumber = [String]()
    
    
    @IBAction func mapFabBtn(sender: AnyObject) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
       
        self.tableView.estimatedRowHeight = 10
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.reloadData()
        
        self.tableView.scrollEnabled = false
        companyIcon.alpha = 1.0
        companyName.alpha = 1.0
        companyMoto.alpha = 1.0
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
        
        return cellContent.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! OverviewCell
        
        cell.itemTitle.text = itemTitle[indexPath.row]
        cell.itemDetail.text = cellContent[indexPath.row]
        cell.itemIcon.image = UIImage(named: itemImage[indexPath.row])
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func onContentSizeChange(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
  
    
    func showLine(height:CGFloat) {
        let alertController = UIAlertController(title: Constants.COMPANY_NAME, message:
            "\(height)  ", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
       
        if recognizer.state == UIGestureRecognizerState.Ended {
            stopFlag = !stopFlag
            previousTranslation = 0
        }
        
        if recognizer.state != UIGestureRecognizerState.Ended {
            
            
            let translation = recognizer.translationInView(self.view)
            scrollFire = false
            if(previousTranslation == 0) {
                
            } else if(previousTranslation > translation.y) {
                counter--
                scrollDirection = false
                scrollFire = true
                counterDown = 0
                
            } else if(previousTranslation < translation.y){
                counterDown++
                scrollDirection = true
                scrollFire = true
                counter = 0
            }
            
            
            
            if(scrollFire) {
                if(scrollDirection) {
                    
                    //  Going down
                    
                    if(headerView.frame.origin.y < 0) {
                        
                        var distance = previousTranslation - translation.y
                        
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        distance = headerView.frame.origin.y + distance
                        
                        
                        if ( distance > 0) {
                            distance = 0
                        }
                        headerView.frame.origin.y =   distance
                        parallaxImageView.frame.origin.y = -distance
                    }
                    
                    
                    if(tableView.frame.origin.y < tableViewOriginY ) {
                        var distance = previousTranslation - translation.y
                        
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        
                        
                        if( tableView.frame.size.height > tableOrginalHeight) {
                            var tableHeight = tableView.frame.size.height - distance
                            
                            if(tableHeight < tableOrginalHeight) {
                                tableHeight = tableOrginalHeight
                            }
                            
                            tableView.frame.size.height = tableHeight
                        } else if ( tableView.frame.size.height == tableOrginalHeight) {
                            needScroll = false;
                        }
                        
                        distance = tableView.frame.origin.y + distance
                        tableView.scrollEnabled = false
                        if(distance > tableViewOriginY) {
                            distance = tableViewOriginY
                            needScroll = false
                        } else {
                               tableView.scrollEnabled = false
                        }
                        tableView.frame.origin.y =   distance
                        
                        var alphaRange = distance - parallaxHeaderHeight
                        
                        
                        alphaRange =  ( alphaRange / (tableViewOriginY - parallaxHeaderHeight) )
                        
                        hiddenContainer.alpha = 1 - alphaRange
                        companyIcon.alpha = alphaRange
                        companyName.alpha = alphaRange
                        companyMoto.alpha =  alphaRange
                        
                    }
                    
                    
                } else {
                    // Going Up
                    
                    let reverseScrollHeight: CGFloat = -(tableViewOriginY - parallaxHeaderHeight)
                    if(headerView.frame.origin.y > reverseScrollHeight) {
                        
                        var distance = previousTranslation - translation.y
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        distance = headerView.frame.origin.y - distance
                        
                        if (distance < reverseScrollHeight) {
                            distance = reverseScrollHeight
                        }
                        
                        
                        headerView.frame.origin.y =   distance
                        parallaxImageView.frame.origin.y = -distance
                        
                        
                    }
                    
                    if(tableView.frame.origin.y > parallaxHeaderHeight) {
                        
                        var distance = previousTranslation - translation.y
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        let tableHeight = tableView.frame.size.height + distance
                        tableView.frame.size.height = tableHeight
                        if ( tableView.frame.size.height >= tableView.contentSize.height) {
                            needScroll = false;
                        }
                        
                        distance = tableView.frame.origin.y - distance
                        
                
                        tableView.scrollEnabled = false
                        if(distance < parallaxHeaderHeight) {
                            distance = parallaxHeaderHeight
                            
                            if(needScroll) {
                                tableView.scrollEnabled = true
                            }
                            else {
                                tableView.scrollEnabled = false
                            }
                            
                        }
                        
                        var alphaRange = tableViewOriginY - distance
                        
                        
                        
                        alphaRange = alphaRange / (tableViewOriginY - parallaxHeaderHeight)
                        hiddenContainer.alpha =  alphaRange
                        companyIcon.alpha = (1 - alphaRange)
                        companyName.alpha = (1 - alphaRange)
                        companyMoto.alpha = (1 - alphaRange)
                        
                        tableView.frame.origin.y =  distance
                        
                        
                    } else {
                        if( tableView.frame.size.height != tableView.contentSize.height) {
                            tableView.scrollEnabled = true
                        }
                    }
                    
                    
                }
            }
            
            previousTranslation = translation.y
            
            
            
            
        }
    }
    
    
    // called on start of dragging (may require some time and or distance to move)
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if( tableView.contentOffset.y <= 0 ) {
            scrollToTop = true;
            tableView.scrollEnabled = false;
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        trackEvent(1, actionName: "OverView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLayoutSubviews() {
       
        tableOrginalHeight = tableView.frame.size.height
        tableViewOriginY = tableView.frame.origin.y
        parallaxHeaderHeight =  78
        
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if( gestureRecognizer .isKindOfClass(UIPanGestureRecognizer)) {
            let uiPangesture : UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            let translation : CGPoint =  uiPangesture.translationInView(self.view)
            var xDistance: CGFloat = translation.x
            var yDistance: CGFloat = translation.y
            if( xDistance < 0 ) {
                xDistance = xDistance * (-1)
            }
            if( yDistance < 0 ) {
                yDistance = yDistance * (-1)
            }
            
            if ( xDistance > yDistance) {
                return false
            } else if ( xDistance < yDistance ) {
                return true
            }
            
        }
        return false;
    }
    
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("overview", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    companyIcon.image = UIImage(named: jsonObj["overview"]["company_icon"].string!)
                    parallaxImageView.image = UIImage(named:jsonObj["overview"]["background_image"].string!)
                    companyName.text = jsonObj["overview"]["company_name"].string!
                    companyMoto.text = jsonObj["overview"]["company_tag"].string!
                    
                    for ( var i:Int = 0; i<jsonObj["overview"]["counter_info"].count; i++ ) {
                        
                        counterName.append(jsonObj["overview"]["counter_info"][i]["text"].string!)
                        counterNumber.append(jsonObj["overview"]["counter_info"][i]["number"].string!)
                        
                    }
                    
                    for(var i:Int = 0; i<jsonObj["overview"]["basic_info"].count; i++) {
                        itemTitle.append(jsonObj["overview"]["basic_info"][i]["title"].string!)
                        itemImage.append(jsonObj["overview"]["basic_info"][i]["image"].string!)
                        cellContent.append(jsonObj["overview"]["basic_info"][i]["body"].string!)
                    }
                    
                    completedLebel.text = counterName[0]
                    developingLebel.text = counterName[1]
                    inQueueLebel.text = counterName[2]
                    
                    completedCounterLebel.text = counterNumber[0]
                    developingCounterLebel.text = counterNumber[1]
                    inQueueCounterLebel.text = counterNumber[2]
                    
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
