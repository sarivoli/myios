//
//  aboutmeViewController.m
//  iMatcher
//
//  Created by S Arivoli on 11/10/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "aboutmeViewController.h"

@interface aboutmeViewController ()

@end

@implementation aboutmeViewController

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
    NSError* error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource: @"aboutme" ofType: @"html"];
    NSString *res = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error: &error];
    [htmlView loadHTMLString:res baseURL:nil];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
