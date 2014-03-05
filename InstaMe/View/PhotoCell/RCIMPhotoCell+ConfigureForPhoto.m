//
//  RCIMPhotoCell+ConfigureForPhoto.m
//  InstaMe
//
//  Created by Roman Churkin on 01.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCell+ConfigureForPhoto.h"
#import "RCIMInstaPhotoInfo.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation RCIMPhotoCell (ConfigureForPhoto)

- (void)configureForPhoto:(RCIMInstaPhotoInfo *)photoInfo {
    self.likesCountLabel.text = [photoInfo.likesCount stringValue];
    self.commentsCountLabel.text = [photoInfo.commentsCount stringValue];
    self.photoImageView.image = nil;
    [self.photoImageView setImageWithURL:[NSURL URLWithString:photoInfo.maxResPhotoURLString]];
}

@end
