//
//  BooksViewController.m
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "ProfileViewController.h"
#import "Book.h"
#import "Friend+Model.h"
#import "CommentsViewController.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBooksLabel;
@property NSArray *books;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpLabels];
    [self loadBooks];
}

-(void)setUpLabels {
    self.title = self.friend.name;
    self.nameLabel.text = self.friend.name;
}
-(void)loadBooks {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    request.predicate = [NSPredicate predicateWithFormat:@"friends CONTAINS%@", self.friend];
    self.books = [self.friend.managedObjectContext executeFetchRequest:request error:NULL];
    self.numberOfBooksLabel.text = [NSString stringWithFormat:@"Number of Books: %lu", self.books.count];
    
    [self.tableView reloadData];
}


#pragma mark - IBAction Method


- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Suggest New Book" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Title";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Author";
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        UITextField *titleTextField = [[alertController textFields] firstObject];
        UITextField *authorTextField = [[alertController textFields] lastObject];
        
        NSString *enteredTitle = titleTextField.text;
        NSString *enteredAuthor = authorTextField.text;
        
        Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:
                      self.friend.managedObjectContext];
        book.title = enteredTitle;
        book.author = enteredAuthor;
        [book addFriendsObject:self.friend];
        
        [self.friend.managedObjectContext save:nil];
        [self loadBooks];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - TableView Delegate 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell"];
    
    Book *book = self.books[indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;
    
    return cell; 
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    NSIndexPath *indexPath  = [self.tableView indexPathForCell:sender];
    
    CommentsViewController *vc = segue.destinationViewController;
    vc.book = self.books[indexPath.row];
}


@end
