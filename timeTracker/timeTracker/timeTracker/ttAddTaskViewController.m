//
//  ttAddTaskViewController.m
//  timeTracker
//
//  Created by Arivoli on 1/9/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import "ttAddTaskViewController.h"

@interface ttAddTaskViewController ()

@end

@implementation ttAddTaskViewController
@synthesize delegate,currentPid;
@synthesize txtTaskDec,txtTaskName,segStatus,sldPriority;

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
    [self.lblPriorityVal setText:@"P1"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissPop
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    [self.delegate hideProjPopover];
    
}
-(IBAction)saveTaskForm
{
    if([[self.txtTaskName text]  isEqualToString:@""]){
        UIAlertView *nullAlert = [[UIAlertView alloc]initWithTitle:@"Attention" message:@"Please provide Task details" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nullAlert show];
    }else{
        NSMutableDictionary  *taskDict = [[NSMutableDictionary alloc]init];
        [taskDict setObject:currentPid forKey:@"pid"];

        [taskDict setObject:[self.txtTaskName text] forKey:@"tname"];
        [taskDict setObject:[self.txtTaskDec text] forKey:@"desc"];
        [taskDict setObject:[NSString stringWithFormat:@"%i",[self.segStatus selectedSegmentIndex]] forKey:@"type"];
        [taskDict setObject:[NSString stringWithFormat:@"%i",(int)[self.sldPriority value]] forKey:@"priority"];
        [taskDict setObject:[NSString stringWithFormat:@"%i",[self.segStatus selectedSegmentIndex]] forKey:@"status"];
        NSLog(@"Task details.... %@",taskDict);
        //    -(void)addProject:(NSMutableDictionary *)projectDet
        [self.delegate addTaskInfo:taskDict];
        // [self.delegate refReshProjList];
        
        //[self.delegate addProject];
    }
}
- (void)setPriority{
    [self.lblPriorityVal setText:[NSString stringWithFormat:@"P%i",(int)[self.sldPriority value]]];
    
}

@end
