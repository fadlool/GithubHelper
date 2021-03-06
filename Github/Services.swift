//
//  Services.swift
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2015 Microapps. All rights reserved.
//

import Foundation

class Services: NSObject {
    
    func serviceBaseURL() -> String
    {
        return Common.BASE_URL
    }
    
    func getCommitters(repoName:String, ownerName:String, getCommittersSuccess:((NSMutableArray?) ->()),getCommittersFailure:(( NSError?,NSString?) ->()) ){
        
        var url:String  = "\(self.serviceBaseURL())repos/\(ownerName)/\(repoName)/contributors"
        
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let manager:AFHTTPRequestOperationManager = self.getOpManager()
        
        manager.GET(url, parameters: [:], success: { (operation, responseObject) -> Void in
            
            let arr:NSArray = responseObject as! NSArray
            
            let reposArr:NSMutableArray = (Helper.getCommittersArr(arr as [AnyObject]))!
                getCommittersSuccess(reposArr)
            
            }) { (operation, error) -> Void in
                getCommittersFailure(error, nil)
        }
        
        
    }
    
    func getIssues(repoName:String, getIssuesSuccess:((NSMutableArray?) ->()),getIssuesFailure:(( NSError?,NSString?) ->()) ){
        
        var url:String  = "\(self.serviceBaseURL())search/issues?q=repo:\(repoName)+state:open"
        
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let manager:AFHTTPRequestOperationManager = self.getOpManager()
        
        manager.GET(url, parameters: [:], success: { (operation, responseObject) -> Void in
            
            let arr:NSArray = (responseObject as! NSDictionary).objectForKey("items") as! NSArray
            
            let reposArr:NSMutableArray = (Helper.getIssuesArr(arr as [AnyObject]))!
            getIssuesSuccess(reposArr)
            
            }) { (operation, error) -> Void in
                
                getIssuesFailure(error, nil)
        }
        
        
    }
    func getRepos(programmingLanguage:String,pageNo:Int,getReposSuccess:((NSMutableArray?) ->()),getReposFailure:(( NSError?,NSString?) ->()) ){
        
        var url:String  = "\(self.serviceBaseURL())search/repositories?q=language:\(programmingLanguage)&page=\(pageNo)&per_page=\(Common.PageSize)"
        
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
