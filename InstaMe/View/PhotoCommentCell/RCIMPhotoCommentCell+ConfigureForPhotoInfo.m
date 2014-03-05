//
//  RCIMPhotoCommentCell+ConfigureForPhotoInfo.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCommentCell+ConfigureForPhotoInfo.h"

#import "RCIMInstaPhotoInfo.h"
#import "RCIMInstaUser.h"

#import "NSString+InstaUser.h"

@implementation RCIMPhotoCommentCell (ConfigureForPhotoInfo)

+ (NSAttributedString *)textForPhotoInfo:(RCIMInstaPhotoInfo *)photoInfo
                               withCache:(NSCache *)cache {
    
    NSAttributedString *finalString = [cache objectForKey:photoInfo.photoID];
    
    if (finalString)
        return  finalString;

    finalString = [RCIMPhotoCommentCell userCommentStringWithName:photoInfo.user.userName
                                                          andText:photoInfo.text];
    if (finalString)
        [cache setObject:finalString forKey:photoInfo.photoID];

    return finalString;
}

- (void)configureForPhotoInfo:(RCIMInstaPhotoInfo *)photoInfo withCache:(NSCache *)cache {
    self.commentLabel.attributedText = [RCIMPhotoCommentCell textForPhotoInfo:photoInfo
                                                                    withCache:cache];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
