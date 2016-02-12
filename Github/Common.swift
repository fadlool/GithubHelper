//
//  Common.swift
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright (c) 2016 Microapps. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

public class Common: NSObject {
    
    public static let PAGE_SIZE = 10
    public static let EMBED_SEGUE_IDENTIFIER = "embed_list"
    public static let SHOWREPOS_SEGUE_IDENTIFIER = "show_repos"
    public static let BASE_URL:String = "https://api.github.com/"
    
    class func showDialog(viewController:UIViewController, title:String , message:String,actions : String..., positiveAction: () -> Void, negativeAction: () -> Void){
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        var alertAction:UIAlertAction?
        for action in actions{
            if(action == "yes_dialog".localized || action == "ok_dialog".localized){
                alertAction = UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: {(errorAlert) -> Void in
                    positiveAction()
                    
                })
            }
            
            if(action == "cancel_dialog".localized || action == "no_dialog".localized){
                alertAction = UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: {(errorAlert) -> Void in
                    negativeAction()
                    
                })
            }
            
            
            errorAlert.addAction(alertAction!)
        }
        
        viewController.presentViewController(errorAlert, animated: true, completion: nil)
    }

    class func imageWithImage(image:UIImage, newSize:CGSize) -> UIImage {
        //UIGraphicsBeginImageContext(newSize);
        // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
        // Pass 1.0 to force exact pixel size.
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage  = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}