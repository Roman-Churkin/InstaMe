//
//  RCIMUserInfoView.m
//  InstaMe
//
//  Created by Roman Churkin on 28.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMUserInfoView.h"

@interface RCIMUserInfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userExtraInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *showUserProfileButton;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation RCIMUserInfoView

#pragma mark - Initialization

- (void)initialize {
    CALayer *profileImageViewLayer = _profileImageView.layer;
    profileImageViewLayer.borderColor = [UIColor whiteColor].CGColor;
    profileImageViewLayer.borderWidth = 1.f;
    profileImageViewLayer.masksToBounds = YES;
}

#pragma mark - UIImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [[self class] RC_loadFromNib];
    self.frame = frame;
    
    return self;
}

+ (instancetype)RC_loadFromNib {
    RCIMUserInfoView *view = [super RC_loadFromNib];
    [view initialize];
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = _profileImageView.bounds.size;
    _profileImageView.layer.cornerRadius = MIN(size.width, size.height)/2.f;
}

@end
