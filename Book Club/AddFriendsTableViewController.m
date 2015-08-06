//
//  AddFriendsTableViewController.m
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "AddFriendsTableViewController.h"
#import "ListOfNewFriends.h"
#import "Friend+Model.h"
#import "AppDelegate.h"

@interface AddFriendsTableViewController ()

@property NSMutableArray *originalFriendsList;


@end

@implementation AddFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;
    [self loadFromCoreData];
   
}

-(void)loadFromCoreData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Friend"];
    self.originalFriendsList = [[self.moc executeFetchRequest:request error:NULL] mutableCopy];
    
    if (self.originalFriendsList.count == 0) {
        [self loadFriends];
    }
    [self.tableView reloadData];
}

-(void)loadFriends {
    [ListOfNewFriends retrieveFriendsWithCompletion:^(NSArray *array) {
        
        for (NSString *givenName in array) {
            Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:friendEntityName inManagedObjectContext:self.moc];
            friend.name = givenName;
            friend.isChosen = 0;
            [self.originalFriendsList addObject:friend];
        }
        
        [self.moc save:NULL];
        [self.tableView reloadData];
    
    }];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.originalFriendsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddFriendCell" forIndexPath:indexPath];
    
    Friend *friend = self.originalFriendsList[indexPath.row];
    
    if (friend.isChosen) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = friend.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Friend *friend = self.originalFriendsList[indexPath.row];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        friend.isChosen = 0;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        friend.isChosen =  [NSNumber numberWithInt:1];
    }
    
    [self.moc save:NULL];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
