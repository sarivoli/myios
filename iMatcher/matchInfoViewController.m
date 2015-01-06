//
//  matchInfoViewController.m
//  iMatcher
//
//  Created by S Arivoli on 11/20/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "matchInfoViewController.h"

@interface matchInfoViewController ()

@end

@implementation matchInfoViewController
@synthesize poruthamInfo;
@synthesize lblTitle;
@synthesize txtPorDesc;

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
   // [[self view] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"paperback.jpg"]]];
    [lblTitle setText:[NSString stringWithFormat:@"%@ Porutham",[poruthamInfo objectForKey:@"title"]]];
    [txtPorDesc setText:[poruthamInfo objectForKey:@"desc"]];


    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLblTitle:nil];
    [self setTxtPorDesc:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)dismissView:(id)sender{
    
    //[self setModalPresentationStyle:UIModalPresentationFullScreen];
    //[self setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    // [[self parentViewController] viewWillAppear:YES];
    //[[self parentViewController] viewWillAppear:YES];
    if ([self.presentingViewController respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
    }
    //    [self dismissViewControllerAnimated:YES];
}
-(void)setPoruthamDetails:(int)Idn{
    //NSLog(@"porutham idn is %i",Idn);
    poruthamInfo = [[NSMutableDictionary alloc]init];
    porutham *por =[[porutham alloc]init];
    poruthamInfo = [por getPoruthamInfo:Idn];
    //NSLog(@"Porutham title %@", [poruthamInfo objectForKey:@"title"]);
    
}

@end
