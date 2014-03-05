// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCIMInstaPhotoInfo.m instead.

#import "_RCIMInstaPhotoInfo.h"

const struct RCIMInstaPhotoInfoAttributes RCIMInstaPhotoInfoAttributes = {
	.commentsCount = @"commentsCount",
	.createDate = @"createDate",
	.likesCount = @"likesCount",
	.lowResPhotoURLString = @"lowResPhotoURLString",
	.maxResPhotoURLString = @"maxResPhotoURLString",
	.midResPhotoURLString = @"midResPhotoURLString",
	.photoID = @"photoID",
	.text = @"text",
	.userHasLiked = @"userHasLiked",
};

const struct RCIMInstaPhotoInfoRelationships RCIMInstaPhotoInfoRelationships = {
	.comments = @"comments",
	.user = @"user",
};

const struct RCIMInstaPhotoInfoFetchedProperties RCIMInstaPhotoInfoFetchedProperties = {
};

@implementation RCIMInstaPhotoInfoID
@end

@implementation _RCIMInstaPhotoInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RCIMInstaPhotoInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RCIMInstaPhotoInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RCIMInstaPhotoInfo" inManagedObjectContext:moc_];
}

- (RCIMInstaPhotoInfoID*)objectID {
	return (RCIMInstaPhotoInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"commentsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"commentsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"likesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"likesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"userHasLikedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userHasLiked"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic commentsCount;



- (int16_t)commentsCountValue {
	NSNumber *result = [self commentsCount];
	return [result shortValue];
}

- (void)setCommentsCountValue:(int16_t)value_ {
	[self setCommentsCount:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCommentsCountValue {
	NSNumber *result = [self primitiveCommentsCount];
	return [result shortValue];
}

- (void)setPrimitiveCommentsCountValue:(int16_t)value_ {
	[self setPrimitiveCommentsCount:[NSNumber numberWithShort:value_]];
}





@dynamic createDate;






@dynamic likesCount;



- (int16_t)likesCountValue {
	NSNumber *result = [self likesCount];
	return [result shortValue];
}

- (void)setLikesCountValue:(int16_t)value_ {
	[self setLikesCount:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveLikesCountValue {
	NSNumber *result = [self primitiveLikesCount];
	return [result shortValue];
}

- (void)setPrimitiveLikesCountValue:(int16_t)value_ {
	[self setPrimitiveLikesCount:[NSNumber numberWithShort:value_]];
}





@dynamic lowResPhotoURLString;






@dynamic maxResPhotoURLString;






@dynamic midResPhotoURLString;






@dynamic photoID;






@dynamic text;






@dynamic userHasLiked;



- (BOOL)userHasLikedValue {
	NSNumber *result = [self userHasLiked];
	return [result boolValue];
}

- (void)setUserHasLikedValue:(BOOL)value_ {
	[self setUserHasLiked:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveUserHasLikedValue {
	NSNumber *result = [self primitiveUserHasLiked];
	return [result boolValue];
}

- (void)setPrimitiveUserHasLikedValue:(BOOL)value_ {
	[self setPrimitiveUserHasLiked:[NSNumber numberWithBool:value_]];
}





@dynamic comments;

	
- (NSMutableSet*)commentsSet {
	[self willAccessValueForKey:@"comments"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"comments"];
  
	[self didAccessValueForKey:@"comments"];
	return result;
}
	

@dynamic user;

	






@end
