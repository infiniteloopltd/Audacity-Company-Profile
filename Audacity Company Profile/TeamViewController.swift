//
//  TeamViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
class TeamViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var screenWidth:CGFloat!
    
    
    
    
   /* var itemImage = ["ic_member_faisal.png", "ic_member_suraiya.png","ic_member_siddiq.png","ic_member_tushar.png","ic_member_tuhin.png","ic_member_tinu.png","ic_member_saurav.png","ic_member_sumon.png","ic_member_shaun.png",
        "ic_member_mamun.png","ic_member_rifat.png"]
    
    var itemTitle = ["Faisal","Suraiya","Siddiq","Tushar","Tuhin","Tinu","Sourav","Sumon","Shaun","Mamun","Rifat"]
    var itemDetail = ["Founder & CTO","Founder & COO","Founder & CEO","Android Engineer","UI/UX Engineer","QA Engineer","Android Engineer","Web Designer","UI/UX Consultant","Web Engineer","Office Admin"]*/
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
        
        //print("screenWidth = \(screenWidth)")
       
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
        if(screenWidth<700) {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewItemCell", forIndexPath: indexPath) as! CollectionViewItemCell
            
            cell.itemImage.image = UIImage(named: itemImage[indexPath.row])
            cell.itemName.text = itemTitle[indexPath.row]
            cell.itemDetail.text = itemDetail[indexPath.row]
            
            //cell.setGalleryItem(galleryItems[indexPath.row])
            return cell

        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewItemCelliPad", forIndexPath: indexPath) as! CollectionViewItemCell
            
            cell.itemImage.image = UIImage(named: itemImage[indexPath.row])
            cell.itemName.text = itemTitle[indexPath.row]
            cell.itemDetail.text = itemDetail[indexPath.row]
            
            //cell.setGalleryItem(galleryItems[indexPath.row])
            return cell

            
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /*func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
    let commentView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GalleryItemCommentView", forIndexPath: indexPath) as! GalleryItemCommentView
    
    commentView.commentLabel.text = "Supplementary view of kind \(kind)"
    
    return commentView
    }*/
    
    // MARK: -
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        /* let alert = UIAlertController(title: "didSelectItemAtIndexPath:", message: "Indexpath = \(indexPath)    \(galleryItems.count)", preferredStyle: .Alert)
        
        let alertAction = UIAlertAction(title: "Dismiss", style: .Destructive, handler: nil)
        alert.addAction(alertAction)
        
        self.presentViewController(alert, animated: true, completion: nil)*/
    }
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //  cellSize = cellSize + 10.0;
        
        // let picDimension = self.view.frame.size.width / 4.0
        // var picDimension = 150
        // var width = picDimension + CGFloat(cellSize)
        //return CGSizeMake(picDimension, picDimension)
        if(screenWidth > 700) {
            return CGSizeMake(180, 180)
        }
        
        
        return CGSizeMake(110, 110)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
       // let leftRightInset = self.view.frame.size.width / 14.0
        return UIEdgeInsetsMake(0, 10, 0, 10)
        // return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
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
