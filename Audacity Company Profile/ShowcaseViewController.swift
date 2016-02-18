//
//  ShowcaseViewController.swift
//  Audacity Company Profile
//
//  Created by Sourav AITS on 1/18/16.
//  Copyright © 2016 Audacity IT Solutions. All rights reserved.
//

import UIKit

class ShowcaseViewController: UIViewController {

    
    @IBOutlet var firstCategory: MyCustomButton!
    
    @IBOutlet var secondCategory: MyCustomButton!
    
    @IBOutlet var thirdCategory: MyCustomButton!
    
    
    @IBOutlet var fourthCategory: MyCustomButton!
    
    @IBOutlet var contentImageView: UIImageView!
    
    @IBOutlet var projectName: UILabel!
    
    
    
    var projectType: [String]! ;
    var projectUrl: [String]! ;
    var itemIndex: Int = 0
   
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    
    var nameOfProject: String = "" {
        
        didSet {
            
            if let label = projectName {
                label.text = nameOfProject
            }
            
        }
    }
    
    
    @IBAction func firstCategoryAction(sender: AnyObject) {
        
        if( !firstCategory.hidden ) {

            let url = NSURL(string: projectUrl[0])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    
    @IBAction func secondCategoryAction(sender: AnyObject) {
        
        if( !secondCategory.hidden ) {
            
            let url = NSURL(string: projectUrl[1])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    
    @IBAction func thirdCategoryAction(sender: AnyObject) {
        
        if( !thirdCategory.hidden ) {
            
            let url = NSURL(string: projectUrl[2])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    
    
    @IBAction func fourthCategoryAction(sender: AnyObject) {
        
        if( !fourthCategory.hidden ) {
            
            let url = NSURL(string: projectUrl[3])!
            UIApplication.sharedApplication().openURL(url)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contentImageView!.image = UIImage(named: imageName)
        projectName!.text = nameOfProject
        
        firstCategory.hidden = true
        secondCategory.hidden =  true
        thirdCategory.hidden = true
        fourthCategory.hidden = true
        setButtonText();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func setButtonText () {
        let itemCount = projectType.count
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

}
