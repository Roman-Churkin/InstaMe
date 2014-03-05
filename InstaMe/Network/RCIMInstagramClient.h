//
//  RCIMInstagramClient.h
//  InstaMe
//
//  Created by Roman Churkin on 27.02.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface RCIMInstagramClient : AFHTTPSessionManager

@property (strong, nonatomic, readonly) NSString *instaTokenString;

+ (instancetype)sharedInstagramClient;

- (void)logOut;

- (NSDictionary *)completeParameters:(NSDictionary *)parameters
                           withToken:(BOOL)needToken;



+ (NSURL *)authorizationURL;

/**
 *  Обработка request при авторизации
 *
 *  @return YES если процесс авторизации завершен
 */
- (BOOL)processTokenRequest:(NSURLRequest *)request;

- (BOOL)processTokenURL:(NSURL *)url;

@end
