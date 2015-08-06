//
//  CommentsViewController.m
//  Book Club
//
//  Created by Jaehee Chung on 8/5/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "CommentsViewController.h"
#import "Book.h"
#import "Comment.h"

@interface CommentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property NSArray *comments;


@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpLabels];
    [self loadComments];
}

-(void)setUpLabels {
    self.title = self.book.title;
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
}

-(void)loadComments {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Comment"];
    request.predicate = [NSPredicate predicateWithFormat:@"book = %@", self.book];
    self.comments = [self.book.managedObjectContext executeFetchRequest:request error:NULL];
    
    [self.tableView reloadData];
}


- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Leave a Comment" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Comment";
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add Comment" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        UITextField *commentTextField = [[alertController textFields] firstObject];
      
        NSString *enteredComment = commentTextField.text;
    
        Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:
                      self.book.managedObjectContext];
        comment.text = enteredComment;
 
        [self.book addCommentsObject:comment];
        
        [self.book.managedObjectContext save:nil];
        [self loadComments];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - tableView delegate 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];

    Comment *comment = self.comments[indexPath.row];
    cell.textLabel.text = comment.text;
    
    
    return cell;
}

@end
