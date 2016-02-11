//
//  Common.swift
//  CRS
//
//  Created by Mohamed Fadl on 12/23/14.
//  Copyright (c) 2014 Compulink. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

public class Common: NSObject {
    
    public static let GITHUB_CLIENT_ID = "25b74fe446a0e0d779bc";
    public static let GITHUB_CLIENT_SECRET = "49597f3412c6b1f3fa7dc98b64bbd46df7896cf8";
    
    
    public static let EMBED_SEGUE_IDENTIFIER = "embed_list"
    public static let SHOWREPOS_SEGUE_IDENTIFIER = "show_repos"
    public static let BASE_URL:String = "https://api.github.com/"

//    public class func changeLanguage(){
//        // use whatever language/locale id you want to override
////        let language = SessionManager.sharedSessionManager().sessionInfo.language
//        let language = 1
//        if (language ==  Language.Arabic.rawValue){
//            NSUserDefaults.standardUserDefaults().setObject(["ar_SA"], forKey:"AppleLanguages")
//        }else{
//            NSUserDefaults.standardUserDefaults().setObject(["en_US"], forKey:"AppleLanguages")
//        }
//        
//        NSUserDefaults.standardUserDefaults().setObject(String(language), forKey: UserLanguage);
//        NSUserDefaults.standardUserDefaults().synchronize();
//        
//    }
//    public class func getDateString(cal: NSDate, isHijri:Bool)->NSString {
//        
//        var dateString = ""
//        
//        let dateFormat = DATE_FORMAT_2
//        
//        // Set up components of a Gregorian date
//        let  gregorianComponents:NSDateComponents = NSCalendar.currentCalendar().components( [NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: cal)
//        
//        if (isHijri && dateFormat.isEqual(DATE_FORMAT_1)) {
//            let hijriCalendar: NSCalendar?
//            // Then create an Islamic calendar
//            if #available(iOS 8.0, *) {
//               hijriCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicUmmAlQura)
//            } else {
//                // Fallback on earlier versions
//                hijriCalendar = NSCalendar(calendarIdentifier: NSIslamicCalendar)
//                
//            }
//            
//            // And grab those date components for the same date
//            let hijriComponents: NSDateComponents  = hijriCalendar!.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: cal)
//            
//            
//            dateString = "\(hijriComponents.day) \(hijriComponents.month) \(hijriComponents.year)"
//            
//            
//        } else if (isHijri && dateFormat.isEqual(DATE_FORMAT_2)) {
//             let hijriCalendar: NSCalendar?
//            // Then create an Islamic calendar
//            if #available(iOS 8.0, *) {
//                 hijriCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamicUmmAlQura)
//            } else {
//                // Fallback on earlier versions
//                hijriCalendar = NSCalendar(calendarIdentifier: NSIslamicCalendar)
//                
//            }
//            
//            // And grab those date components for the same date
//            let hijriComponents: NSDateComponents  = hijriCalendar!.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: cal)
//            
//            var monthStr = ""
//            var dayStr = ""
//            
//            if(hijriComponents.month < 10){
//                monthStr = "0\(hijriComponents.month)"
//            }else{
//                monthStr = String(hijriComponents.month)
//            }
//            
//            if(hijriComponents.day < 10){
//                dayStr = "0\(hijriComponents.day)"
//            }else{
//                dayStr = String(hijriComponents.day)
//            }
//            
//             dateString = "\(dayStr)/\(monthStr)/\(hijriComponents.year)"
//            
//        } else if (!isHijri && dateFormat.isEqual(DATE_FORMAT_1)) {
//            dateString = "\(gregorianComponents.day) \(gregorianComponents.month) \(gregorianComponents.year)"
//            
//        } else if (!isHijri  && dateFormat.isEqual(DATE_FORMAT_2)) {
//            var monthStr = ""
//            var dayStr = ""
//            
//            if(gregorianComponents.month < 10){
//                monthStr = "0\(gregorianComponents.month)"
//            }else{
//                monthStr = String(gregorianComponents.month)
//            }
//            if(gregorianComponents.day < 10){
//                dayStr = "0\(gregorianComponents.day)"
//            }else{
//                dayStr = String(gregorianComponents.day)
//            }
//                        
//            dateString = "\(gregorianComponents.year)/"+monthStr+"/"+dayStr
//            
//        }
//        
//        return dateString;
//        
//    }
    
    
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