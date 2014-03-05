//
//  RFConstraints.h
//
//  Created by Roman Churkin on 22.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

@import UIKit;

NSLayoutConstraint *RF_horizontalCenterConstraint(UIView *item, UIView *toItem);

NSLayoutConstraint *RF_verticalCenterConstraint(UIView *item, UIView *toItem);

NSArray *RF_constraintsToCenterView(UIView *item, UIView *toItem);

NSLayoutConstraint *RF_widthConstraintForView(UIView *item, CGFloat width);

NSLayoutConstraint *RF_heightConstraintForView(UIView *item, CGFloat height);

NSArray *RF_constraintsForSize(UIView *item, CGSize size);

NSArray *RF_constraintsForFullHeight(UIView *item);

NSArray *RF_constraintsForFullWidth(UIView *item);

NSLayoutConstraint *RF_topPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad);

NSLayoutConstraint *RF_bottomPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad);

NSLayoutConstraint *RF_leftPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad);

NSLayoutConstraint *RF_rightPaddingConstraintForView(UIView *item, UIView *toItem, CGFloat pad);