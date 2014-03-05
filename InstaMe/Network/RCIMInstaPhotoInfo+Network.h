//
//  RCIMInstaPhotoInfo+Network.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMInstaPhotoInfo.h"

typedef void(^RCIMLoadPhotoCompletionBlock)(NSString *maxID, BOOL succes);

@interface RCIMInstaPhotoInfo (Network)

+ (void)getUserPhotos:(RCIMInstaUser *)user
                maxID:(NSString *)maxID
           completion:(RCIMLoadPhotoCompletionBlock)completion;

- (void)getFullInfoCompletion:(void(^)())completion;

- (void)like:(void(^)())completion;

- (void)unLike:(void(^)())completion;

@end
