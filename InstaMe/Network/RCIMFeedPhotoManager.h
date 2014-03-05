//
//  RCIMFeedPhotoManager.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCIMInstaUser;

@interface RCIMFeedPhotoManager : NSObject

- (instancetype)initWithUser:(RCIMInstaUser *)instaUser;

- (void)getPhotos:(void(^)(BOOL canceled))completion;

- (void)refreshPhotos:(void(^)(BOOL canceled))completion;

@end
