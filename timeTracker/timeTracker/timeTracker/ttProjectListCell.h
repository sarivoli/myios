//
//  ttProjectListCell.h
//  timeTracker
//
//  Created by Arivoli on 1/7/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ttProjectListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblProjName;
@property (strong, nonatomic) IBOutlet UILabel *lblTaskCount;
@property (strong, nonatomic) IBOutlet UILabel *lblTotHours;

@end
