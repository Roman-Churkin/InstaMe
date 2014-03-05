//
//  RCIMLoginScreenViewController.m
//  InstaMe
//
//  Created by Roman Churkin on 28.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMLoginScreenViewController.h"
#import "RCIMLoginViewController.h"
#import "RCIMUserFeedViewController.h"
#import "RCIMInstaUser+Network.h"
#import "RCIMInstagramClient.h"

//#define LOGIN_IN_UIWEBVIEW 1 //раскомментировать, чтобы логиниться через контроллер с UIWebView. UIWebView неприятно течет, поэтому добавил авторизацию через сафари

@interface RCIMLoginScreenViewController () <RCIMLoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation RCIMLoginScreenViewController {
    RCIMInstagramClient * _instagramClient;
}

+ (instancetype)loginScreenViewController {
    return [[RCIMLoginScreenViewController alloc] initWithNibName:NSStringFromClass([RCIMLoginScreenViewController class])
                                                           bundle:[NSBundle mainBundle]];
}

#pragma mark - UIView

- (void)viewDidLoad {
    [super viewDidLoad];

    _instagramClient = [RCIMInstagramClient sharedInstagramClient];
    
#ifndef LOGIN_IN_UIWEBVIEW
    [_instagramClient addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(instaTokenString))
                          options:NSKeyValueObservingOptionNew
                          context:nil];
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(instaTokenString))]) {
        [self gotToken];
        [_instagramClient removeObserver:self forKeyPath:keyPath];
    }
}

#pragma mark - 

- (void)gotToken {

    _loginButton.userInteractionEnabled = NO;
    [_loginButton setTitle:@"Welcome!"
                  forState:UIControlStateNormal];
    
    typeof(self) __weak wSelf = self;
    [RCIMInstaUser getSelfCompletion:^(RCIMInstaUser *user, BOOL success) {
        RCIMUserFeedViewController *userFeedVController =
        [RCIMUserFeedViewController userFeedViewControllerwithUser:user];
        
        UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:userFeedVController];
        
        [UIView transitionFromView:wSelf.view
                            toView:navigationController.view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:^(BOOL finished) {
                            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                            window.rootViewController = navigationController;
                        }];
    }];
}

#pragma mark - Actions

- (IBAction)userWantToLogin:(id)sender {
#ifdef LOGIN_IN_UIWEBVIEW
    RCIMLoginViewController *loginVC = [[RCIMLoginViewController alloc] init];
    loginVC.delegate = self;
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
#else
    [[UIApplication sharedApplication] openURL:[RCIMInstagramClient authorizationURL]];
#endif
}

#pragma mark - RCIMLoginViewControllerDelegate

- (void)loginController:(RCIMLoginViewController *)loginVC reachedAuthEndsuccessful:(BOOL)success {
    
    if (!success) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self gotToken];
    }];
}

@end
