//
//  RCIMInstaPhotoInfo+Network.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMInstaPhotoInfo+Network.h"
#import "RCIMInstagramClient.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "RCIMInstaUser.h"

#define kPhotoInfoKeyPath_NEXT_MAX_ID @"pagination.next_max_id"

#define kPhotoInfoKeyPath_PRIVATE_PROFILE_CODE 400

@implementation RCIMInstaPhotoInfo (Network)

+ (void)updatePhotosWithJSON:(id)json user:(RCIMInstaUser *)user completion:(void(^)())completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [RCIMInstaPhotoInfo MR_importFromArray:json
                                     inContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        if (completion)
            completion();
    }];
}

+ (void)getUserPhotos:(RCIMInstaUser *)user
                maxID:(NSString *)maxID
           completion:(RCIMLoadPhotoCompletionBlock)completion {
    RCIMInstagramClient *instaClient = [RCIMInstagramClient sharedInstagramClient];
    
    NSString *path = [NSString stringWithFormat:@"users/%@/media/recent", user.userID];

    NSDictionary *parameters = nil;
    if (maxID)
        parameters = @{@"max_id" : maxID};
    
    parameters = [instaClient completeParameters:parameters
                                       withToken:YES];
    
    [instaClient GET:path
          parameters:parameters
             success:^(NSURLSessionDataTask *task, id json) {
                 void(^updatePhotosComplete)() = ^() {
                     NSString *maxID = [json valueForKeyPath:kPhotoInfoKeyPath_NEXT_MAX_ID];
                     
                     if (completion)
                         completion(maxID, YES);
                 };
                 
                 [RCIMInstaPhotoInfo updatePhotosWithJSON:[json valueForKey:@"data"]
                                                     user:user
                                               completion:updatePhotosComplete];
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)[task response];
                 int errorCode = [httpResponse statusCode];
                 if (errorCode == kPhotoInfoKeyPath_PRIVATE_PROFILE_CODE){
                     //TODO: Этим не горжусь.
                     [[[UIAlertView alloc] initWithTitle:@"Приватный профайл"
                                                 message:@"К сожалению невозможно загружать фотографии пользователей c установленными настройками конфеденциальности"
                                                delegate:nil
                                       cancelButtonTitle:@"Закрыть"
                                       otherButtonTitles:nil] show];
                 }
                 if (completion)
                     completion(nil, NO);
             }];
}

- (void)getFullInfoCompletion:(void(^)())completion {
    RCIMInstagramClient *instaClient = [RCIMInstagramClient sharedInstagramClient];
    
    NSString *path = [NSString stringWithFormat:@"media/%@", self.photoID];
    
    NSDictionary *parameters = [instaClient completeParameters:nil
                                                     withToken:YES];
    
    typeof(self) __weak wSelf = self;
    [instaClient GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id json) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            RCIMInstaPhotoInfo *photoInfo = [wSelf MR_inContext:localContext];
            [photoInfo MR_importValuesForKeysWithObject:[json valueForKey:@"data"]];
        } completion:^(BOOL success, NSError *error) {
            if (completion) {
                completion();
            }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

- (void)like:(void(^)())completion {
    if (self.userHasLikedValue && completion) {
        completion();
        return;
    }
  
    RCIMInstagramClient *instaClient = [RCIMInstagramClient sharedInstagramClient];
    
    NSString *path = [NSString stringWithFormat:@"media/%@/likes", self.photoID];
    
    NSDictionary *parameters = [instaClient completeParameters:nil
                                                     withToken:YES];
    
    typeof(self) __weak wSelf = self;
    [instaClient POST:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
            wSelf.userHasLikedValue = YES;
        } completion:^(BOOL success, NSError *error) {
            if (completion) {
                completion();
            }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

- (void)unLike:(void(^)())completion {
    if (!self.userHasLikedValue && completion) {
        completion();
        return;
    }
    
    RCIMInstagramClient *instaClient = [RCIMInstagramClient sharedInstagramClient];
    
    NSString *path = [NSString stringWithFormat:@"media/%@/likes", self.photoID];
    
    NSDictionary *parameters = [instaClient completeParameters:nil
                                                     withToken:YES];
    
    typeof(self) __weak wSelf = self;
    [instaClient DELETE:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
            wSelf.userHasLikedValue = NO;
        } completion:^(BOOL success, NSError *error) {
            if (completion) {
                completion();
            }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion();
        }
    }];
}

@end
