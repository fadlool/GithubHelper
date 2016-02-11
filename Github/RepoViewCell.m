//
//  RepoViewCell.m
//  Github
//
//  Created by Mohamed on 02/11/16.
//  Copyright (c) 2014 Microapps. All rights reserved.
//

#import "RepoViewCell.h"
#import "UIImageView+AFNetworking.h"


#define kCatchWidth 180

@interface RepoViewCell ()

//@property (nonatomic, strong) UIImage *senderImage;
@property (assign, nonatomic) BOOL isSenderImageSelected;

@end

@implementation RepoViewCell

-(void)awakeFromNib {
//    [super awakeFromNib];
//    
//    [self setup];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSenderImageView:(UIImageView *)avatarImageView
{
    _avatarImageView = avatarImageView;
    _avatarImageView.layer.borderColor = [UIColor colorWithRed:240/255.0
                                                         green:240/255.0
                                                          blue:240/255.0
                                                         alpha:1.0].CGColor;
    _avatarImageView.layer.masksToBounds = YES;
    
    _avatarImageView.contentMode = UIViewContentModeScaleToFill;
    _avatarImageView.layer.cornerRadius = 30; // set to half of the width or height to make Circular image
}

-(void)avatarImageChecked:(BOOL)checkedStatus senderImageURL:(NSString*)senderImageURL
{
    [UIView transitionWithView:self.avatarImageView
                      duration:0.3
                       options:checkedStatus ? UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{         // put the animation block here
                        [self configureAvatarImageView:senderImageURL selected:checkedStatus];
                    }
                    completion:NULL];     // nothing to do after animation ends.

}
-(void) configureAvatarImageView:(NSString*)senderImageURL selected:(BOOL)selected
{
    self.isSenderImageSelected = selected;
    if (selected) {
        self.avatarImageView.image = [UIImage imageNamed:@"check_yes"];
        self.avatarImageView.contentMode = UIViewContentModeCenter;
    } else {
//        [self.senderImageView setImageWithURL:[NSURL URLWithString:senderImageURL] placeholderImage:[UIImage imageNamed:@"person"]];
        [self.avatarImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:senderImageURL]] placeholderImage:[UIImage imageNamed:@"person"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            self.avatarImageView.image = image;
            self.avatarImageView.contentMode = UIViewContentModeScaleToFill;
            if (self.isSenderImageSelected) {
                self.avatarImageView.image = [UIImage imageNamed:@"check_yes"];
                self.avatarImageView.contentMode = UIViewContentModeCenter;
            }
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            if (self.isSenderImageSelected) {
                self.avatarImageView.image = [UIImage imageNamed:@"check_yes"];
                self.avatarImageView.contentMode = UIViewContentModeCenter;
            }
        }];
    }
}
- (void)performTransition:(UIViewAnimationOptions)options
{
    UIView *fromView, *toView;
    
    if ([self.avatarImageView superview] != nil)
    {
        fromView = self.avatarImageView;
//        toView = self.backView;
    }
    else
    {
//        fromView = self.backView;
        toView = self.avatarImageView;
    }
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:1.0
                       options:options
                    completion:^(BOOL finished) {
                        // animation completed
                     }];
}


@end
