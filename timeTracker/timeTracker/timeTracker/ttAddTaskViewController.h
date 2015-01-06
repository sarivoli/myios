//
//  ttAddTaskViewController.h
//  timeTracker
//
//  Created by Arivoli on 1/9/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol taskControllerDelegate;


@interface ttAddTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtTaskName;
@property (strong, nonatomic) IBOutlet UITextField *txtTaskDec;
@property (strong, nonatomic) IBOutlet UISlider *sldPriority;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblPriorityVal;
@property (strong, nonatomic)  NSString *currentPid;


@property(weak)id<taskControllerDelegate> delegate;


-(IBAction)saveTaskForm;
- (IBAction)dismissPop;
- (IBAction)setPriority;
@end

@protocol taskControllerDelegate <NSObject>
@required
- (void)hideProjPopover;
-(void)addTaskInfo:(NSMutableDictionary *)taskData;
//-(void)refReshProjList;

@end

