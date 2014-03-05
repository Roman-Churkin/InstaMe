//
//  RCIMPhotoCell+ConfigureForPhoto.h
//  InstaMe
//
//  Created by Roman Churkin on 01.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoCell.h"

@class RCIMInstaPhotoInfo;

@interface RCIMPhotoCell (ConfigureForPhoto)

- (void)configureForPhoto:(RCIMInstaPhotoInfo *)photoInfo;

@end
