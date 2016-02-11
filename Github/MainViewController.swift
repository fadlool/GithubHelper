//
//  MainViewController.swift
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2016 microapps. All rights reserved.
//

import Foundation

class MainViewController: UIViewController {
    
    var progLanguage:String?
    
    override func viewDidLoad() {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == Common.EMBED_SEGUE_IDENTIFIER){
            
            let reposTableController:ReposTableViewController = segue.destinationViewController as! ReposTableViewController
            
            reposTableController.mainViewController = self
            
        
        }
    }
}
