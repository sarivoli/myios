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
@synthesize txtName,txtUse,segFood,visitId,btnA,btnE,btnM,btnN;
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
    [btnM setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [btnA setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
     [btnE setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
     [btnN setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
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
    NSString *freq =[[NSString alloc] init];
 
    freq =[NSString stringWithFormat:@"%u,%u,%u,%u",[btnM state],[btnA state],[btnE state],[btnN state]];
    NSLog(@"Selected Sate %@",freq);
    [medicationInfo setObject:freq forKey:@"freq"];
    [medicationInfo setObject:[NSString stringWithFormat:@"%i",[segFood selectedSegmentIndex]] forKey:@"food"];
    
    
   [md addMedications:medicationInfo];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Successfully Saved %@",medicationInfo);
    
}

-(IBAction)btnClicked:(UIButton*)sender{
    sender.selected=!sender.selected;
    
}

@end
