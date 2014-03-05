// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCIMPhotoComment.m instead.

#import "_RCIMPhotoComment.h"

const struct RCIMPhotoCommentAttributes RCIMPhotoCommentAttributes = {
	.commentID = @"commentID",
	.commentText = @"commentText",
	.createDate = @"createDate",
};

const struct RCIMPhotoCommentRelationships RCIMPhotoCommentRelationships = {
	.photo = @"photo",
	.user = @"user",
};

const struct RCIMPhotoCommentFetchedProperties RCIMPhotoCommentFetchedProperties = {
};

@implementation RCIMPhotoCommentID
@end

@implementation _RCIMPhotoComment

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RCIMPhotoComment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RCIMPhotoComment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RCIMPhotoComment" inManagedObjectContext:moc_];
}

- (RCIMPhotoCommentID*)objectID {
	return (RCIMPhotoCommentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic commentID;






@dynamic commentText;






@dynamic createDate;






@dynamic photo;

	

@dynamic user;

	






@end
