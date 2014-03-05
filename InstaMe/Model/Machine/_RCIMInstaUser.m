// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCIMInstaUser.m instead.

#import "_RCIMInstaUser.h"

const struct RCIMInstaUserAttributes RCIMInstaUserAttributes = {
	.profilePictureURLString = @"profilePictureURLString",
	.userExtraInfo = @"userExtraInfo",
	.userFullName = @"userFullName",
	.userID = @"userID",
	.userName = @"userName",
};

const struct RCIMInstaUserRelationships RCIMInstaUserRelationships = {
	.comments = @"comments",
	.userPhotos = @"userPhotos",
};

const struct RCIMInstaUserFetchedProperties RCIMInstaUserFetchedProperties = {
};

@implementation RCIMInstaUserID
@end

@implementation _RCIMInstaUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RCIMInstaUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RCIMInstaUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RCIMInstaUser" inManagedObjectContext:moc_];
}

- (RCIMInstaUserID*)objectID {
	return (RCIMInstaUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic profilePictureURLString;






@dynamic userExtraInfo;






@dynamic userFullName;






@dynamic userID;






@dynamic userName;






@dynamic comments;

	
- (NSMutableSet*)commentsSet {
	[self willAccessValueForKey:@"comments"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"comments"];
  
	[self didAccessValueForKey:@"comments"];
	return result;
}
	

@dynamic userPhotos;

	
- (NSMutableSet*)userPhotosSet {
	[self willAccessValueForKey:@"userPhotos"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"userPhotos"];
  
	[self didAccessValueForKey:@"userPhotos"];
	return result;
}
	






@end
