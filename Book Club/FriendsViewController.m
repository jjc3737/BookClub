//
//  FriendsViewController.m
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "FriendsViewController.h"
#import <CoreData/CoreData.h>
#import "Friend+Model.h"
#import "AddFriendsTableViewController.h"
#import "ProfileViewController.h"


@interface FriendsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *friends;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated  {
     [self loadFriends];
}


-(void)loadFriends{

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:friendEntityName];
    request.predicate = [NSPredicate predicateWithFormat:@"isChosen = %@", [NSNumber numberWithInt:1]];
    self.friends = [self.moc executeFetchRequest:request error:NULL];
    
    [self.tableView reloadData];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.friends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    
    Friend *friend = self.friends[indexPath.row];
    cell.textLabel.text = friend.name;
    
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addFriend"]) {
        AddFriendsTableViewController *vcOne = segue.destinationViewController;
        vcOne.moc = self.moc;
    } else {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Friend *friend = self.friends[indexPath.row];
        
        ProfileViewController *vcTwo = segue.destinationViewController;
        vcTwo.friend = friend;
    }
    
}


@end
