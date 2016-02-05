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
@synthesize visitTableViewCtrl,profileInfoViewCtrl;
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
        mdViewProfileInfoViewController *dest = [segue destinationViewController];
        dest.currentProfileId = self.currentProfileId;
            self.profileInfoViewCtrl    = dest;
           // self.profileInfoViewCtrl = dest;
            //[dest.tableView setDelegate:self.visitViewCtrl];
        
        //UINavigationViewController *dest = (UINavigationViewController *)segue.destinationViewController;
        //self.detailViewController = dest.topViewController;

        }
    else if([segue.identifier isEqualToString:@"visits"])
        {
        mdVisitsViewController *destv = [segue destinationViewController];
        destv.currentProfileId = self.currentProfileId;
            //[self.profileInfoViewCtrl.tableView setDelegate:destv];
            //UITableViewController *myNav = (UITableViewController *) segue.destinationViewController;
            
            //self.visitViewCtrl = myNav;
            self.profileInfoViewCtrl.vvdelegate = destv;

        NSLog(@"Visits");

        }
   
}



-(IBAction)addVisits:(id)sender{
    NSLog(@"Add Visits");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
    mdAddVisitsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"addVisitView"];
    viewController.currentProfileId = self.currentProfileId;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


@end
