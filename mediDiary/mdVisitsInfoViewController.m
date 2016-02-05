//
//  mdVisitsInfoViewController.m
//  mediDiary
//
//  Created by Arivoli on 10/1/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdVisitsInfoViewController.h"

@interface mdVisitsInfoViewController ()

@end

@implementation mdVisitsInfoViewController
@synthesize lblDrName,visitId,lblHospital;
@synthesize txtDescWithPhone;

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
    mdDiary *mdd=[[mdDiary alloc]init];
    NSMutableDictionary *visitInfo =[[NSMutableDictionary alloc] init];
    visitInfo = [mdd getVisitInfo:self.visitId];
    self.title =[visitInfo objectForKey:@"visitdate"];
    [lblDrName setText:[visitInfo objectForKey:@"drname"]];
    //[lblContactInfo setText:[visitInfo objectForKey:@"contactinfo"]];
    [lblHospital setText:[visitInfo objectForKey:@"hospital"]];
    //[lblReason setText:[visitInfo objectForKey:@"reason"]];
    NSString *desc= [NSString stringWithFormat:@"%@ \n %@",[visitInfo objectForKey:@"contactinfo"],[visitInfo objectForKey:@"reason"]];
    [txtDescWithPhone setText:desc];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"mediList"])
    {
        NSLog(@"Medication List view Info");
        mdMedicationListController *dest = [segue destinationViewController];
        dest.visitId = self.visitId;
        
        
    }
    else if([segue.identifier isEqualToString:@"addMedication"])
    {
        NSLog(@"Add Medication");
        mdAddMedicationViewController *dest=[segue destinationViewController];
        dest.visitId = self.visitId;

        
    }
    
}



@end
