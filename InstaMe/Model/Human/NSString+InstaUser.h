//
//  NSString+InstaUser.h
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCIMInstaUser;

@interface NSString (InstaUser)

+ (NSString *)RF_userNameAtString:(NSString *)userName;

+ (NSString *)RF_userAtString:(RCIMInstaUser *)user;

@end
