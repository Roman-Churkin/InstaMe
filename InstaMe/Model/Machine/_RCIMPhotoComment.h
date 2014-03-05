// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCIMPhotoComment.h instead.

#import <CoreData/CoreData.h>


extern const struct RCIMPhotoCommentAttributes {
	__unsafe_unretained NSString *commentID;
	__unsafe_unretained NSString *commentText;
	__unsafe_unretained NSString *createDate;
} RCIMPhotoCommentAttributes;

extern const struct RCIMPhotoCommentRelationships {
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *user;
} RCIMPhotoCommentRelationships;

extern const struct RCIMPhotoCommentFetchedProperties {
} RCIMPhotoCommentFetchedProperties;

@class RCIMInstaPhotoInfo;
@class RCIMInstaUser;





@interface RCIMPhotoCommentID : NSManagedObjectID {}
@end

@interface _RCIMPhotoComment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RCIMPhotoCommentID*)objectID;





@property (nonatomic, strong) NSString* commentID;



//- (BOOL)validateCommentID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* commentText;



//- (BOOL)validateCommentText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createDate;



//- (BOOL)validateCreateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) RCIMInstaPhotoInfo *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) RCIMInstaUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _RCIMPhotoComment (CoreDataGeneratedAccessors)

@end

@interface _RCIMPhotoComment (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCommentID;
- (void)setPrimitiveCommentID:(NSString*)value;




- (NSString*)primitiveCommentText;
- (void)setPrimitiveCommentText:(NSString*)value;




- (NSDate*)primitiveCreateDate;
- (void)setPrimitiveCreateDate:(NSDate*)value;





- (RCIMInstaPhotoInfo*)primitivePhoto;
- (void)setPrimitivePhoto:(RCIMInstaPhotoInfo*)value;



- (RCIMInstaUser*)primitiveUser;
- (void)setPrimitiveUser:(RCIMInstaUser*)value;


@end
