//
//  EventCell.h
//  UcheckIn
//
//  Created by Alexandre Pestre on 12/05/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_description;
@property (weak, nonatomic) IBOutlet UIImageView *img_event;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;

@end
