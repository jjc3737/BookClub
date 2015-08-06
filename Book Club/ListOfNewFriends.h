//
//  ListOfNewFriends.h
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListOfNewFriends : NSObject


+(void)retrieveFriendsWithCompletion:(void (^)(NSArray *array))complete;

@end
