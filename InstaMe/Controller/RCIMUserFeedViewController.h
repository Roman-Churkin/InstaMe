//
//  RCIMUserFeedViewController.h
//  InstaMe
//
//  Created by Roman Churkin on 03.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCIMInstaUser;

@interface RCIMUserFeedViewController : UITableViewController

@property (strong, nonatomic) RCIMInstaUser *instaUser;

+ (instancetype)userFeedViewControllerwithUser:(RCIMInstaUser *)user;

@end
