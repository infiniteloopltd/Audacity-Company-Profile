//
//  ClientItemCell.swift
//  CompanyProfileNavigationDrawer
//
//  Created by Sourav AITS on 1/14/16.
//  Copyright (c) 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class ClientItemCell: UITableViewCell {

    @IBOutlet var clientImage: UIImageView!
    
    @IBOutlet var clientProjectName: UILabel!
    
    
    @IBOutlet var clientName: UILabel!
    
    
    @IBOutlet var clientCountry: UILabel!
    
    @IBOutlet var projectTypeView: UIView!
    
    var observerAdded:Bool = false
    
    class var expandedHeight: CGFloat { get { return 143} }
    
    class var defaultHeight: CGFloat {get {return 100} }
    
    func checkHeight () {
        projectTypeView.hidden = ( frame.size.height < ClientItemCell.expandedHeight)
        
        
    }
  var frameAdded = false
    
    var link: [String]! ;
    var projectType: [String]! ;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBOutlet var firstCategory: MyCustomButton2!
    
    @IBOutlet var secondCategory: MyCustomButton2!
    
    @IBOutlet var thirdCategory: MyCustomButton2!
    
    
    @IBOutlet var fourthCategory: MyCustomButton2!
    
    @IBOutlet var arrowImageView: UIButton!
    
    
    
    @IBAction func firstCategoryAction(sender: AnyObject) {
        
        if( !firstCategory.hidden ) {
            
            /* let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "You will be redirect tomorrow", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)*/
            
            
            
            let url = NSURL(string: link[0])!
            UIApplication.sharedApplication().openURL(url)
        }
        
    }
    
    
    @IBAction func secondCategoryAction(sender: AnyObject) {
        
        if( !secondCategory.hidden ) {
            /*  let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "You will be redirect tomorrow", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            */
            let url = NSURL(string: link[1])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    
    @IBAction func thirdCategoryAction(sender: AnyObject) {
        
        if( !thirdCategory.hidden ) {
            /*          let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "You will be redirect tomorrow", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            */
            
            let url = NSURL(string: link[2])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    
    
    @IBAction func fourthCategoryAction(sender: AnyObject) {
        
        if( !fourthCategory.hidden ) {
            /*          let alertController = UIAlertController(title: "Audacity IT Solution", message:
            "You will be redirect tomorrow", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            */
            
            let url = NSURL(string: link[3])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    func setButtonText () {
        let itemCount = projectType.count
        
        firstCategory.hidden = true
        secondCategory.hidden = true
        thirdCategory.hidden = true
        fourthCategory.hidden = true
        
        var i:Int = 0
        for ( i = 0; i < itemCount; i++ ) {
            
            switch (i) {
            case 0:
                firstCategory.setTitle(projectType[i], forState: .Normal)
                firstCategory.hidden = false
                break
                
            case 1:
                secondCategory.setTitle(projectType[i], forState: .Normal)
                secondCategory.hidden = false
                break
                
            case 2:
                thirdCategory.setTitle(projectType[i], forState: .Normal)
                thirdCategory.hidden = false
                break
            case 3:
                fourthCategory.setTitle(projectType[i], forState: .Normal)
                fourthCategory.hidden = false
                break
            default:
                break;
            }
            
        }
    }
    
  /*  func watchFrameChanges() {
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
     //   addObserver(self, forKeyPath: "frame", options: .New, context: nil)
      
      //  checkHeight()
    }
    
    func ignoreFrameChanges() {
        
     //   removeObserver(self, forKeyPath: "frame")
    
        
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
        
        
    }

*/
    
    func watchFrameChanges() {
        if(!frameAdded){
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            frameAdded = true
        }
    }
    
    func ignoreFrameChanges() {
        if(frameAdded){
            removeObserver(self, forKeyPath: "frame")
            frameAdded = false
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    deinit {
        
        ignoreFrameChanges()
    }
    
}
    
    
    
//}
