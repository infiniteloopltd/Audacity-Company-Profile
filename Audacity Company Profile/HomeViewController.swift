//
//  ViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UIPageViewControllerDataSource{

    private let contentImages = ["img_home_1.jpg",
        "img_home_2.jpg",
        "img_home_3.jpg","img_home_4.jpg","img_home_5.jpg"]
    
    private let projectName = ["Amar Phonebook",
        "Colours FM",
        "Monasa Learning Centre","Lock Deal","How I Work"]
    
    private let projectType = [["Android","iOS"],["Android"],["Website"],["Website","Android"],["Website","Android","iOS"]]
    
    var appDelegate:AppDelegate!
    
    private var pageViewController: UIPageViewController?
    @IBOutlet var container: UIView!
    
    
    @IBOutlet var actionBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createPageViewController()
        setupPageControl()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
        container.hidden = true;
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

}

