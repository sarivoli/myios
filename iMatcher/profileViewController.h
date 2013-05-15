//
//  profileViewController.h
//  iMatcher
//
//  Created by S Arivoli on 11/6/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
#import "starListViewController.h"
#import "popOverTableViewController.h"
#import "languageViewController.h"
@interface profileViewController : UITableViewController <UIPopoverControllerDelegate,PopViewControllerDelegate>
{
    IBOutlet UISegmentedControl *userGender;
    IBOutlet UILabel *lblUserStar, *lblUserRasi, *lblLanguage;
    IBOutlet UISwitch *swDefault;
    porutham *por;
    
    UIPopoverController *popoverController;

}
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) UIPopoverController *popoverController;
@property (strong, nonatomic) popOverTableViewController *pvc;
@property (strong, nonatomic) languageViewController *lang;
-(IBAction)saveGender;
-(IBAction)saveDefault;
-(void)populateProfile;
-(IBAction)doneForiPad:(id)sender;
-(IBAction)openAppReview:(id)sender;
@end
