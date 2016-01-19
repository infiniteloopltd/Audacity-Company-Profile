//
//  OverViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class OverViewController: UIViewController , UITableViewDelegate {

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
    
    
    @IBOutlet var companyIcon: UIImageView!
    
    @IBOutlet var companyName: UILabel!
    
    
    @IBOutlet var companyMoto: UILabel!
    
    @IBOutlet var navigationDrawerIcon: UIButton!
    
    
    @IBAction func navigationDrawerIconAction(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var hiddenContainer: UIView!
    
    
    var stopFlag : Bool = false
    @IBOutlet var headerView: UIView!
    var cellContent = ["BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657", "BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657","BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657","BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657", "BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657", "BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657","BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657","BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657"]
    
    var itemImage = ["ic_overview_basic.png", "ic_overview_skill.png","ic_overview_infrastructure.png","ic_overview_location.png","ic_overview_basic.png", "ic_overview_skill.png","ic_overview_infrastructure.png","ic_overview_location.png"]
    
    var itemTitle = ["BASIC INFO","SKILL","INFRASTRUCTURE","LOCATION","BASIC INFO","SKILL","INFRASTRUCTURE","LOCATION"]
    
    
    
    
    /*  var cellContent = ["BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657", "BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657","BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657","BASIS Membership ID : G682 \nTrade License No: 02048475 \nTIN : 442670895657"]
    
    var itemImage = ["ic_overview_basic.png", "ic_overview_skill.png","ic_overview_infrastructure.png","ic_overview_location.png"]
    
    var itemTitle = ["BASIC INFO","SKILL","INFRASTRUCTURE","LOCATION"]
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 10
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.reloadData()
        
        self.tableView.scrollEnabled = false
        
        //hiddenContainer.alpha = 1.0
        companyIcon.alpha = 1.0
        companyName.alpha = 1.0
        companyMoto.alpha = 1.0
        
        tableOrginalHeight = tableView.frame.size.height
        
        // println("table orginal height \(tableOrginalHeight)")
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
        
        
        
        /*  var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        var attributedString = NSAttributedString(string: cellContent[indexPath.row],
        attributes: [
        NSParagraphStyleAttributeName: paragraphStyle,
        NSBaselineOffsetAttributeName: NSNumber(float: 0)
        ])
        
        
        // cell.label.text = cellContent[indexPath.row]
        cell.label.attributedText = attributedString
        //cell.label.hidden = true
        */
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func onContentSizeChange(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        // var height:CGFloat = self.calculateHeightForString(cellContent[indexPath.row])
        // showLine(height)
        
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
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //  var height:CGFloat = self.calculateHeightForString(cellContent[indexPath.row])
        
        //return ( height * 2) + 50
        return 100
    }
    
    
    
    
    /*func calculateHeightForString(inString:String) -> CGFloat
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
    
    
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        /* let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
        view.center = CGPoint(x:view.center.x + translation.x,
        y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        */
        
        
        
        
        // println("tableViewHeight = \(tableView.frame.size.height)  tableViewContentSize= \(tableView.contentSize.height)  scrollstats=\(tableView.scrollEnabled)  needScroll =\(needScroll)")
        
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
            
            
            
            //println("origin = \(headerView.frame.origin.y)")
            if(scrollFire) {
                if(scrollDirection) {
                    let con =  Float(counterDown)
                    var con2 = CGFloat(con)
                    
                    
                    //  headerView.center = CGPoint(x:headerView.center.x ,y:headerView.center.y + con2)
                    var translate : CGFloat = 0
                    
                    if(headerView.frame.origin.y < 0) {
                        
                        var distance = previousTranslation - translation.y
                        
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        distance = headerView.frame.origin.y + distance
                        
                        
                        if ( distance > 0) {
                            distance = 0
                        }
                        //println("distance = \(distance)")
                        headerView.frame.origin.y =   distance
                        parallaxImageView.frame.origin.y = -distance
                    }
                    
                    
                    if(tableView.frame.origin.y<308) {
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
                        
                        //tableView.frame.size.height = tableView.frame.size.height - distance
                        
                        //  headerView.frame.origin.y =  headerView.frame.origin.y + distance
                        //distance = distance + 5
                        distance = tableView.frame.origin.y + distance
                        tableView.scrollEnabled = false
                        if(distance > 308) {
                            distance = 308
                            //tableView.scrollEnabled = true
                            needScroll = false
                        } else {
                            //   println("Orginal Position no scroll")
                            tableView.scrollEnabled = false
                        }
                        
                        // println("Down distance = \(distance)")
                        
                        
                        
                        tableView.frame.origin.y =   distance
                        
                        var alphaRange = distance - 78
                        
                        
                        alphaRange =  ( alphaRange / 230 )
                        
                        hiddenContainer.alpha = 1 - alphaRange
                        companyIcon.alpha = alphaRange
                        companyName.alpha = alphaRange
                        companyMoto.alpha =  alphaRange
                        
                    }
                    
                    
                    
                    
                    
                    
                } else {
                    let con =  Float(counter)
                    var con2 = CGFloat(con)
                    //headerView.center = CGPoint(x:headerView.center.x ,y:headerView.center.y + con2)
                    if(headerView.frame.origin.y > -230) {
                        
                        var distance = previousTranslation - translation.y
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        distance = headerView.frame.origin.y - distance
                        
                        if (distance < -230) {
                            distance = -230
                        }
                        
                        
                        headerView.frame.origin.y =   distance
                        // parallaxImageView.frame.offset(dx: 0, dy: -distance)
                        parallaxImageView.frame.origin.y = -distance
                        
                        
                    }
                    
                    if(tableView.frame.origin.y > 78) {
                        
                        var distance = previousTranslation - translation.y
                        if( distance < 0 ) {
                            distance = distance * (-1)
                        }
                        
                        // distance = distance + 5
                        
                        
                        if( tableView.frame.size.height < tableView.contentSize.height) {
                            var tableHeight = tableView.frame.size.height + distance
                            
                            if(tableHeight > tableView.contentSize.height) {
                                tableHeight = tableView.contentSize.height
                            }
                            
                            tableView.frame.size.height = tableHeight
                        } else if ( tableView.frame.size.height == tableView.contentSize.height) {
                            needScroll = false;
                        }
                        
                        
                        distance = tableView.frame.origin.y - distance
                        
                        //tableView.scrollEnabled = false
                        tableView.scrollEnabled = false
                        if(distance < 78) {
                            distance = 78
                            
                            if(needScroll) {
                                tableView.scrollEnabled = true
                            }
                            else {
                                tableView.scrollEnabled = false
                            }
                            
                        }
                        
                        var alphaRange = 308 - distance
                        
                        
                        
                        alphaRange = alphaRange / 230
                        hiddenContainer.alpha =  alphaRange
                        companyIcon.alpha = (1 - alphaRange)
                        companyName.alpha = (1 - alphaRange)
                        companyMoto.alpha = (1 - alphaRange)
                        
                        tableView.frame.origin.y =  distance
                        
                        //  println("table origin = \(tableView.frame.origin.y) tableheight=\(tableView.frame.size.height)")
                        
                    } else {
                        //  println("Now in top")
                        if( tableView.frame.size.height != tableView.contentSize.height) {
                            tableView.scrollEnabled = true
                        }
                    }
                    
                    //  println("Up translation y: \(translation.y)   counter= \(counter)  counterDown=\(counterDown)   origin=\(headerView.frame.origin.y)")
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
        super.viewDidAppear(animated)
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
            
            //print("I am from if \(translation.x) translation y = \(translation.y)")
            
            if ( xDistance > yDistance) {
                return false
            } else if ( xDistance < yDistance ) {
                return true
            }
            
        }
        return false;
    }

}