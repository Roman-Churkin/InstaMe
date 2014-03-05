//
//  RCIMInstaUser+Network.m
//  InstaMe
//
//  Created by Roman Churkin on 03.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMInstaUser+Network.h"
#import "RCIMInstagramClient.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation RCIMInstaUser (Network)

- (void)refreshUserInfoCompletion:(void(^)())completion {
    RCIMInstagramClient *instaClient = [RCIMInstagramClient sharedInstagramClient];
    NSString *path = [@"users/" stringByAppendingString:self.userID];
    NSDictionary *parameters = [instaClient completeParameters:nil withToken:YES];
    [instaClient GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id json) {
        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
            [RCIMInstaUser MR_importFromObject:[json valueForKey:@"data"]
                                     inContext:localContext];
        } completion:^(BOOL success, NSError *error) {
            if (completion)
                completion();
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

+ (void)getSelfCompletion:(void(^)(RCIMInstaUser *user, BOOL success))completion {
    RCIMInstagramClient *instaClient = [RCIMInstagramClient sharedInstagramClient];
    [instaClient GET:@"users/self"
          parameters:[instaClient completeParameters:nil withToken:YES]
             success:^(NSURLSessionDataTask *task, id json) {
                 RCIMInstaUser * __block user = nil;
                 [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
                     user = [RCIMInstaUser MR_importFromObject:[json valueForKey:@"data"]
                                                     inContext:localContext];
                 } completion:^(BOOL success, NSError *error) {
                     if (completion)
                         completion(user, YES);
                 }];
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if (completion)
                     completion(nil, NO);
             }];
}

@end
