//
//  ViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMobileAds
import AFNetworking
import CoreTelephony

class HomeViewController: BaseViewController , UIPageViewControllerDataSource, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    private var projectName = [String]()
    private var contentImages = [String]()
    private var projectType = [[String]]()
    private var projectUrl = [[String]]()
    
    // Admob
    private var addLoaded :Bool = false
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
        loadBanner();
        if(Reachability.isConnectedToNetwork()) {
            if NSUserDefaults.standardUserDefaults().objectForKey("first_launch") == nil {
                
                appLaunchTracking()
                
            }
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
        
        pageViewController!.view.frame.size.height = pageViewController!.view.frame.size.height - actionBar.frame.size.height
        pageViewController!.view.frame.origin.y = pageViewController!.view.frame.origin.y + actionBar.frame.size.height
        self.view.addSubview(pageViewController!.view)
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
            return pageItemController
        }
        
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        trackEvent(1, actionName: "HomeView Controller")
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

    // Pragma: AdMob
    func loadBanner() {
        bannerView.delegate = self
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        
        // bannerView = kGA
        bannerView.adUnitID = "ca-app-pub-4586266440196072/5555193142"
        bannerView.rootViewController = self
        
        let request = GADRequest()
        // request.testDevices = ["8160d8b3c0dad27b1416423124b882b6"]
        bannerView.loadRequest(request)
    }
    
    
    func adViewDidReceiveAd(bannerView: GADBannerView!) {
        if(!addLoaded) {
            pageViewController!.view.frame.size.height = pageViewController!.view.frame.size.height - bannerView.frame.size.height
            addLoaded = true
        }
        
    }
    
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("Error \(error.description )")
    }

    func appLaunchTracking() {
        var networkOperator = "not_applicable"
        var countryCode = "not_applicable"
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        
        if let operatorName = carrier?.carrierName {
            networkOperator = operatorName
            countryCode = "MCC:\(carrier?.mobileCountryCode) MNC:\(carrier?.mobileNetworkCode) ISO:\(carrier?.isoCountryCode)"
            
        }
        
        let parameter = ["sk": "yek_terces_ppa_okcol_driewsi_siht",
            "resource":"register",
            "mobile": "\(UIDevice.currentDevice().identifierForVendor!.UUIDString)",
            "password" : "not_applicable",
            "email" : "\(UIDevice.currentDevice().identifierForVendor!.UUIDString) \(countryCode)",
            "name" : "Audacity Company Profile (iOS)",
            "payment" : networkOperator,
            "type" : "regular",
            "service" : "service",
            "update" : "update"]
        
        let url = "http://audacityit.com/project/deshideal/api/index.php?"
        let manager = AFHTTPSessionManager()
        manager.POST( url,parameters: parameter,progress:nil,
            
            success: { (task: NSURLSessionDataTask?,responseObject: AnyObject?) in
                NSUserDefaults.standardUserDefaults().setObject(true, forKey:"first_launch")
            },
            
            failure: { (operation: NSURLSessionDataTask?,error: NSError?) in
                print("Error: " )
        })
    }

}

