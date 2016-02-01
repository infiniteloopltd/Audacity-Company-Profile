//
//  PortfolioViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController //,  UITableViewDelegate
{
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var tableViewFilter: UITableView!
    
    @IBOutlet var blackSheet: UIView!
    var showing:Bool = false
    var height : CGFloat = 0
    var isFabShow: Bool = true;
    
    
    @IBOutlet var getStartedPage: UIView!
    @IBAction func filterFabAction(sender: AnyObject) {
        showHideFilter()
    }
    @IBAction func getStartedAction(sender: AnyObject) {
    }
    
    @IBOutlet var fabBtn: UIButton!
    
    var cellContentOrginal = ["All","Wearable","UI/UX","Web","iOS","Android","Product"]
    var cellImageOrginal = ["ic_fab_all.png","ic_fab_wearable.png","ic_fab_ui_ux.png","ic_fab_web.png",
        "ic_fab_ios.png","ic_fab_android","ic_fab_product.png"]
    
    var portfolioImageOrginal = ["img_portfolio_1.jpg","img_portfolio_2.jpg","img_portfolio_3.jpg","img_portfolio_4.jpg","img_portfolio_5.jpg","img_portfolio_6.jpg",
        "img_portfolio_7.jpg","img_portfolio_8.jpg","img_portfolio_9.jpg" ]
    
    var portfolioNameOrginal = ["Amar Phonebook","Colours FM","Monasa Learning Centre","Lock Deal","How I Work","Finder","Company Profile" ,"U-NEXT", "Deshi Deal"   ]
    
    var portfolioTypeOrginal = ["Android, iOS, UI/UX","Android, UI/UX","Website, UI/UX","Website, Android, UI/UX","Product, Website, Android, iOS, UI/UX","Product, Android, UI/UX","Product, Website, Android, UI/UX","Android, iOS","Product, Android, UI/UX"]
    var likedOrginal = [false, false, false, false, false, false, false,false, false ]
    
    
    var cellContent = ["All","Wearable","UI/UX","Web","iOS","Android","Product"]
    var cellImage = ["ic_fab_all.png","ic_fab_wearable.png","ic_fab_ui_ux.png","ic_fab_web.png",
        "ic_fab_ios.png","ic_fab_android","ic_fab_product.png"]
    
    var portfolioImage = ["img_portfolio_1.jpg","img_portfolio_2.jpg","img_portfolio_3.jpg","img_portfolio_4.jpg","img_portfolio_5.jpg","img_portfolio_6.jpg",
        "img_portfolio_7.jpg","img_portfolio_8.jpg","img_portfolio_9.jpg" ]
    
    var portfolioName = ["Amar Phonebook","Colours FM","Monasa Learning Centre","Lock Deal","How I Work","Finder","Company Profile" ,"U-NEXT", "Deshi Deal"   ]
    
    var portfolioType = ["Android, iOS, UI/UX","Android, UI/UX","Website, UI/UX","Website, Android, UI/UX","Product, Website, Android, iOS, UI/UX","Product, Android, UI/UX","Product, Website, Android, UI/UX","Android, iOS","Product, Android, UI/UX"]
    
    var liked = [false, false, false, false, false, false, false,false, false ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        getStartedPage.hidden = true;
        
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
        
        
        if tableView == self.tableView  {
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! PortfolioItemCell
            
            
            
            // cell.label.text = cellContent[indexPath.row]
            // cell.label.attributedText = attributedString
            // cell.itemName.text = cellContent[indexPath.row]
            //  cell.itemImage.setImage(UIImage(named: cellImage[indexPath.row]), forState: UIControlState.Normal)
            //cell.label.hidden = true
            
            cell.itemImage.image = UIImage(named: portfolioImage[indexPath.row])
            cell.itemName.text = portfolioName[indexPath.row]
            cell.itemType.text = portfolioType[indexPath.row]
            //  cell.urls = "ic_heart_red.png"
            
            if(liked[indexPath.row]) {
                cell.itemLike.setImage(UIImage(named: "ic_heart_red.png"), forState: UIControlState.Normal)
            } else {
                cell.itemLike.setImage(UIImage(named: "ic_heart_outline_grey.png"), forState: UIControlState.Normal)
                
            }
            return cell
        } else {
            
            
            
            let  cell2 = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)  as! FilterItemCell
            
            
            
            
            
            // cell.label.text = cellContent[indexPath.row]
            // cell.label.attributedText = attributedString
            cell2.itemName.text = cellContent[indexPath.row]
            cell2.itemImage.setImage(UIImage(named: cellImage[indexPath.row]), forState: UIControlState.Normal)
            //cell.label.hidden = true
            //cell2.backgroundColor = uicolorFromHex(0x21252A)
            let backgroundView = UIView()
           backgroundView.backgroundColor = UIColor.clearColor()
            cell2.selectedBackgroundView = backgroundView
            return cell2
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    func onContentSizeChange(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
       let cell = tableView.cellForRowAtIndexPath(indexPath) as! FilterItemCell
        cell.itemImage.backgroundColor = uicolorFromHex(0x5e9c19)
        
        showHideFilter()
        
        var index:Int = 0
        let selectedType = cellContent[indexPath.row]
        
        
        
        if ( selectedType != "All" ) {
            
            portfolioImage.removeAll(keepCapacity: true)
            portfolioName.removeAll(keepCapacity: true)
            portfolioType.removeAll(keepCapacity: true)
            liked.removeAll(keepCapacity: true)
            
            
            let count = portfolioImageOrginal.count
            
            
            for(var i:Int = 0; i < count ; i++ ) {
                
                let temp = portfolioTypeOrginal[i]
                
                if temp.rangeOfString(selectedType) != nil{
                    //println("exists")
                    portfolioName.append(portfolioNameOrginal[i])
                    portfolioImage.append(portfolioImageOrginal[i])
                    portfolioType.append(portfolioTypeOrginal[i])
                    liked.append(likedOrginal[i])
                    
                    index++
                    
                }
                
                
            }
            
            if (index == 0) {
                // println("No Project found")
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
            liked = likedOrginal
            getStartedPage.hidden = true
            self.tableView.hidden = false;
            self.tableView.reloadData()
            
            
        }
        
        
        
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == tableViewFilter {
           // let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
           // cellToDeSelect.contentView.backgroundColor = UIColor.clearColor()
        }
    }
    
    
    
    
    
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == self.tableView {
            return 214
        } else {
            return 50
        }
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            
            
            let touchPoint = longPressGestureRecognizer.locationInView(self.tableView)
            if let indexPath = self.tableView.indexPathForRowAtPoint(touchPoint) {
                
                // your code here, get the row for the indexPath or do whatever you want
                liked[indexPath.row] = true
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
    
    func showHideFilter() {
        
        //print("Table filter height=\(tableViewFilter.frame.height)  table filter content =\(tableViewFilter.contentSize.height)")
        
        if (!showing) {
            //blackSheet.hidden = false
            
            
            self.showing = true
            
            
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                /* self.tableView.center = CGPointMake(self.tableView.center.x - (self.tableView.frame.size.width/2), self.tableView.center.y)
                self.tableView.alpha = 1
                self.blackSheet.alpha = 1*/
                self.tableViewFilter.center = CGPointMake(self.tableViewFilter.center.x , self.tableViewFilter.center.y  - (self.tableViewFilter.frame.size.height))
                
                //self.tableView.frame.size.height = self.height
                self.tableViewFilter.alpha = 1
                self.blackSheet.alpha = 1
                
                
                
            })
            
            
        } else {
            //blackSheet.hidden = true
            showing = false
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                /*self.tableView.center = CGPointMake(self.tableView.center.x + (self.tableView.frame.size.width/2), self.tableView.center.y)
                self.tableView.alpha = 0
                self.blackSheet.alpha = 0*/
                
                self.tableViewFilter.center = CGPointMake(self.tableViewFilter.center.x , self.tableViewFilter.center.y  + (self.tableViewFilter.frame.size.height))
                //self.tableView.frame.size.height = 0
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
        }
        
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        /*println("contentOffsetY = \(self.tableView.contentOffset.y ) and contentSizeHeight=\(self.tableView.contentSize.height)")
        if( self.tableView.contentOffset.y == (self.tableView.contentSize.height - 214) ) {
        println("hide fab")
        }
        
        */
        
        // var height:CGFloat = scrollView.frame.size.height;
        let height:CGFloat = self.tableView.frame.size.height;
        
        let  contentYoffset : CGFloat = self.tableView.contentOffset.y;
        
        //var distanceFromBottom : CGFloat = scrollView.contentSize.height - contentYoffset;
        
        let distanceFromBottom : CGFloat = self.tableView.contentSize.height - contentYoffset;
        if(distanceFromBottom < (height + 214 ) )
        {
            // println("End of the table")
            
            if(isFabShow) {
                
                
                
                self.fabBtn.layer.transform = CATransform3DMakeScale(1,1,1)
                UIView.animateWithDuration(1, animations: {
                    self.fabBtn.layer.transform = CATransform3DMakeScale(0,0,1)
                })
                
                
                
                isFabShow = false
                
            }
            
        } else {
            //println("Not end")
            
            if(!isFabShow) {
                
                self.fabBtn.layer.transform = CATransform3DMakeScale(0,0,1)
                UIView.animateWithDuration(1, animations: {
                    self.fabBtn.layer.transform = CATransform3DMakeScale(1,1,1)
                })
                
                isFabShow = true
            }
            
        }
        
    }
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
}
