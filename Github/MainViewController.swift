//
//  MainViewController.swift
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2016 microapps. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    var progLanguage:String?
    
    override func viewDidLoad() {
        
        let  backBarBtnItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: UIBarButtonItemStyle.Plain, target: self, action: "backTapped")
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.15, green: 0.50, blue: 0.78, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        self.topNavigationItem.leftBarButtonItem = backBarBtnItem
    }
    
    func backTapped(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == Common.EMBED_SEGUE_IDENTIFIER){
            
            let reposTableController:ReposTableViewController = segue.destinationViewController as! ReposTableViewController
            
            reposTableController.mainViewController = self
            
        
        }
    }
}
