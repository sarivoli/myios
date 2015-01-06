//
//  ttTaskCollectionViewCell.h
//  timeTracker
//
//  Created by Arivoli on 1/7/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ttTaskCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblTaskName;

@property (strong, nonatomic) IBOutlet UILabel *lblTodayHrs;

@property (strong, nonatomic) IBOutlet UILabel *lblTotalHrs;
@property (strong, nonatomic) IBOutlet UIToolbar *tlbarTaskActions;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *brbtnAddTime;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *brbtnEditTask;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *brbtnDeleteTask;
@end
