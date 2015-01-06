//
//  mdAddMedicationViewController.m
//  mediDiary
//
//  Created by Arivoli on 10/9/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdAddMedicationViewController.h"

@interface mdAddMedicationViewController ()

@end

@implementation mdAddMedicationViewController
@synthesize txtName,txtUse,segFood,segFreq,visitId;
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveMedication{
    mdDiary *md=[[mdDiary alloc]init];
    
    NSMutableDictionary *medicationInfo=[[NSMutableDictionary alloc]init];
    [medicationInfo setObject:visitId  forKey:@"profileid"];
    [medicationInfo setObject:[txtName text]  forKey:@"name"];
    

    [medicationInfo setObject: [txtUse text] forKey:@"use"];
    
    //[medicationInfo setObject:[segFreq selectedSegmentIndex]  forKey:@"freq"];
//   [medicationInfo setObject:[segFood selectedSegmentIndex]  forKey:@"food"];
    
    
    
 //   [md addMedication:medicationInfo];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Successfully Saved %@",medicationInfo);
    
}



@end
