//
//  RCIMInstaUser+Network.h
//  InstaMe
//
//  Created by Roman Churkin on 03.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMInstaUser.h"

@interface RCIMInstaUser (Network)

- (void)refreshUserInfoCompletion:(void(^)())completion;

+ (void)getSelfCompletion:(void(^)(RCIMInstaUser *user, BOOL success))completion;

@end
