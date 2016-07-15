//
//  TeamViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
class TeamViewController: BaseViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var screenWidth:CGFloat!
    var itemImage = [String]()
    var itemTitle = [String]()
    var itemDetail = [String]()
    
    var appDelegate:AppDelegate!
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        self.automaticallyAdjustsScrollViewInsets = false
        self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        let sizeRect:CGRect = UIScreen.mainScreen().applicationFrame
        screenWidth    = sizeRect.size.width
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        collectionView.reloadData()
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImage.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(screenWidth < 700) {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewItemCell", forIndexPath: indexPath) as! CollectionViewItemCell
            
            cell.itemImage.image = UIImage(named: itemImage[indexPath.row])
            cell.itemName.text = itemTitle[indexPath.row]
            cell.itemDetail.text = itemDetail[indexPath.row]
            return cell

        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewItemCelliPad", forIndexPath: indexPath) as! CollectionViewItemCell
            
            cell.itemImage.image = UIImage(named: itemImage[indexPath.row])
            cell.itemName.text = itemTitle[indexPath.row]
            cell.itemDetail.text = itemDetail[indexPath.row]
            return cell
            
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(screenWidth > 700) {
            return CGSizeMake(180, 180)
        }
        return CGSizeMake(110, 110)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 10, 0, 10)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        trackEvent(1, actionName: "TeamView Controller")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func loadData() {
        
        
        if let path = NSBundle.mainBundle().pathForResource("team", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    for(var i:Int = 0; i<jsonObj["team"].count; i++) {
                        
                        itemTitle.append(jsonObj["team"][i]["name"].string!)
                        itemImage.append(jsonObj["team"][i]["image"].string!)
                        itemDetail.append(jsonObj["team"][i]["designation"].string!)
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
