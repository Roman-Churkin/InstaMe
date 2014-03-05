//
//  UIView+RCNibLoading.m
//  InstaMe
//
//  Created by Roman Churkin on 02.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "UIView+RCNibLoading.h"

@implementation UIView (RCNibLoading)

+ (instancetype)RC_loadFromNib {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                         owner:nil options:nil];
    id view = nil;
    for (id obj in nibContents)
        if ([obj isKindOfClass:[self class]]) {
            view = obj;
            break;
        }

    return view;
}


@end
