// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCIMInstaUser.h instead.

#import <CoreData/CoreData.h>


extern const struct RCIMInstaUserAttributes {
	__unsafe_unretained NSString *profilePictureURLString;
	__unsafe_unretained NSString *userExtraInfo;
	__unsafe_unretained NSString *userFullName;
	__unsafe_unretained NSString *userID;
	__unsafe_unretained NSString *userName;
} RCIMInstaUserAttributes;

extern const struct RCIMInstaUserRelationships {
	__unsafe_unretained NSString *comments;
	__unsafe_unretained NSString *userPhotos;
} RCIMInstaUserRelationships;

extern const struct RCIMInstaUserFetchedProperties {
} RCIMInstaUserFetchedProperties;

@class RCIMPhotoComment;
@class RCIMInstaPhotoInfo;







@interface RCIMInstaUserID : NSManagedObjectID {}
@end

@interface _RCIMInstaUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RCIMInstaUserID*)objectID;





@property (nonatomic, strong) NSString* profilePictureURLString;



//- (BOOL)validateProfilePictureURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userExtraInfo;



//- (BOOL)validateUserExtraInfo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userFullName;



//- (BOOL)validateUserFullName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userID;



//- (BOOL)validateUserID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* userName;



//- (BOOL)validateUserName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *comments;

- (NSMutableSet*)commentsSet;




@property (nonatomic, strong) NSSet *userPhotos;

- (NSMutableSet*)userPhotosSet;





@end

@interface _RCIMInstaUser (CoreDataGeneratedAccessors)

- (void)addComments:(NSSet*)value_;
- (void)removeComments:(NSSet*)value_;
- (void)addCommentsObject:(RCIMPhotoComment*)value_;
- (void)removeCommentsObject:(RCIMPhotoComment*)value_;

- (void)addUserPhotos:(NSSet*)value_;
- (void)removeUserPhotos:(NSSet*)value_;
- (void)addUserPhotosObject:(RCIMInstaPhotoInfo*)value_;
- (void)removeUserPhotosObject:(RCIMInstaPhotoInfo*)value_;

@end

@interface _RCIMInstaUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveProfilePictureURLString;
- (void)setPrimitiveProfilePictureURLString:(NSString*)value;




- (NSString*)primitiveUserExtraInfo;
- (void)setPrimitiveUserExtraInfo:(NSString*)value;




- (NSString*)primitiveUserFullName;
- (void)setPrimitiveUserFullName:(NSString*)value;




- (NSString*)primitiveUserID;
- (void)setPrimitiveUserID:(NSString*)value;




- (NSString*)primitiveUserName;
- (void)setPrimitiveUserName:(NSString*)value;





- (NSMutableSet*)primitiveComments;
- (void)setPrimitiveComments:(NSMutableSet*)value;



- (NSMutableSet*)primitiveUserPhotos;
- (void)setPrimitiveUserPhotos:(NSMutableSet*)value;


@end
