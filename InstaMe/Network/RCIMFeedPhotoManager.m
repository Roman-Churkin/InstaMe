//
//  RCIMFeedPhotoManager.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMFeedPhotoManager.h"
#import "RCIMInstaUser.h"
#import "RCIMInstaPhotoInfo+Network.h"

@interface RCIMFeedPhotoManager ()

@property (strong, nonatomic) RCIMInstaUser *instaUser;
@property (strong, nonatomic) NSString *maxID;
@property (nonatomic) BOOL inProgress;

@end

@implementation RCIMFeedPhotoManager

#pragma mark - Initialization

- (id)init {
    return nil;
}

- (instancetype)initWithUser:(RCIMInstaUser *)instaUser {
    self = [super init];
    if (self) {
        _instaUser  = instaUser;
        _maxID      = nil;
        _inProgress = NO;
    }
    return self;
}

#pragma mark - 

- (void)getPhotos:(void (^)(BOOL canceled))completion {
    if (_inProgress) {
        if (completion)
            completion(YES);
        return;
    }
    
    _inProgress = YES;
    
    typeof(self) __weak wSelf = self;
    [RCIMInstaPhotoInfo getUserPhotos:_instaUser maxID:_maxID completion:^(NSString *maxID, BOOL succes) {
        if (succes)
            wSelf.maxID = maxID;
    
        wSelf.inProgress = NO;
        
        if (completion)
            completion(NO);
    }];
}

- (void)refreshPhotos:(void (^)(BOOL canceled))completion {
    _maxID = nil;
    
    [self getPhotos:completion];
}

@end
