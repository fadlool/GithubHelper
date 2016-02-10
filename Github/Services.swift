//
//  Services.swift
//  DMS
//
//  Created by Mohamed Fadl on 12/7/15.
//  Copyright © 2015 Compulink. All rights reserved.
//

import Foundation

class Services: NSObject {
    
    func serviceBaseURL() -> String
    {
        return Common.BASE_URL_EXTERNAL
    }
    


    
  
    
    
    
    func getRepos(programmingLanguage:String,getReposSuccess:(() ->()),getReposFailure:(( NSError?,NSString?) ->()) ){
        
//        let parameter: NSDictionary  = [Common.TAG_USER_NAME:userName, Common.TAG_PASSWORD:password, Common.TAG_LANGUAGE: LangChar.Arabic.rawValue]
//        
//        let parameterString:NSString = Helper.getStringFromJSONDictObj(parameter)
//        
//        let criteria:NSDictionary = [Common.TAG_MODULE_ID: 2,
//            Common.TAG_COMMAND: Common.ServiceLogin,
//            Common.TAG_PARAMETER: parameterString]
        
        let parameters:NSDictionary = ["asdas" :  ""]
        
        let manager:AFHTTPRequestOperationManager = self.getOpManager()
        
        manager.POST(self.processRequestServiceURL(), parameters: parameters as [NSObject : AnyObject], success: { (operation, responseObject) -> Void in
            
//            let resultContainerDict:NSDictionary = self.getResult(responseObject as! NSMutableDictionary) as! NSDictionary
            
//            if (self.isSuccess(responseObject)) {
//                self.parseLoginData(resultContainerDict)
//                
//                self.getPreferencesForUser({ () -> () in
//                    getReposSuccess()
//                    
//                    }, getPreferencesFailure: { (error, msg) -> () in
//                        getReposFailure(error, msg)
//                        
//                })
//            }else{
//                let serverMessage:NSString = self.parseExceptionResponse(resultContainerDict)
//                getReposFailure(nil, serverMessage)
//                
//            }
            }) { (operation, error) -> Void in
                
                getReposFailure(error, nil)
        }
    }
    
   
    
//    func parseLoginData(loginResult:NSDictionary){
//        
//        let sessionManager:SessionManager = SessionManager.sharedSessionManager()
//        
//        let loginInfo:LoginInfo = LoginInfo()
//        
//        loginInfo.sessionid = loginResult.valueForKey(Common.TAG_SESSION_ID) as! String
//        loginInfo.arabicFullName = loginResult.valueForKey(Common.TAG_ARABIC_FULL_NAME) as! String
//        loginInfo.englishFullName = loginResult.valueForKey(Common.TAG_ENGLISH_FULL_NAME) as! String
//        loginInfo.isAdministrator = loginResult.valueForKey(Common.TAG_IS_ADMINISTRATOR) as! Bool
//        loginInfo.lastaccesstime = loginResult.valueForKey(Common.TAG_LAST_ACCESS_TIME) as! String
//        loginInfo.lcid = loginResult.objectForKey(Common.TAG_LCID) as! NSInteger
//        loginInfo.loginName = loginResult.valueForKey(Common.TAG_LOGIN_NAME) as! String
//        loginInfo.logintime = loginResult.valueForKey(Common.TAG_LOGIN_TIME) as! String
//        loginInfo.machineName = loginResult.valueForKey(Common.TAG_MACHINE_NAME) as! String
//        loginInfo.modified = loginResult.valueForKey(Common.TAG_MODIFIED) as! Bool
//        loginInfo.server = loginResult.valueForKey(Common.TAG_SERVER) as! String
//        loginInfo.sessionTime = loginResult.valueForKey(Common.TAG_SESSION_TIME) as! NSInteger
//        loginInfo.token = loginResult.valueForKey(Common.TAG_TOKEN) as! String
//        loginInfo.userFullName = loginResult.valueForKey(Common.TAG_USER_FULLNAME) as! String
//        loginInfo.userid = loginResult.valueForKey(Common.TAG_USER_ID) as! NSInteger
//        
//        sessionManager.loginInfo = loginInfo
//    }
    
    
//    func isSuccess(json:AnyObject)->Bool{
//        
//        let responseDict:NSMutableDictionary =  json as! NSMutableDictionary
//        let processReqDict:NSMutableDictionary = responseDict.objectForKey(Common.TAG_PROCESSREQ_RESULT) as! NSMutableDictionary
//        
//        let result = processReqDict.objectForKey(Common.TAG_IS_SUCCESS)?.boolValue
//        return result!
//    }
    
//    func parseExceptionResponse(json:AnyObject)->NSString{
//        
//        let responseDict:NSDictionary = json as! NSDictionary
//        let message:NSString = responseDict.valueForKey(Common.TAG_MESSAGE) as! NSString
//        
//        let errorType:NSString = responseDict.objectForKey(Common.TAG_ERROR_TYPE) as! NSString
//        
//        if (errorType.isEqualToString(Common.ERROR_TYPE)) {
//            return errorType;
//        }
//        
//        return message
//    }
    
   
    
//    func prepareRequestWithMethod(methodName:NSString ,parameterDict:NSMutableDictionary)->NSDictionary{
//        let clientContextJsonDict:NSDictionary = getClientContextJsonObject()
//        
//        parameterDict.setObject(clientContextJsonDict, forKey: Common.TAG_CLIENT_CONTEXT)
//        let parameterString = Helper.getStringFromJSONDictObj(parameterDict)
//        
//        let criteria = [Common.TAG_MODULE_ID: 2, Common.TAG_COMMAND: methodName, Common.TAG_PARAMETER:  parameterString]
//        
//        let parameters:NSDictionary  = [Common.TAG_CRITERIA : criteria]
//        return parameters
//    }
//    
    
    func getOpManager()->AFHTTPRequestOperationManager{
        
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer:AFJSONRequestSerializer  = AFJSONRequestSerializer()
        requestSerializer.setValue("application/json" ,forHTTPHeaderField:"Accept")
        requestSerializer.setValue("application/json; charset=UTF-8" ,forHTTPHeaderField:"Content-Type")
        manager.requestSerializer = requestSerializer;
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager;
        
    }
    
    func processRequestServiceURL() ->String
    {
//        var url:String  = String(format: "%@%@", arguments: [self.serviceBaseURL(), Common.SVC_URL])
//        NSLog("processRequest URL first is: %@", url);
//        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        return url;
        
         return "";
    }
    
}
