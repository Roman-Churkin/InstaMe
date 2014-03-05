//
//  RCIMLoginViewController.m
//  InstaMe
//
//  Created by Roman Churkin on 27.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMLoginViewController.h"
#import "RCIMInstagramClient.h"
#import "RCIMAppDelegate.h"

@interface RCIMLoginViewController () <UIWebViewDelegate>

@end

@implementation RCIMLoginViewController {
    RCIMInstagramClient *_instagramClient;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Вход";

    _instagramClient = [RCIMInstagramClient sharedInstagramClient];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    webView.delegate = self;
    [self.view addSubview:webView];
    [self.view addConstraints:RF_constraintsForFullHeight(webView)];
    [self.view addConstraints:RF_constraintsForFullWidth(webView)];
    
    NSURLRequest *authRequest = [NSURLRequest requestWithURL:[RCIMInstagramClient authorizationURL]];

    [webView loadRequest:authRequest];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
        
    BOOL authProcessEnd = [_instagramClient processTokenRequest:request];
    
    if (authProcessEnd) {
        [self.delegate loginController:self
              reachedAuthEndsuccessful:_instagramClient.instaTokenString?YES:NO];
        return NO;
    }
    
    return YES;
}

@end
