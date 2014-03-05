//
//  RCIMPhotoCommentCell.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCIMPhotoCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

+ (CGFloat)calculateRequiredHeightForString:(NSAttributedString *)string;

+ (NSAttributedString *)userCommentStringWithName:(NSString *)userName
                                          andText:(NSString *)text;

@end
