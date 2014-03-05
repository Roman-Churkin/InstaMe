//
//  RCIMInstagramClient.m
//  InstaMe
//
//  Created by Roman Churkin on 27.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMInstagramClient.h"
#import <AFNetworking/AFNetworking.h>

#define kInstagramAPI_CLIENT_ID @"592ef7b7999d4229895003f1987e49e6"
#define kInstagramAPI_BASE_URL_PATH @"https://api.instagram.com/v1/"

@interface RCIMInstagramClient ()

@property (strong, nonatomic) NSString *instaTokenString;

@end

@implementation RCIMInstagramClient

+ (instancetype)sharedInstagramClient {
    static RCIMInstagramClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RCIMInstagramClient alloc] initWithBaseURL:[NSURL URLWithString:kInstagramAPI_BASE_URL_PATH]];
        _sharedClient.instaTokenString = [RCIMInstagramClient loadToken];
    });
    
    return _sharedClient;
}

#pragma mark - Save / Load

- (void)saveToken {
    NSData *encoded = [NSKeyedArchiver archivedDataWithRootObject:self.instaTokenString];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:encoded
                     forKey:@"instaTokenString"];
    [userDefaults synchronize];
}

+ (NSString *)loadToken {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *encoded = [userDefaults objectForKey:@"instaTokenString"];
    
    return encoded ? [NSKeyedUnarchiver unarchiveObjectWithData:encoded] : nil;
}

#pragma mark -

- (void)logOut {
    _instaTokenString = nil;
    [self saveToken];
}

- (NSDictionary *)completeParameters:(NSDictionary *)parameters
                           withToken:(BOOL)needToken {

    NSMutableDictionary *mParameters = parameters?[parameters mutableCopy]:[NSMutableDictionary dictionary];

    if (needToken)
        [mParameters addEntriesFromDictionary:@{@"access_token" : self.instaTokenString}];
    else
        [mParameters addEntriesFromDictionary:@{@"client_id" : kInstagramAPI_CLIENT_ID}];
    
    return [NSDictionary dictionaryWithDictionary:mParameters];
}

+ (NSURL *)completeURLPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                     token:(NSString *)tokenString
             baseURLString:(NSString *)baseURLString {
    
    NSMutableString *completePath =
    baseURLString? [baseURLString mutableCopy] : [kInstagramAPI_BASE_URL_PATH mutableCopy];
    
    [completePath appendString:path];
    
    [completePath appendString:@"?"];
    
    if (tokenString) {
        [completePath appendFormat:@"access_token=%@", tokenString];
    } else
        [completePath appendFormat:@"client_id=%@", kInstagramAPI_CLIENT_ID];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [completePath appendFormat:@"&%@=%@", key, obj];
    }];
    
    return [NSURL URLWithString:[NSString stringWithString:completePath]];
}

+ (NSURL *)authorizationURL {
    
    NSString *path = @"oauth/authorize/";
    
    NSDictionary *parameters = @{
                                 @"redirect_uri"  : @"instame://token",
                                 @"scope"         : @"likes",
                                 @"response_type" : @"token"};
    
    NSString *baseURL = @"https://instagram.com/";
    
    return [RCIMInstagramClient completeURLPath:path parameters:parameters token:nil baseURLString:baseURL];
}

- (BOOL)processTokenURL:(NSURL *)url {
    NSString *scheme = [url scheme];
    NSString *host = [url host];
    
    if ([scheme isEqualToString:@"instame"] && [host isEqualToString:@"token"]) {
        
        NSString *fragment = [url fragment];
        
        if (fragment) {
            NSString *tokenString = [[fragment componentsSeparatedByString:@"="] lastObject];
            self.instaTokenString = tokenString;
            [self saveToken];
            return YES;
        } else {
            // отказался от авторизации
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"Не особо и хотелось :P"
                                       delegate:nil
                              cancelButtonTitle:@"close"
                              otherButtonTitles:nil] show];
        }
    }
    return NO;
}

- (BOOL)processTokenRequest:(NSURLRequest *)request {
    NSURL *url = [request URL];
    return [self processTokenURL:url];
}

@end
