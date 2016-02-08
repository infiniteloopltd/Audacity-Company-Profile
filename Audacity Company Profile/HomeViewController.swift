//
//  ViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController , UIPageViewControllerDataSource{

    /*private var contentImages = ["img_home_1.jpg",
        "img_home_2.jpg",
        "img_home_3.jpg","img_home_4.jpg","img_home_5.jpg"]*/
    /*private var contentImages:[String]!
    private var projectName : [String]!
    */
   /* private var projectName = ["Amar Phonebook",
        "Colours FM",
        "Monasa Learning Centre","Lock Deal","How I Work"]*/
    
    //private var projectType = [["Android","iOS"],["Android"],["Website"],["Website","Android"],["Website","Android","iOS"]]
    
    private var projectName = [String]()
    private var contentImages = [String]()
    private var projectType = [[String]]()
     private var projectUrl = [[String]]()
    
    var appDelegate:AppDelegate!
    
    private var pageViewController: UIPageViewController?
    @IBOutlet var container: UIView!
    
    
    @IBOutlet var actionBar: UIView!
    
    @IBAction func drawerToggleAction(sender: AnyObject) {
        
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        createPageViewController()
        setupPageControl()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if(Reachability.isConnectedToNetwork()) {
            print("Connected to internet")
        } else {
            print("Not Connected")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("ShowcaseController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers((startingViewControllers as [AnyObject] as NSArray as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        // self.view.addSubview(pageViewController!.view)
        //pageViewController!.view.frame.size.width = container.frame.size.width
        
        pageViewController!.view.frame.size.height = pageViewController!.view.frame.size.height - actionBar.frame.size.height
        //pageViewController!.view.frame.size.height = container.frame.size.height
      //  container.addSubview(pageViewController!.view)
        pageViewController!.view.frame.origin.y = pageViewController!.view.frame.origin.y + actionBar.frame.size.height
        
         self.view.addSubview(pageViewController!.view)
        //container.hidden = true;
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ShowcaseViewController
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! ShowcaseViewController
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> ShowcaseViewController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ShowcaseViewController") as! ShowcaseViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            pageItemController.nameOfProject = projectName[itemIndex]
            pageItemController.projectType = projectType[itemIndex]
            pageItemController.projectUrl = projectUrl[itemIndex]
            //pageItemController.setButtonText()
            return pageItemController
        }
        
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewDidAppear(animated)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func loadData() {
       
        
        if let path = NSBundle.mainBundle().pathForResource("home", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                   
                    for ( var i:Int = 0; i<jsonObj["projects"].count; i++ ) {
                        projectName.append(jsonObj["projects"][i]["name"].string!)
                        contentImages.append(jsonObj["projects"][i]["image"].string!)
                        var temp = [String]()
                        var tempUrl = [String]()
                        for( var j:Int = 0; j<jsonObj["projects"][i]["project_info"].count; j++) {
                            temp.append(jsonObj["projects"][i]["project_info"][j]["platform"].string!)
                            tempUrl.append(jsonObj["projects"][i]["project_info"][j]["url"].string!)
                        }
                       
                        projectType.append(temp)
                        projectUrl.append(tempUrl)
                        
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

