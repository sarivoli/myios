//
//  mdAddVisitsViewController.m
//  mediDiary
//
//  Created by Arivoli on 9/29/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdAddVisitsViewController.h"

@interface mdAddVisitsViewController ()

@end

@implementation mdAddVisitsViewController
@synthesize txtContactInfo,txtDrName,txtHospitalName,txtReason,txtVisitDate,currentProfileId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"AddVisits View");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}


- (void) textFieldDidBeginEditing:(UITextField *)textField {
    /*itsRightBarButton.title  = @"Done";
     itsRightBarButton.style = UIBarButtonItemStyleDone;
     itsRightBarButton.target = self;
     itsRightBarButton.action = @selector(doneAction:);*/
    if ([textField isEqual:txtVisitDate])
        {
        itsDatePicker = [[UIDatePicker alloc] init] ;
        itsDatePicker.datePickerMode = UIDatePickerModeDate;
        [itsDatePicker addTarget:self action:@selector(incidentDateValueChanged:) forControlEvents:UIControlEventValueChanged];
        //datePicker.tag = indexPath.row;
        textField.inputView = itsDatePicker;
        }
}
- (IBAction) incidentDateValueChanged:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    txtVisitDate.text = [dateFormatter stringFromDate:[itsDatePicker date]];
}
-(IBAction)dismissKeyboard{
    [self.view endEditing:YES];
}
-(IBAction)saveVisits{
    mdDiary *md=[[mdDiary alloc]init];
    
    NSMutableDictionary *visitsInfo=[[NSMutableDictionary alloc]init];
    [visitsInfo setObject:currentProfileId  forKey:@"profileid"];
    [visitsInfo setObject:[txtDrName text]  forKey:@"drname"];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"mm'/'dd'/'yyyy"];
    [visitsInfo setObject: [txtVisitDate text] forKey:@"visitdate"];
    
    [visitsInfo setObject:[txtHospitalName text]  forKey:@"hospital"];
    [visitsInfo setObject:[txtContactInfo text]  forKey:@"contactinfo"];

    [visitsInfo setObject:[txtReason text] forKey:@"reason"];
    
    
    [md addVisits:visitsInfo];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Successfully Saved %@",visitsInfo);
    
}


@end
