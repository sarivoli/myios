//
//  mdProfileViewController.m
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdProfileViewController.h"

@interface mdProfileViewController ()

@end

@implementation mdProfileViewController
@synthesize currentProfileId;
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
    NSLog(@"Main profile view loading now");
    [super viewDidLoad];
    NSLog(@"Current Profile id from view %@",currentProfileId);

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"profileInfo"])
        {
        NSLog(@"Profile Info");
        mdProfileViewController *dest = [segue destinationViewController];
        dest.currentProfileId = self.currentProfileId;
        
        //UINavigationViewController *dest = (UINavigationViewController *)segue.destinationViewController;
        //self.detailViewController = dest.topViewController;

        }
    else if([segue.identifier isEqualToString:@"visits"])
        {
        mdVisitsViewController *destv = [segue destinationViewController];
        destv.currentProfileId = self.currentProfileId;

        NSLog(@"Visits");

        }
    else if([segue.identifier isEqualToString:@"addVisits"])
        {
        
        mdAddVisitsViewController *destv = [segue destinationViewController];
        destv.currentProfileId = self.currentProfileId;
        NSLog(@"Add Visits");
        
        }

}



@end
