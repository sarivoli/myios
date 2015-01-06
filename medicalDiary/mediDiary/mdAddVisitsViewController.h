//
//  mdAddVisitsViewController.h
//  mediDiary
//
//  Created by Arivoli on 9/29/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"
@interface mdAddVisitsViewController : UIViewController
{
    UIDatePicker *itsDatePicker;

}
@property (strong, nonatomic) IBOutlet UITextField *txtVisitDate;
@property (strong, nonatomic) IBOutlet UITextField *txtHospitalName;
@property (strong, nonatomic) IBOutlet UITextField *txtDrName;
@property (strong, nonatomic) IBOutlet UITextField *txtContactInfo;
@property (strong, nonatomic) IBOutlet UITextField *txtReason;

@property (strong, nonatomic)  id currentProfileId;


-(IBAction)dismissKeyboard;
-(IBAction)saveVisits;
@end
