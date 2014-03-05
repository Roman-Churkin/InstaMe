#import "RCIMPhotoComment.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "RCIMInstaUser.h"

@interface RCIMPhotoComment ()

@end


@implementation RCIMPhotoComment

#pragma mark - Magical Import

- (BOOL)importCreateDate:(id)data {
    NSTimeInterval timeIntervalSince1970 = [data doubleValue];
    NSDate *date    = [NSDate dateWithTimeIntervalSince1970:timeIntervalSince1970];
    self.createDate = date;
    return YES;
}

- (BOOL)importUser:(id)data {
    
    NSString *userID = [data valueForKeyPath:@"from.id"];
    RCIMInstaUser *user = [RCIMInstaUser MR_findFirstByAttribute:RCIMInstaUserAttributes.userID
                                                       withValue:userID
                                                       inContext:self.managedObjectContext];
    if (user) {
        self.user = user;
    } else {
        RCIMInstaUser *newUser = [RCIMInstaUser MR_importFromObject:[data valueForKey:@"from"]
                                                          inContext:self.managedObjectContext];
        self.user = newUser;
    }
    
    return YES;
}

@end
