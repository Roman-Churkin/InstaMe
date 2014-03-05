// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCIMInstaPhotoInfo.h instead.

#import <CoreData/CoreData.h>


extern const struct RCIMInstaPhotoInfoAttributes {
	__unsafe_unretained NSString *commentsCount;
	__unsafe_unretained NSString *createDate;
	__unsafe_unretained NSString *likesCount;
	__unsafe_unretained NSString *lowResPhotoURLString;
	__unsafe_unretained NSString *maxResPhotoURLString;
	__unsafe_unretained NSString *midResPhotoURLString;
	__unsafe_unretained NSString *photoID;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *userHasLiked;
} RCIMInstaPhotoInfoAttributes;

extern const struct RCIMInstaPhotoInfoRelationships {
	__unsafe_unretained NSString *comments;
	__unsafe_unretained NSString *user;
} RCIMInstaPhotoInfoRelationships;

extern const struct RCIMInstaPhotoInfoFetchedProperties {
} RCIMInstaPhotoInfoFetchedProperties;

@class RCIMPhotoComment;
@class RCIMInstaUser;











@interface RCIMInstaPhotoInfoID : NSManagedObjectID {}
@end

@interface _RCIMInstaPhotoInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RCIMInstaPhotoInfoID*)objectID;





@property (nonatomic, strong) NSNumber* commentsCount;



@property int16_t commentsCountValue;
- (int16_t)commentsCountValue;
- (void)setCommentsCountValue:(int16_t)value_;

//- (BOOL)validateCommentsCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* createDate;



//- (BOOL)validateCreateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* likesCount;



@property int16_t likesCountValue;
- (int16_t)likesCountValue;
- (void)setLikesCountValue:(int16_t)value_;

//- (BOOL)validateLikesCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lowResPhotoURLString;



//- (BOOL)validateLowResPhotoURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* maxResPhotoURLString;



//- (BOOL)validateMaxResPhotoURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* midResPhotoURLString;



//- (BOOL)validateMidResPhotoURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* photoID;



//- (BOOL)validatePhotoID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* userHasLiked;



@property BOOL userHasLikedValue;
- (BOOL)userHasLikedValue;
- (void)setUserHasLikedValue:(BOOL)value_;

//- (BOOL)validateUserHasLiked:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *comments;

- (NSMutableSet*)commentsSet;




@property (nonatomic, strong) RCIMInstaUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _RCIMInstaPhotoInfo (CoreDataGeneratedAccessors)

- (void)addComments:(NSSet*)value_;
- (void)removeComments:(NSSet*)value_;
- (void)addCommentsObject:(RCIMPhotoComment*)value_;
- (void)removeCommentsObject:(RCIMPhotoComment*)value_;

@end

@interface _RCIMInstaPhotoInfo (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCommentsCount;
- (void)setPrimitiveCommentsCount:(NSNumber*)value;

- (int16_t)primitiveCommentsCountValue;
- (void)setPrimitiveCommentsCountValue:(int16_t)value_;




- (NSDate*)primitiveCreateDate;
- (void)setPrimitiveCreateDate:(NSDate*)value;




- (NSNumber*)primitiveLikesCount;
- (void)setPrimitiveLikesCount:(NSNumber*)value;

- (int16_t)primitiveLikesCountValue;
- (void)setPrimitiveLikesCountValue:(int16_t)value_;




- (NSString*)primitiveLowResPhotoURLString;
- (void)setPrimitiveLowResPhotoURLString:(NSString*)value;




- (NSString*)primitiveMaxResPhotoURLString;
- (void)setPrimitiveMaxResPhotoURLString:(NSString*)value;




- (NSString*)primitiveMidResPhotoURLString;
- (void)setPrimitiveMidResPhotoURLString:(NSString*)value;




- (NSString*)primitivePhotoID;
- (void)setPrimitivePhotoID:(NSString*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;




- (NSNumber*)primitiveUserHasLiked;
- (void)setPrimitiveUserHasLiked:(NSNumber*)value;

- (BOOL)primitiveUserHasLikedValue;
- (void)setPrimitiveUserHasLikedValue:(BOOL)value_;





- (NSMutableSet*)primitiveComments;
- (void)setPrimitiveComments:(NSMutableSet*)value;



- (RCIMInstaUser*)primitiveUser;
- (void)setPrimitiveUser:(RCIMInstaUser*)value;


@end
