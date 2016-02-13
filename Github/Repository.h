//
//  Repository.h
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2016 microapps. All rights reserved.
//
#import "JSONModel.h"
#import "Owner.h"

@interface Repository : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* full_name;
@property (strong, nonatomic) Owner* owner;
@property (strong, nonatomic) NSString*  html_url;
@property (assign, nonatomic) bool  fork;
@property (strong, nonatomic) NSString*  url;
@property (strong, nonatomic) NSString*  forks_url;
@property (strong, nonatomic) NSString*  keys_url;
@property (strong, nonatomic) NSString*  collaborators_url;
@property (strong, nonatomic) NSString*  teams_url;
@property (strong, nonatomic) NSString*  hooks_url;
@property (strong, nonatomic) NSString*  issue_events_url;
@property (strong, nonatomic) NSString*  events_url;
@property (strong, nonatomic) NSString*  assignees_url;
@property (strong, nonatomic) NSString*  branches_url;
@property (strong, nonatomic) NSString*  tags_url;
@property (strong, nonatomic) NSString*  blobs_url;
@property (strong, nonatomic) NSString*  git_tags_url;
@property (strong, nonatomic) NSString*  git_refs_url;
@property (strong, nonatomic) NSString*  trees_url;
@property (strong, nonatomic) NSString*  statuses_url;
@property (strong, nonatomic) NSString*  languages_url;
@property (strong, nonatomic) NSString*  stargazers_url;
@property (strong, nonatomic) NSString*  contributors_url;
@property (strong, nonatomic) NSString*  subscribers_url;
@property (strong, nonatomic) NSString*  subscription_url;
@property (strong, nonatomic) NSString*  commits_url;
@property (strong, nonatomic) NSString*  git_commits_url;
@property (strong, nonatomic) NSString*  comments_url;
@property (strong, nonatomic) NSString*  issue_comment_url;
@property (strong, nonatomic) NSString*  contents_url;
@property (strong, nonatomic) NSString*  compare_url;
@property (strong, nonatomic) NSString*  merges_url;
@property (strong, nonatomic) NSString*  archive_url;
@property (strong, nonatomic) NSString*  downloads_url;
@property (strong, nonatomic) NSString*  issues_url;
@property (strong, nonatomic) NSString*  pulls_url;
@property (strong, nonatomic) NSString*  milestones_url;
@property (strong, nonatomic) NSString*  notifications_url;
@property (strong, nonatomic) NSString*  labels_url;
@property (strong, nonatomic) NSString*  releases_url;
@property (strong, nonatomic) NSString*  deployments_url;
@property (strong, nonatomic) NSString*  created_at;
@property (strong, nonatomic) NSString*  updated_at;
@property (strong, nonatomic) NSString*  pushed_at;
@property (strong, nonatomic) NSString*  git_url;
@property (strong, nonatomic) NSString*  ssh_url;
@property (strong, nonatomic) NSString*  clone_url;
@property (strong, nonatomic) NSString*  svn_url;
@property (strong, nonatomic) NSString*  homepage;
@property (assign, nonatomic)  int  size;
@property (assign, nonatomic)  int  stargazers_count;
@property (assign, nonatomic)  int watchers_count;
@property (strong, nonatomic) NSString*  language;
@property (assign, nonatomic)  bool   has_issues;
@property (assign, nonatomic)  bool   has_downloads;
@property (assign, nonatomic)  bool  has_wiki;
@property (assign, nonatomic)  bool  has_pages;
@property (assign, nonatomic)  int   forks_count;
@property (strong, nonatomic) NSString*  mirror_url;
@property (assign, nonatomic)  int   open_issues_count;
@property (assign, nonatomic) int forks;
@property (assign, nonatomic) int open_issues;
@property (assign, nonatomic) int watchers;
@property (strong, nonatomic) NSString*  default_branch;
@property (assign, nonatomic) double  score;


@end
