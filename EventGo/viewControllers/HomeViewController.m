//
//  HomeViewController.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 14/04/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewCircle.h"
#import "UIColor+HexColors.h"
#import "HomeMapViewController.h"
#import "DetailPlaceViewController.h"

#import "UIKit+AFNetworking.h"
#import "OHAlertView.h"
#import "EventCell.h"

#import "constants.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSDictionary * eventDict;
@property (weak, nonatomic) IBOutlet UILabel *lbl_eventName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_eventShortDescription;
@property (weak, nonatomic) IBOutlet UIView *view_event;
@property (strong, nonatomic) IBOutlet UIView *cView;

@property  BOOL  password;
@property (weak, nonatomic) IBOutlet UIButton *btn_startStop;
@property (weak, nonatomic) IBOutlet UIView *view_scan;
@property (weak, nonatomic) IBOutlet ViewCircle *view_circle1;
@property (weak, nonatomic) IBOutlet ViewCircle *view_circle2;
@property (weak, nonatomic) IBOutlet ViewCircle *view_circle3;
@property (weak, nonatomic) IBOutlet UIImageView *img_scan;
@property (strong, nonatomic) NSTimer * timer;
@property (weak, nonatomic) IBOutlet UIButton *btn_listGifts;
@property (nonatomic,strong) NSIndexPath * lastIndexPath;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSArray * arrayOfEvents;
@property (nonatomic,strong) NSArray * arrayOfEvents_n;
@property (nonatomic,strong) NSArray * arrayOfEvents_f;
@property (nonatomic,strong) NSArray * arrayOfEvents_p;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property CGRect tempFrame;
@property (weak, nonatomic) IBOutlet UILabel *lbl_message;
@end

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoApp;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    _tempFrame = self.tableView.frame;
    }

- (void) viewWillAppear:(BOOL)animated {

    [[NSNotificationCenter defaultCenter] addObserverForName:@"refreshTable" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self.tableView reloadData];
        //[self refresh];
        [_refreshControl endRefreshing];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"refresh" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSURL *url = [NSURL URLWithString:dataURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable responseObject, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (responseObject && !error) {
                NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                if ([json isKindOfClass:[NSArray class]]){
                    _arrayOfEvents_n=json;
                    _arrayOfEvents=json;
                    _arrayOfEvents_p=json;
                }
                NSLog(@"hey! refresh here!");
            }
            else if(error){
                //NSLog(@"%f",M_PI);
                [OHAlertView showAlertWithTitle:NSLocalizedString(@"Connection problem!", nil) message:NSLocalizedString(@"We meet a problem when getting data from server, will you check the internet connection?", nil) cancelButton:NSLocalizedString(@"Cancel", nil) okButton:NSLocalizedString(@"OK", nil) onButtonTapped:^(UIAlertView *alert, NSInteger buttonIndex) {
//                                if (_nbTentatives < 1) {
//                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ucheckinManagerLoadGains" object:nil];
//                                    [self loadGains];
//                                    _nbTentatives++;
//                                } else {
//                                    if (_usersArray.count> 0) {
//                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ucheckinManagerStartScanning" object:nil];
//                                    }
//                                    else {
//                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ucheckinManagerStopScanning" object:nil];
//                                        _nbTentatives = 0;
//                                    }
//                                }
                            }];
            }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
        }] resume];
    }];
   
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"newEventDetected" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if (_password) {

            UILocalNotification* notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate date];
            notification.alertBody = [note.object description];
            notification.alertAction = NSLocalizedString(@"Voir",nil);
            notification.soundName = nil;
            notification.userInfo = note.object;
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
       
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"startScanning" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        _view_scan.backgroundColor = [UIColor colorWithRed:239.0/255 green:201.0/255 blue:76.0/255 alpha:1.0];
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(anime) userInfo:nil repeats:YES];
        if(self.tableView.frame.origin.y > 245){
            _lbl_message.text = @"Scaning nearby event...\nClick here to stop scaning";
        }
        [self refresh];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"stopScanning" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        _view_scan.backgroundColor = [UIColor colorWithRed:32.0/255 green:192.0/255 blue:92.0/255 alpha:1.0];
        if(self.tableView.frame.origin.y > 245){
            _lbl_message.text = @"Click here to start scaning";
        }
        }];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"loadData" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            _view_scan.backgroundColor = [UIColor colorWithRed:32.0/255 green:32.0/255 blue:32.0/255 alpha:1.0];
    }];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _view_scan.backgroundColor = [UIColor colorWithRed:32.0/255 green:32.0/255 blue:32.0/255 alpha:1.0];
        _lbl_message.text = @"Loading data from server";
    });

