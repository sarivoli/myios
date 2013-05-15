//
//  profileViewController.m
//  iMatcher
//
//  Created by S Arivoli on 11/6/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "profileViewController.h"

@interface profileViewController ()

@end
static NSMutableDictionary *userInfo;

@implementation profileViewController

@synthesize currentPopoverSegue;
@synthesize popoverController;
@synthesize pvc,lang;

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
    [super viewDidLoad];
    por = [[porutham alloc]init];
    userInfo = [[NSMutableDictionary alloc]init];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperback.jpg"]]];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self populateProfile];
    //NSString *gen,*starName, *rasiName, *defalt = [[NSString alloc]init];

    
    
    //[por saveUserInfo:userInfo];
}
-(IBAction)saveGender{
    NSString *usergender=[[NSString alloc]initWithFormat:@"M"];
    if([userGender selectedSegmentIndex]==1){
        usergender = @"F";
    }
    [userInfo setValue:usergender forKey:@"gender"];
    [por saveUserInfo:userInfo];

}
-(IBAction)saveDefault{
    NSString *setDefault=[[NSString alloc]initWithFormat:@"N"];
    if([swDefault isOn]){
        setDefault = @"Y";
    }
    [userInfo setValue:setDefault forKey:@"default"];
    [por saveDefault:setDefault];

    //[por saveUserInfo:userInfo];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
    //popOverTableViewController *pvc = [segue destinationViewController];
    //[pvc setDelegate:self];
    //[pvc setStrGender:[segue identifier]];

    NSString *segueName = [segue identifier ];
    
    if([segueName isEqualToString:@"starselection"])
        {
       
        starListViewController *V2=[segue destinationViewController];
         V2.gender = [userInfo objectForKey:@"gender"];        
         V2.cameFrom = @"Profile";
        }else if ([segueName isEqualToString:@"ipadStar"]){
            currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
            pvc = [segue destinationViewController];
            [pvc setDelegate:self];
            [pvc setStrGender:[userInfo objectForKey:@"gender"]];
            
        }else if ([segueName isEqualToString:@"lang"]){
            currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
            lang = [segue destinationViewController];
            [lang setDelegate:self];
    
        }


}
- (void)dismissPop:(NSString *)gender :(NSArray *)value
{
    //[self assignInfo:gender valueArr:value];
    NSMutableDictionary *userinfo = [[NSMutableDictionary alloc]init];
    [userinfo setObject:[[value objectAtIndex:0] objectForKey:@"idn"] forKey:@"star_idn"];
    [userinfo setObject:[[value objectAtIndex:1] objectForKey:@"idn"] forKey:@"rasi_idn"];
    [userinfo setObject:gender forKey:@"gender"];
    
    [por saveUserInfo:userinfo];
    [self populateProfile];
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
    
    
}
- (void)dismissPop
{
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
    [self populateProfile];

}
-(void)populateProfile{
    userInfo = [por getUserInfo];
    NSString *gen = [userInfo objectForKey:@"gender"];
    //NSString *starName = [userInfo objectForKey:@"star_name"];
    //NSString *rasiName = [userInfo objectForKey:@"rasi_name"];
    NSString *defalt =[userInfo objectForKey:@"default"];

    
    if(gen){
        if([gen isEqualToString:@"M"])
            {
            [userGender setSelectedSegmentIndex:0];
            }else {
                [userGender setSelectedSegmentIndex:1];
            }
    }
    if([defalt isEqualToString:@"Y"])
        {
        [swDefault setOn:TRUE];
        }else {
            [swDefault setOn:FALSE];
        }
    [lblUserStar setText: [userInfo objectForKey:@"star_name"]];
    [lblUserRasi setText: [userInfo objectForKey:@"rasi_name"]];
    [lblLanguage setText: [userInfo objectForKey:@"language"]];
    
}

-(IBAction)doneForiPad:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)openAppReview:(id)sender{
    
    NSString* appID = @"583093816"; //app id for smatcher
    //NSLog(@"opening review form");
    //NSString* url = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Arivoli&id=%@", appID];
    
    NSString* url = [NSString stringWithFormat: @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8", appID];
    
    
    //NSLog(@"URL is : %@",url);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==3  && indexPath.section==1){
        //user selected the review button
        [self openAppReview:indexPath];

    }
    
    //NSLog(@"table section %i",indexPath.section);
    //NSLog(@"table selected %i",indexPath.row);
}
@end