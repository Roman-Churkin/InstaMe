//
//  RFConstraints.c
//
//  Created by Roman Churkin on 22.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RFConstraints.h"


NSLayoutConstraint *RF_horizontalCenterConstraint(UIView *item, UIView *toItem) {
    return [NSLayoutConstraint constraintWithItem:item
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toItem
                                        attribute:NSLayoutAttributeCenterX
                                       multiplier:1.f
                                         constant:0.f];
}

NSLayoutConstraint *RF_verticalCenterConstraint(UIView *item, UIView *toItem) {
    return [NSLayoutConstraint constraintWithItem:item
                                        attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toItem
                                        attribute:NSLayoutAttributeCenterY
                                       multiplier:1.f
                                         constant:0.f];
}

NSArray *RF_constraintsToCenterView(UIView *item, UIView *toItem) {
    NSLayoutConstraint *hConstraint = RF_horizontalCenterConstraint(item, toItem);
    NSLayoutConstraint *vConstraint = RF_verticalCenterConstraint(item, toItem);
    return @[hConstraint, vConstraint];
}

NSLayoutConstraint *RF_widthConstraintForView(UIView *item, CGFloat width) {
    return [NSLayoutConstraint constraintWithItem:item
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.f
                                         constant:width];
}

NSLayoutConstraint *RF_heightConstraintForView(UIView *item, CGFloat height) {
    return [NSLayoutConstraint constraintWithItem:item
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.f
                                         constant:height];
}

NSArray *RF_constraintsForSize(UIView *item, CGSize size) {
    NSLayoutConstraint *widthConstraint = RF_widthConstraintForView(item, size.width);
    NSLayoutConstraint *heightConstraint = RF_heightConstraintForView(item, size.height);
    return @[widthConstraint, heightConstraint];
}

NSArray *RF_constraintsForFullHeight(UIView *item) {
    return [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[item]|"
                                                   options:0
                                                   metrics:nil
                                                     views:NSDictionaryOfVariableBindings(item)];
}

NSArray *RF_constraintsForFullWidth(UIView *item) {
    return [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[item]|"
                                                   options:0
                                                   metrics:nil
                                                     views:NSDictionaryOfVariableBindings(item)];
}

NSLayoutConstraint *RF_paddingConstraintForView(UIView *item, UIView *toView, NSLayoutAttribute attribute, CGFloat pad) {
    return [NSLayoutConstraint constraintWithItem:item
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toView
                                        attribute:attribute
                                       multiplier:1.f
                                         constant:pad];
}

NSLayoutConstraint *RF_topPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad) {
    return RF_paddingConstraintForView(item, toItem, NSLayoutAttributeTop, pad);
}

NSLayoutConstraint *RF_bottomPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad) {
    return RF_paddingConstraintForView(item, toItem, NSLayoutAttributeTop, pad);
}

NSLayoutConstraint *RF_leftPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad) {
    return RF_paddingConstraintForView(item, toItem, NSLayoutAttributeLeft, pad);
}

NSLayoutConstraint *RF_rightPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad) {
    return RF_paddingConstraintForView(item, toItem, NSLayoutAttributeRight, pad);
}