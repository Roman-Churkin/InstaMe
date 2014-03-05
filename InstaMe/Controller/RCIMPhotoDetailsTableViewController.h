//
//  RCIMPhotoDetailsTableViewController.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCIMInstaPhotoInfo;

@interface RCIMPhotoDetailsTableViewController : UITableViewController

@property (strong, nonatomic) RCIMInstaPhotoInfo *photoInfo;

+ (instancetype)photoDetailsTableViewController;

@end
