//
//  RCIMPhotoCommentCell+ConfigureForPhotoComment.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCommentCell.h"

@class RCIMPhotoComment;

@interface RCIMPhotoCommentCell (ConfigureForPhotoComment)

+ (NSAttributedString *)textForPhotoComment:(RCIMPhotoComment *)photoComment
                               withCache:(NSCache *)cache;

- (void)configureForPhotoComment:(RCIMPhotoComment *)photoComment
                       withCache:(NSCache *)cache;

@end
