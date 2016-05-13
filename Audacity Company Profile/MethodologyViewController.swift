//
//  MethodologyViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

class MethodologyViewController: BaseViewController, UITableViewDelegate, UIGestureRecognizerDelegate {
    
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
    var demo : Bool = true;
    var tableViewOriginY: CGFloat!
    var parallaxHeaderHeight: CGFloat!
    
    

    
    @IBOutlet var companyIcon: UIImageView!
    
    @IBOutlet var navigationDrawerIcon: UIButton!
    
    
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
    
    var appDelegate:AppDelegate!
    
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.reloadData()
        
        self.tableView.scrollEnabled = false
        companyIcon.alpha = 1.0
        
        tableOrginalHeight = tableView.frame.size.height
        
       
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
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! MethodologyCell
        
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
        let alertController = UIAlertController(title: "Audacity IT Solution", message:
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
                //counter--
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
                        
                        print(distance)
                        tableView.frame.origin.y =   distance
                        
                        var alphaRange = distance - parallaxHeaderHeight
                        
                        
                        alphaRange =  ( alphaRange / (tableViewOriginY - parallaxHeaderHeight) )
                        
                        hiddenContainer.alpha = 1 - alphaRange
                        companyIcon.alpha = alphaRange
                       
                        
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
                        
                        /*
                        if( tableView.frame.size.height < tableView.contentSize.height) {
                            var tableHeight = tableView.frame.size.height + distance
                            
                            
                            if(tableHeight > tableView.contentSize.height) {
                                tableHeight = tableView.contentSize.height
                                
                            }
                            
                            tableView.frame.size.height = tableHeight
                        } else if ( tableView.frame.size.height == tableView.contentSize.height) {
                            needScroll = false;
                        }
                        
                        */
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
                        print(distance)
                        tableView.frame.origin.y =  distance
                        
                        
                    } else {
                        //  println("Now in top")
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
            // println("Scroll To Top")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //super.viewDidAppear(animated)
        trackEvent(1, actionName: "MethodologyView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
            
            //print("I am from if \(translation.x) translation y = \(translation.y)", terminator: "")
            
            if ( xDistance > yDistance) {
                return false
            } else if ( xDistance < yDistance ) {
                return true
            }
            
        }
        return false;
    }
    
    
    override func viewDidLayoutSubviews() {

        tableOrginalHeight = tableView.frame.size.height
        tableViewOriginY = tableView.frame.origin.y
        parallaxHeaderHeight =  78
        
    }
    
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("methodology", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    companyIcon.image = UIImage(named: jsonObj["methodology"]["company_icon"].string!)
                    parallaxImageView.image = UIImage(named:jsonObj["methodology"]["background_image"].string!)
                    
                    
                    
                    for(var i:Int = 0; i<jsonObj["methodology"]["methodology_info"].count; i++) {
                        itemTitle.append(jsonObj["methodology"]["methodology_info"][i]["heading"].string!)
                        itemImage.append(jsonObj["methodology"]["methodology_info"][i]["image"].string!)
                        cellContent.append(jsonObj["methodology"]["methodology_info"][i]["description"].string!)
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




