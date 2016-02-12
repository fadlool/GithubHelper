//
//  RepoViewCell.m
//  Github
//
//  Created by Mohamed Fadl on 02/11/16.
//  Copyright (c) 2014 Microapps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RepoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateDate;
@property (weak, nonatomic) IBOutlet UILabel *forksLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *repoNameLabel;

-(void)avatarImageChecked:(BOOL)checkedStatus senderImageURL:(NSString*)senderImageURL;
-(void) configureAvatarImageView:(NSString*)senderImageURL selected:(BOOL)selected;
@end
