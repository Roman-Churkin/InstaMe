//
//  RCIMLoginViewController.h
//  InstaMe
//
//  Created by Roman Churkin on 27.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCIMLoginViewControllerDelegate;

@interface RCIMLoginViewController : UIViewController

@property (weak, nonatomic) id<RCIMLoginViewControllerDelegate> delegate;

@end

@protocol RCIMLoginViewControllerDelegate <NSObject>

@required
- (void)loginController:(RCIMLoginViewController *)loginVC reachedAuthEndsuccessful:(BOOL)success;

@end