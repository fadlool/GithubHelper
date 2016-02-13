//
//  Committer.h
//  Github
//
//  Created by Mohamed Fadl Allah on 2/13/16.
//  Copyright © 2016 microapps. All rights reserved.
//
#import "JSONModel.h"

@interface Contributer:JSONModel

@property (strong, nonatomic) NSString* login;
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString*  avatar_url;
@property (strong, nonatomic) NSString* gravatar_id;
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* html_url;
@property (strong, nonatomic) NSString* followers_url;
@property (strong, nonatomic) NSString* following_url;
@property (strong, nonatomic) NSString* gists_url;
@property (strong, nonatomic) NSString* starred_url;
@property (strong, nonatomic) NSString* subscriptions_url;
@property (strong, nonatomic) NSString* organizations_url;
@property (strong, nonatomic) NSString* repos_url;
@property (strong, nonatomic) NSString* events_url;
@property (strong, nonatomic) NSString* received_events_url;
@property (strong, nonatomic) NSString* type;
@property (assign, nonatomic) bool site_admin;
@property (assign, nonatomic) int contributions;


@end
