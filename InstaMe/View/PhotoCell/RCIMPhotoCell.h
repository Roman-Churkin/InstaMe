//
//  RCIMPhotoCell.h
//  InstaMe
//
//  Created by Roman Churkin on 01.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRCIMPhotoCell_DEFAULT_HEIGHT 350.f

@interface RCIMPhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel     *likesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel     *commentsCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;

@end
