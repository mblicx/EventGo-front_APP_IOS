//
//  ListGiftTableViewController.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 14/04/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import "ListGiftTableViewController.h"
#import "locationUpdateManager.h"
#import "DetailPlaceViewController.h"

@interface ListGiftTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray * arrayClicked;
@property (strong, nonatomic) NSMutableArray * arrayFinded;
@property (strong, nonatomic) UITableViewCell * cellPrototype;
@property (nonatomic,strong) NSIndexPath * lastIndexPath;



@end

@implementation ListGiftTableViewController


- (void)viewDidLoad {
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 70.0; // set to whatever your "average" cell height is
}

- (void)viewWillAppear:(BOOL)animated {
    self.arrayClicked = [locationUpdateManager sharedStandardManager].clickedArray;
    self.arrayFinded = [locationUpdateManager sharedStandardManager].findArray;
    [_tableview reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}
- (void)viewDidAppear:(BOOL)animated {
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return _arrayFinded.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"notifyCell" ];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"notifyCell" forIndexPath:indexPath];
    
    cell.backgroundColor= [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.accessoryView.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    NSLog(@"test");
    
    cell.textLabel.text = [_arrayFinded[indexPath.row][@"event_name"] uppercaseString];
    cell.detailTextLabel.text = _arrayFinded[indexPath.row][@"description"];
    
    if ([[[locationUpdateManager sharedStandardManager] clickedArray] containsObject:_arrayFinded[indexPath.row]]) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    _lastIndexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if ([segue.identifier isEqualToString:@"notifiedDetail"]) {
        DetailPlaceViewController * detailPlaceViewController = (DetailPlaceViewController*)segue.destinationViewController;
        detailPlaceViewController.event = _arrayFinded[_lastIndexPath.row];
        [[[locationUpdateManager sharedStandardManager] clickedArray] addObject:_arrayFinded[_lastIndexPath.row]];
    }
}



@end
