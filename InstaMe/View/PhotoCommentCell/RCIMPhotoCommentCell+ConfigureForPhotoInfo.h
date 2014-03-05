//
//  RCIMPhotoCommentCell+ConfigureForPhotoInfo.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCommentCell.h"

@class RCIMInstaPhotoInfo;

@interface RCIMPhotoCommentCell (ConfigureForPhotoInfo)

+ (NSAttributedString *)textForPhotoInfo:(RCIMInstaPhotoInfo *)photoInfo
                               withCache:(NSCache *)cache;

- (void)configureForPhotoInfo:(RCIMInstaPhotoInfo *)photoInfo
                    withCache:(NSCache *)cache;

@end
