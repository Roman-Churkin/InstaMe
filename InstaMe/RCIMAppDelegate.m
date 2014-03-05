//
//  RCIMAppDelegate.m
//  InstaMe
//
//  Created by Roman Churkin on 03.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMAppDelegate.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "RCIMInstagramClient.h"

#import "RCIMUserFeedViewController.h"
#import "RCIMLoginScreenViewController.h"


@implementation RCIMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MagicalRecord setupCoreDataStack];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    UIViewController *viewControllerToPresentFirst = nil;
    
    if ([[RCIMInstagramClient sharedInstagramClient] instaTokenString]) {
        viewControllerToPresentFirst = [RCIMUserFeedViewController userFeedViewControllerwithUser:nil];
        viewControllerToPresentFirst = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresentFirst];
    } else {
        viewControllerToPresentFirst = [RCIMLoginScreenViewController loginScreenViewController];
    }

    self.window.rootViewController = viewControllerToPresentFirst;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL authProcessEnd = [[RCIMInstagramClient sharedInstagramClient] processTokenURL:url];
    
    return authProcessEnd;
}

@end
