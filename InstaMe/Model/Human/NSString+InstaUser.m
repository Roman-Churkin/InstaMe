//
//  NSString+InstaUser.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "NSString+InstaUser.h"

#import "RCIMInstaUser.h"

@implementation NSString (InstaUser)

+ (NSString *)RF_userNameAtString:(NSString *)userName {
    return [NSString stringWithFormat:@"@%@", userName];
}

+ (NSString *)RF_userAtString:(RCIMInstaUser *)user {
    return [NSString RF_userNameAtString:user.userName];
}

@end
