//
//  mdAddProfViewController.m
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdAddProfViewController.h"

@interface mdAddProfViewController ()

@end

@implementation mdAddProfViewController
@synthesize txtName,txtBgroup,txtRelation,segGender,txtDOB;
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
    //UIDatePicker *itsDatePicker = [[UIDatePicker alloc] init];
    //UIBarButtonItem *itsRightBarButton = [[UIBarButtonItem alloc]init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveProf{
    mdDiary *mdd=[[mdDiary alloc]init];
    NSMutableDictionary *profileInfo=[[NSMutableDictionary alloc]init];
    [profileInfo setObject:[txtName text]  forKey:@"name"];
    [profileInfo setObject:[txtBgroup text]  forKey:@"bgroup"];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"mm'/'dd'/'yyyy"];
    [profileInfo setObject: [txtDOB text] forKey:@"dob"];
    
    if([segGender selectedSegmentIndex]==0){
        [profileInfo setObject:@"Male"  forKey:@"gender"];
    }else{
        [profileInfo setObject:@"FeMale"  forKey:@"gender"];

    }
    [profileInfo setObject:[txtRelation text]  forKey:@"relation"];
    [profileInfo setObject:@"" forKey:@"notes"];


    [mdd addProfile:profileInfo];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Successfully Saved %@",profileInfo);
    
    
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
    if ([textField isEqual:txtDOB])
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
    txtDOB.text = [dateFormatter stringFromDate:[itsDatePicker date]];
}
-(IBAction)dismissKeyboard{
    [self.view endEditing:YES];
}

@end
