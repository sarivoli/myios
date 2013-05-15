//
//  sMatcherMainViewController.h
//  iMatcher
//
//  Created by Arivoli on 12/11/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
#import "poruthamCell.h"
#import "profileViewController.h"
#import "popOverTableViewController.h"
#define MALE @"Male"
#define FEMALE @"Female"
@interface sMatcherMainViewController : UIViewController <UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, UIPopoverControllerDelegate, PopViewControllerDelegate,  UITableViewDataSource, UITableViewDelegate>
{
    NSArray *starList;
    NSDictionary *matchDetails; //Result porutham details based on matchInfo
    NSArray *poruthamList; //To list all available porutham
    UIPopoverController *popoverController;

    porutham *por;

}
@property(strong,nonatomic)IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *lblGroomStar;
@property (strong, nonatomic) IBOutlet UILabel *lblBrideStar;
@property (strong, nonatomic) IBOutlet UILabel *lblResult;


@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) popOverTableViewController *pvc;
@property (strong, nonatomic) UIPopoverController *popoverController;

-(void)assignInfo:(NSString*)gender valueArr:(NSArray*)val;
-(IBAction)getMyProfile:(id)sender;


@end
