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
    
    public static let PageSize = 10
    
    public static let SHOW_ITME_SEGUE_IDENTIFIER = "show_item"
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
    
    class func showErrorMsg(message:NSString?, error:NSError?, viewCtrl:UIViewController){
        var alertMessage:NSString?
        if(message != nil ){
            alertMessage = message
            NSLog("message: %@", message!)
            
        }else{
            alertMessage =  error!.localizedDescription
            
        }
        
        alertMessage = (message != nil ? (message)! as String : error!.localizedDescription)
        if (String( alertMessage) != nil) {
            let alert = UIAlertController(title: nil, message: alertMessage as! String , preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok_dialog".localized, style: UIAlertActionStyle.Default, handler: nil))
            viewCtrl.presentViewController(alert, animated: true, completion: nil)
            
            
        }
    }
    
}