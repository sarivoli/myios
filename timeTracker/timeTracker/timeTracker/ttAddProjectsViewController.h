//
//  ttAddProjectsViewController.h
//  timeTracker
//
//  Created by Arivoli on 12/22/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopViewControllerDelegate;    // Declare a protocol name


@interface ttAddProjectsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtProjName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segType;
@property (strong, nonatomic) IBOutlet UISlider *sldrPriority;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segStatus;
@property (strong, nonatomic) IBOutlet UITextField *txtNote;
@property (strong, nonatomic) IBOutlet UILabel *lblProrityVal;

@property (weak) id <PopViewControllerDelegate> delegate;

-(IBAction)saveProject;
- (IBAction)dismissPop;
- (IBAction)setPriority;


@end


@protocol PopViewControllerDelegate <NSObject>
@required
- (void)hideProjPopover;
-(void)addProject:(NSMutableDictionary *)projectDet;
@end


