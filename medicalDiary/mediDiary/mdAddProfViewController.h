//
//  mdAddProfViewController.h
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"
@interface mdAddProfViewController : UIViewController
{
    //UIBarButtonItem *itsRightBarButton;
    UIDatePicker *itsDatePicker;
}
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtRelation;
@property (strong, nonatomic) IBOutlet UITextField *txtDOB;
@property (strong, nonatomic) IBOutlet UITextField *txtBgroup;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segGender;
-(IBAction)saveProf;
-(IBAction)dismissKeyboard;

@end
