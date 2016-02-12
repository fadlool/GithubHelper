//
//  LoginViewController.swift
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2015 microapps. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var languageTxtField: UITextField!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var loginBottomConstraint: NSLayoutConstraint!
    var loginBottomConstraintValue:CGFloat = 0
    
    var internetReachable:Reachability?
    var hostReachable:Reachability?
    
    var kbShown:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let orientation:UIDeviceOrientation = UIDevice.currentDevice().orientation
        if(orientation == UIDeviceOrientation.Portrait || orientation == UIDeviceOrientation.Unknown){
            self.logoImgView.hidden = false
            self.logoLabel.hidden = false
            //            if(self.kbShown)
            
        }else{
            self.logoImgView.hidden = true
            self.logoLabel.hidden = true
        }
        
        self.languageTxtField.leftViewMode = UITextFieldViewMode.Always;
        self.languageTxtField.textAlignment = NSTextAlignment.Left
            
        self.languageTxtField.delegate = self;
        
        // save default value to restore onkeyboardHide
        self.loginBottomConstraintValue = self.loginBottomConstraint.constant
        
        self.awakeFromNib()
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if(toInterfaceOrientation == UIInterfaceOrientation.Portrait ){
            self.logoImgView.hidden = false
            self.logoLabel.hidden = false
            
        }else{
            self.logoImgView.hidden = true
            self.logoLabel.hidden = true
        }
    }
    
    
    func checkNetworkStatus(notice: NSNotification){
        // called after network status changes
        let internetStatus:NetworkStatus = (self.internetReachable?.currentReachabilityStatus())!
        switch internetStatus{
        case NotReachable:
//                NSLog("The internet is down.");
//                self.internetActive = NO;
                let alertView:UIAlertView  = UIAlertView(title: nil, message: "internet_error".localized, delegate: nil, cancelButtonTitle: "ok_dialog".localized )
                alertView.show()
                break
            
        case ReachableViaWiFi:
                NSLog("The internet is working via WIFI.");
//                self.internetActive = YES;
                break
        case ReachableViaWWAN:
                NSLog("The internet is working via WWAN.");
//                self.internetActive = YES;
                break
        default:
            break

            
        }
    
    }
    @IBAction func getReposBtnTapped(sender: AnyObject) {
        self.getRepos()
       
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.returnKeyType == UIReturnKeyType.Done){
            self.getRepos()
            
        }
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == Common.SHOWREPOS_SEGUE_IDENTIFIER){
            
            let naviCtrlr:UINavigationController = segue.destinationViewController as! UINavigationController
            let rootViewController = naviCtrlr.viewControllers.first
            
            let mainViewController:MainViewController = rootViewController as! MainViewController
            
            mainViewController.progLanguage = self.languageTxtField.text!
        
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
       
        self.observeKeyboard()
        

        // check for internet connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkNetworkStatus:", name: kReachabilityChangedNotification, object:nil)

        self.internetReachable = Reachability.reachabilityForInternetConnection()
        self.internetReachable!.startNotifier()
        
        
    }

    
    func observeKeyboard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }

    func keyboardWillShow(notification:NSNotification){
        self.kbShown = true
        UIView.beginAnimations(nil, context:nil)
        UIView.setAnimationDuration(0.3)
        UIView.commitAnimations()
        
        let  info:NSDictionary = notification.userInfo!
        
        var kbRect:CGRect  = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue)!
        kbRect = self.view.convertRect(kbRect, fromView: nil)
        NSLog("Updating constraints.")
        
        self.loginBottomConstraint.constant =  kbRect.height
        
        let animationDuration:NSTimeInterval = info.objectForKey(UIKeyboardAnimationDurationUserInfoKey)!.doubleValue
        UIView.animateWithDuration(animationDuration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        self.kbShown = false
        UIView.beginAnimations(nil, context:nil)
        UIView.setAnimationDuration(0.3)
        UIView.commitAnimations()
        
        let  info:NSDictionary = notification.userInfo!
        
        var kbRect:CGRect  = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue)!
        kbRect = self.view.convertRect(kbRect, fromView: nil)
        NSLog("Updating constraints.")
        
        self.loginBottomConstraint.constant =  self.loginBottomConstraintValue
        
        let animationDuration:NSTimeInterval = info.objectForKey(UIKeyboardAnimationDurationUserInfoKey)!.doubleValue
        UIView.animateWithDuration(animationDuration) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch:UITouch  = (event?.allTouches()?.first)!
        if (self.languageTxtField.isFirstResponder() && touch.view != self.languageTxtField) {
            self.languageTxtField.resignFirstResponder()
        }
       
        super.touchesBegan(touches, withEvent: event)
    }
    
    func getRepos(){
        if (self.languageTxtField.isFirstResponder()) {
            self.languageTxtField.resignFirstResponder()
        }
        
        let services:Services = Services()
        
        if(self.languageTxtField.text! == ""){
            
            let alertView:UIAlertView  = UIAlertView(title: nil, message: "lang_empty".localized, delegate: nil, cancelButtonTitle: "ok_dialog".localized )
            alertView.show()
            return
        }
        
        self.performSegueWithIdentifier("show_repos", sender: self)
        
            
            
        }
 
    
    
    override func viewDidDisappear(animated: Bool) {
        self.languageTxtField.text = ""
    }
}

