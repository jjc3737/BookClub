//
//  Book.h
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Friend;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
