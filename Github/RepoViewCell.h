//
//  InboxViewCell.h
//  CRS
//
//  Created by Amr Abdelmonsef on 2/17/14.
//  Copyright (c) 2014 Compulink. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RepoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateDate;
@property (weak, nonatomic) IBOutlet UILabel *forksLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

-(void)avatarImageChecked:(BOOL)checkedStatus senderImageURL:(NSString*)senderImageURL;
-(void) configureAvatarImageView:(NSString*)senderImageURL selected:(BOOL)selected;
@end
