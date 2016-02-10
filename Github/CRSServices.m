//
//  CRSServices.m
//  CRS
//
//  Created by Amr Abdelmonsef on 2/11/14.
//  Copyright (c) 2014 Compulink. All rights reserved.
//

#import "CRSServices.h"
#import "UAGithubEngine/UAGithubEngine.h"

@implementation CRSServices

-(NSString*) getServiceURL
{
    UAGithubEngine * engine = [[UAGithubEngine alloc] initWithUsername: @"fadlool" password:@"Anter_Fcis@yahoo.com" withReachability:YES];
    
    [engine repositoriesWithSuccess:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
    
    return @"";
}

@end

