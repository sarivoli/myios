//
//  ttTimeEntryViewController.h
//  timeTracker
//
//  Created by Arivoli on 1/10/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol timeEntryProtocol;

@interface ttTimeEntryViewController : UIViewController
{
   NSMutableArray  *hoursDict,*minsDict,*dateDict;
}
@property (strong, nonatomic) IBOutlet UILabel *lblTaskName;
@property (strong, nonatomic) IBOutlet UILabel *lblProjName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segDate;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segHours;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segMins;
@property (strong, nonatomic) IBOutlet UILabel *lblTimeBoard;

@property (strong, nonatomic) IBOutlet UIButton *btnSaveTime;

@property (strong, nonatomic) IBOutlet UITextField *txtNote;

@property(nonatomic) NSMutableDictionary *taskInfo;

@property(weak) id<timeEntryProtocol> delegate;



-(IBAction)saveTimeEntryForm;
-(IBAction)closeTimeEntryFrom;
-(IBAction)setTime;
@end

@protocol timeEntryProtocol <NSObject>
@required
-(void)dismissPresentView:(UIViewController*)sender;
-(void)saveTimeEntry:(NSMutableDictionary*)timeDet;

@end