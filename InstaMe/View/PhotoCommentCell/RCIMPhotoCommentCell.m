//
//  RCIMPhotoCommentCell.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCommentCell.h"

#import "NSString+InstaUser.h"

#define kRCIMPhotoCommentCell_TEXT_WIDTH 286.f
#define kRCIMPhotoCommentCell_TEXT_PAD 5.f

@interface RCIMPhotoCommentCell ()

@end

@implementation RCIMPhotoCommentCell

+ (CGFloat)calculateRequiredHeightForString:(NSAttributedString *)string {

    CGFloat labelWidth = kRCIMPhotoCommentCell_TEXT_WIDTH;
    
    CGSize constraintSize = CGSizeMake(labelWidth, CGFLOAT_MAX);
    
    CGRect labelRect =
    [string boundingRectWithSize:constraintSize
                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           context:nil];
    
    CGFloat height = ceil(labelRect.size.height) + kRCIMPhotoCommentCell_TEXT_PAD *2.f;

    return height;
}

+ (NSAttributedString *)userCommentStringWithName:(NSString *)userName
                                          andText:(NSString *)text {
    
    if (!userName || !text)
        return nil;
    
    UIColor *textColor = [UIColor whiteColor];
    
    UIFont *userNameFont = [UIFont fontWithName:@"HelveticaNeue"
                                           size:14.];
    
    NSDictionary *userNameAttrs = @{
                                    NSForegroundColorAttributeName : textColor,
                                    NSFontAttributeName :userNameFont
                                    };
    
    userName = [[NSString RF_userNameAtString:userName] stringByAppendingString:@" "];
    
    NSMutableAttributedString *userNameAttrString =
    [[NSMutableAttributedString alloc] initWithString:userName
                                           attributes:userNameAttrs];
    
    UIFont *textFont = [UIFont fontWithName:@"HelveticaNeue-Thin"
                                       size:14.];
    
    NSDictionary *textAttrs = @{
                                NSForegroundColorAttributeName : textColor,
                                NSFontAttributeName :textFont
                                };
    
    NSAttributedString *textAttrString =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:textAttrs];
    
    [userNameAttrString appendAttributedString:textAttrString];
    
    return [[NSAttributedString alloc] initWithAttributedString:userNameAttrString];
}

@end
