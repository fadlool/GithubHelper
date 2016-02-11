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
        return Common.BASE_URL
    }
    


    
  
    
    
    
    func getRepos(programmingLanguage:String,getReposSuccess:((NSMutableArray?) ->()),getReposFailure:(( NSError?,NSString?) ->()) ){
        
        var url:String  = "\(self.serviceBaseURL())search/repositories?q=\(programmingLanguage)+language"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let manager:AFHTTPRequestOperationManager = self.getOpManager()
        
        manager.GET(url, parameters: [:], success: { (operation, responseObject) -> Void in
            
            let arr:NSArray = (responseObject as! NSDictionary).objectForKey("items") as! NSArray
            
            let reposArr:NSMutableArray = (Helper.getReposArr(arr as [AnyObject]))!
            getReposSuccess(reposArr)
            
            }) { (operation, error) -> Void in
                
                getReposFailure(error, nil)
        }
    }
    
    
    func getOpManager()->AFHTTPRequestOperationManager{
        
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestSerializer:AFJSONRequestSerializer  = AFJSONRequestSerializer()
        requestSerializer.setValue("application/json" ,forHTTPHeaderField:"Accept")
        requestSerializer.setValue("application/json; charset=UTF-8" ,forHTTPHeaderField:"Content-Type")
        manager.requestSerializer = requestSerializer;
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager;
        
    }

    
}