//
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"badge" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//        if ([[UcheckinManager sharedManager] arrayOfCodesUnshow].count> 0) {
//            [[self.btn_listGifts viewWithTag:5] removeFromSuperview];
//            [CustomBadge badgesButton:(int)[UcheckinManager sharedManager].arrayOfCodesUnshow.count on:_btn_listGifts withxoffset:5.0 andyoffset:-5.0 andColor:[UIColor redColor] andTag:5];
//        }
//        else {        
//            for (UIView * view in _btn_listGifts.subviews) {
//                if (view.tag == 5) {
//                    [view removeFromSuperview];
//                }
//            }
//        }
//
//    }];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"badge" object:nil];
//
    
}

- (void) anime {

    [UIView animateWithDuration:1.0 animations:^{
        _img_scan.alpha = 0.3f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            _img_scan.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect tframe = self.tableView.frame;
    if(scrollView.contentOffset.y>0)
    {
        if(tframe.origin.y >72){
            tframe.origin.y -= scrollView.contentOffset.y;
            tframe.size.height += scrollView.contentOffset.y;
            if(tframe.origin.y < 72){
                tframe.origin.y = 72;
                tframe.size.height = self.view.frame.size.height-72;
            }
        }
        _lbl_message.hidden = true;
    }
    else if(scrollView.contentOffset.y<0){
        if(tframe.origin.y < 250){
            tframe.origin.y -= scrollView.contentOffset.y;
            tframe.size.height += scrollView.contentOffset.y;
            if(tframe.origin.y > 245){
                tframe.origin.y = 250;
                tframe.size.height = self.view.frame.size.height-250;
//                if([[UcheckinManager sharedManager] isScanning])
//                    _lbl_message.text = @"Scaning nearby event...\nClick here to stop scaning";
//                else
                    _lbl_message.text = @"Click here to start scaning";
                _lbl_message.hidden = false;
            }
        }
    }
    _tempFrame = tframe;
    self.tableView.frame = tframe;
    [self.view bringSubviewToFront:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    _lastIndexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    if ([segue.identifier isEqualToString:@"homeMap"]) {
        
        HomeMapViewController * homeMapViewController = (HomeMapViewController*)segue.destinationViewController;
        homeMapViewController.arrayOfEvents = _arrayOfEvents;
        [homeMapViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    if ([segue.identifier isEqualToString:@"detail"]) {
        DetailPlaceViewController * detailPlaceViewController = (DetailPlaceViewController*)segue.destinationViewController;
        if(_lastIndexPath.section==0)
        {
            detailPlaceViewController.event = _arrayOfEvents_n[_lastIndexPath.row];
            NSLog(@"row in selected : %ld",(long)_lastIndexPath.row);
            
        }
        else if(_lastIndexPath.section==1)
        {
            detailPlaceViewController.event = _arrayOfEvents_f[_lastIndexPath.row];
        }
        else if(_lastIndexPath.section==2)
        {
            detailPlaceViewController.event = _arrayOfEvents_p[_lastIndexPath.row];
        }
    }
}


- (IBAction)doStartStopScan:(id) object {
    
//    
//    if ([UcheckinManager sharedManager] .isScanning) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[UcheckinManager sharedManager] stopScanning];
//            [_timer invalidate];
//            _timer = nil;
//        });
//    }
//    else {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[UcheckinManager sharedManager] startScanning];
//        });
//    }
    self.tableView.frame = _tempFrame;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor blackColor];
    switch(section){
        case 0:
            if(_arrayOfEvents_n.count!=0)
                headerLabel.text = @" Showing";
            else
                headerLabel.text = nil;
            break;
        case 1:
            if(_arrayOfEvents_f.count!=0)
                headerLabel.text = @" Your favoris";
            else
                headerLabel.text = nil;
            break;
        case 2:
            if(_arrayOfEvents_p.count!=0)
                headerLabel.text = @" Closed";
            else
                headerLabel.text = nil;
            break;
        default:
            break;
    }
    return headerLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section){
        case 0:
            return _arrayOfEvents_n.count;
            break;
        case 1:
            return _arrayOfEvents_f.count;
            break;
        case 2:
            return _arrayOfEvents_p.count;
            break;
        default:
            break;
    }
    return 10;
}

- (void)refresh {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    //[_tableView reloadData];
    //[_refreshControl endRefreshing];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellEvent" forIndexPath:indexPath];
    if(indexPath.section==0)
    {
        cell.lbl_title.text = [_arrayOfEvents_n[indexPath.row][@"event_name"] uppercaseString];
        cell.lbl_description.text = _arrayOfEvents_n[indexPath.row][@"description"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.accessoryView.backgroundColor = [UIColor clearColor];
        
        NSString * lieu = _arrayOfEvents_n[indexPath.row][@"address"];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterLongStyle;
        formatter.timeStyle =NSDateFormatterNoStyle;
        
        NSString * date = [formatter stringFromDate:_arrayOfEvents_n[indexPath.row][@"start_date"]];
        cell.lbl_date.text = [NSString stringWithFormat:@"%@, %@",lieu, date];
        [cell.img_event setImageWithURL:[NSURL URLWithString:_arrayOfEvents_n[indexPath.row][@"iconurl"]]];
    }else if(indexPath.section==1)
    {
        cell.lbl_title.text = [_arrayOfEvents_f[indexPath.row][@"event_name"] uppercaseString];
        cell.lbl_description.text = _arrayOfEvents_f[indexPath.row][@"description"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.accessoryView.backgroundColor = [UIColor clearColor];
        
        NSString * lieu = _arrayOfEvents_f[indexPath.row][@"address"];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterLongStyle;
        formatter.timeStyle =NSDateFormatterNoStyle;
        
        NSString * date = [formatter stringFromDate:_arrayOfEvents_f[indexPath.row][@"start_date"]];
        cell.lbl_date.text = [NSString stringWithFormat:@"%@, %@",lieu, date];
        [cell.img_event setImageWithURL:[NSURL URLWithString:_arrayOfEvents_f[indexPath.row][@"iconurl"]]];

    }
    else if(indexPath.section==2)
    {
        cell.lbl_title.text = [_arrayOfEvents_p[indexPath.row][@"event_name"] uppercaseString];
        cell.lbl_description.text = _arrayOfEvents_p[indexPath.row][@"description"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.accessoryView.backgroundColor = [UIColor clearColor];
        
        NSString * lieu = _arrayOfEvents_p[indexPath.row][@"address"];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterLongStyle;
        formatter.timeStyle =NSDateFormatterNoStyle;
        
        NSString * date = [formatter stringFromDate:_arrayOfEvents_p[indexPath.row][@"start_date"]];
        cell.lbl_date.text = [NSString stringWithFormat:@"%@, %@",lieu, date];
        [cell.img_event setImageWithURL:[NSURL URLWithString:_arrayOfEvents_p[indexPath.row][@"iconurl"]]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
//
//- (void)loadGains {
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSError *error = nil;
//        NSDictionary *dictioGen  = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
//        //sleep(1);
//        NSLog(@"JSON: %@", dictioGen);
//        if (dictioGen) {
//            if ([dictioGen[@"User"][@"isActive"] boolValue]){
//                [_usersArray addObject:dictioGen];
//                [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_usersArray] forKey:@"usersArray"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                for (NSDictionary * dictio in dictioGen[@"Signal"]) {
//                    NSString * code = dictio[@"code"];
//                    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"code==%@"];
//                    NSArray * array = [_arrayOfGifts filteredArrayUsingPredicate:predicate];
//                    if (array.count==0){
//                        [UcheckinGain getGainWithCode:code andBaseUrl:kBaseURL andApikey:kApiKey];
//                    }
//                }
//                [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_usersArray] forKey:@"usersArray"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"newUcheckinScan" object:kApiKey];
//                
//            }
//            else {
//                _usersArray=nil;
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usersArray"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [OHAlertView showAlertWithTitle:NSLocalizedString(@"Problème de connexion", nil) message:NSLocalizedString(@"Nous avons un problème pour récupérer les signaux, pouvez-vous vérifier votre connexion réseau, s'il vous plaît ?", nil) cancelButton:NSLocalizedString(@"Annuler", nil) okButton:NSLocalizedString(@"OK", nil) onButtonTapped:^(OHAlertView *alert, NSInteger buttonIndex) {
//            if (_nbTentatives < 1) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"ucheckinManagerLoadGains" object:nil];
//                [self loadGains];
//                _nbTentatives++;
//            } else {
//                if (_usersArray.count> 0) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ucheckinManagerStartScanning" object:nil];
//                }
//                else {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ucheckinManagerStopScanning" object:nil];
//                    _nbTentatives = 0;
//                }
//            }
//        }];
//    }];
//}


@end
