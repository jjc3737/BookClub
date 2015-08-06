//
//  ListOfNewFriends.m
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "ListOfNewFriends.h"

@implementation ListOfNewFriends



+(void)retrieveFriendsWithCompletion:(void (^)(NSArray *array))complete {
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mmios8week/friends.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        complete([NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }]resume];
}
@end
