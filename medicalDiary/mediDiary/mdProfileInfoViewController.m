//
//  mdProfileInfoViewController.m
//  mediDiary
//
//  Created by Arivoli on 9/26/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdProfileInfoViewController.h"

@interface mdProfileInfoViewController ()

@end

@implementation mdProfileInfoViewController
@synthesize lblProfileName,lblAge,lblBgroup,lblGender,currentProfileId;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Profile view controller is loading now:");
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"viewVisits"])
    {
        NSLog(@"View Visit INfo");
    }
}



@end
