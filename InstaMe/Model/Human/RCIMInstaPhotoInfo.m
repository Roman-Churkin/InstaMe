#import "RCIMInstaPhotoInfo.h"
#import "RCIMInstaUser.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface RCIMInstaPhotoInfo ()


@end


@implementation RCIMInstaPhotoInfo

#pragma mark - Magical Import

- (BOOL)importCreateDate:(id)data {
    NSTimeInterval timeIntervalSince1970 = [data doubleValue];
    NSDate *date    = [NSDate dateWithTimeIntervalSince1970:timeIntervalSince1970];
    self.createDate = date;
    return YES;
}

- (BOOL)importUser:(id)data {
    
    NSString *userID = [data valueForKeyPath:@"user.id"];
    RCIMInstaUser *user = [RCIMInstaUser MR_findFirstByAttribute:RCIMInstaUserAttributes.userID
                                                       withValue:userID
                                                       inContext:self.managedObjectContext];
    if (user) {
        self.user = user;
    } else {
        self.user = [RCIMInstaUser MR_importFromObject:[data valueForKey:@"user"]
                                             inContext:self.managedObjectContext];
    }
    
    return YES;
}

@end
