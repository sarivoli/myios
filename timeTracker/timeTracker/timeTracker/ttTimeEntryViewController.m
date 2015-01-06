//
//  ttTimeEntryViewController.m
//  timeTracker
//
//  Created by Arivoli on 1/10/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import "ttTimeEntryViewController.h"

@interface ttTimeEntryViewController ()

@end

@implementation ttTimeEntryViewController

@synthesize lblTimeBoard,lblTaskName,lblProjName;
@synthesize segDate,segHours,segMins;
@synthesize txtNote;
@synthesize taskInfo;


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
    hoursDict =[[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    minsDict = [[NSMutableArray alloc]initWithObjects:@"0",@"10",@"20",@"30",@"40",@"50",@"60", nil];
    dateDict=[[NSMutableArray alloc]initWithObjects:@"10/10/2013",@"02/01/2014", nil];
    lblProjName.text = [taskInfo objectForKey:@"pname"];
    lblTaskName.text = [taskInfo objectForKey:@"tname"];
    lblTimeBoard.text = @"00:00";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveTimeEntryForm
{
    NSMutableDictionary *timeDet =[[NSMutableDictionary alloc] init];
    
    [timeDet setObject:[hoursDict objectAtIndex:[segHours selectedSegmentIndex]] forKey:@"hours"];
    [timeDet setObject:[minsDict objectAtIndex:[segMins selectedSegmentIndex]] forKey:@"mins"];
    [timeDet setObject:[dateDict objectAtIndex:[segDate selectedSegmentIndex]] forKey:@"date"];
    [timeDet setObject:txtNote.text forKey:@"note"];
    [timeDet setObject:[taskInfo objectForKey:@"tid"] forKey:@"tid"];
    
    [self.delegate saveTimeEntry:timeDet];
    [self.delegate dismissPresentView:self];

}
-(void)closeTimeEntryFrom
{
    [self.delegate dismissPresentView:self];
}

-(IBAction)setTime{
    lblTimeBoard.text = [NSString stringWithFormat:@"0%@:%@",[hoursDict objectAtIndex:[segHours selectedSegmentIndex]],[minsDict objectAtIndex:[segMins selectedSegmentIndex]]];
    
}

@end
