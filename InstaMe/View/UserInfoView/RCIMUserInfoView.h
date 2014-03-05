//
//  RCIMUserInfoView.h
//  InstaMe
//
//  Created by Roman Churkin on 28.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRCIMUserInfoView_DEFAULT_HEIGHT 85.f

@interface RCIMUserInfoView : UICollectionReusableView

@property (weak, nonatomic, readonly) UIImageView *profileImageView;
@property (weak, nonatomic, readonly) UILabel *userNameLabel;
@property (weak, nonatomic, readonly) UILabel *userExtraInfoLabel;
@property (weak, nonatomic, readonly) UIButton *showUserProfileButton;


@end
