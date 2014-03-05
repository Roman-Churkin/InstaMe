//
//  RCIMPhotoCommentCell+ConfigureForPhotoComment.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCommentCell+ConfigureForPhotoComment.h"

#import "RCIMPhotoComment.h"
#import "RCIMInstaUser.h"

#import "NSString+InstaUser.h"

@implementation RCIMPhotoCommentCell (ConfigureForPhotoComment)

+ (NSAttributedString *)textForPhotoComment:(RCIMPhotoComment *)photoComment
                               withCache:(NSCache *)cache {
    
    NSAttributedString *finalString = [cache objectForKey:photoComment.commentID];
    
    if (finalString)
        return  finalString;
    
    finalString = [RCIMPhotoCommentCell userCommentStringWithName:photoComment.user.userName
                                                          andText:photoComment.commentText];
    [cache setObject:finalString forKey:photoComment.commentID];
    
    return finalString;
}

- (void)configureForPhotoComment:(RCIMPhotoComment *)photoComment withCache:(NSCache *)cache {
    self.commentLabel.attributedText = [RCIMPhotoCommentCell textForPhotoComment:photoComment
                                                                    withCache:cache];
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
