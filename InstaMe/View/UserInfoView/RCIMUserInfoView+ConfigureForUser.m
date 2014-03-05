//
//  RCIMUserInfoView+ConfigureForUser.m
//  InstaMe
//
//  Created by Roman Churkin on 02.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMUserInfoView+ConfigureForUser.h"
#import "RCIMInstaUser.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation RCIMUserInfoView (ConfigureForUser)

- (void)configureForUser:(RCIMInstaUser *)user {
    self.userNameLabel.text = user.userFullName.length > 0 ? user.userFullName : user.userName;
    self.userExtraInfoLabel.text = user.userExtraInfo;
    self.profileImageView.image = nil;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profilePictureURLString]];
}


@end
