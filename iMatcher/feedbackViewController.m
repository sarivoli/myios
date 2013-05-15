//
//  feedbackViewController.m
//  iMatcher
//
//  Created by Arivoli on 12/30/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "feedbackViewController.h"

@interface feedbackViewController ()

@end

@implementation feedbackViewController
@synthesize webFeedback;
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
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://docs.google.com/spreadsheet/viewform?formkey=dEU3V0xMOVJiT3N4S3RqZ3Q0MUhEWmc6MQ#gid=0"]];
    [webFeedback loadRequest:request];	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
