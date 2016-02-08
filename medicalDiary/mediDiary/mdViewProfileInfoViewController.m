//
//  mdViewProfileInfoViewController.m
//  mediDiary
//
//  Created by Arivoli on 1/6/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import "mdViewProfileInfoViewController.h"

@interface mdViewProfileInfoViewController ()

@end

@implementation mdViewProfileInfoViewController
@synthesize lblProfileName,lblAge,lblBgroup,lblGender,currentProfileId;
@synthesize vvdelegate;

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
    
    NSLog(@"New -------- Profile view controller is loading now...:");
    NSLog(@"from View: %@",currentProfileId);
    mdDiary *mdd=[[mdDiary alloc]init];
    NSMutableDictionary *profileInfo = [mdd getProfileInfo:currentProfileId];
    [self.lblProfileName setText:[profileInfo objectForKey:@"name"]];
    [self.lblBgroup setText:[profileInfo objectForKey:@"bgroup"]];
    [self.lblGender setText:[profileInfo objectForKey:@"gender"]];
    NSLog(@"DOB: %@",[profileInfo objectForKey:@"dob"]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:[dateFormatter dateFromString: [profileInfo objectForKey:@"dob"]]
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    [self.lblAge setText:[NSString stringWithFormat:@"%ld",(long)age]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)doActions:(id)sender{
    if([self.segControls selectedSegmentIndex]==1){
        NSLog(@"Add Visits");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
        mdAddVisitsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"addVisitView"];
        viewController.currentProfileId = self.currentProfileId;
        
        [self.navigationController pushViewController:viewController animated:YES];
        
        //[self.navigationController pushViewController:destv animated:YES];
        //[[self.parentViewController navigationController] pushViewController:destv animated:YES];
    }else if([self.segControls selectedSegmentIndex]==0)
    {
        NSLog(@"Edit Visits");
        [self.vvdelegate doEdit];
        //[super view];
        
    }
    
    
}

@end
