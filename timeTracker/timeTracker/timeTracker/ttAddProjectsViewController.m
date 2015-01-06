//
//  ttAddProjectsViewController.m
//  timeTracker
//
//  Created by Arivoli on 12/22/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "ttAddProjectsViewController.h"

@interface ttAddProjectsViewController ()

@end

@implementation ttAddProjectsViewController
@synthesize delegate;

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
    [self.lblProrityVal setText:@"P1"];

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
-(void)saveProject{
    if([[self.txtProjName text]  isEqualToString:@""]){
        UIAlertView *nullAlert = [[UIAlertView alloc]initWithTitle:@"Attention" message:@"Please provide Project details" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nullAlert show];
    }else{
    NSMutableDictionary  *projectDict = [[NSMutableDictionary alloc]init];
    [projectDict setObject:[self.txtProjName text] forKey:@"pname"];
    [projectDict setObject:[self.txtNote text] forKey:@"desc"];
    [projectDict setObject:[NSString stringWithFormat:@"%i",[self.segType selectedSegmentIndex]] forKey:@"type"];
    [projectDict setObject:[NSString stringWithFormat:@"%i",(int)[self.sldrPriority value]] forKey:@"priority"];
    [projectDict setObject:[NSString stringWithFormat:@"%i",[self.segStatus selectedSegmentIndex]] forKey:@"status"];
    NSLog(@"Project details.... %@",projectDict);
    //    -(void)addProject:(NSMutableDictionary *)projectDet
    [self.delegate addProject:projectDict];

    //[self.delegate addProject];
    }
    
}
- (void)setPriority{
    [self.lblProrityVal setText:[NSString stringWithFormat:@"P%i",(int)[self.sldrPriority value]]];
    
}
@end
