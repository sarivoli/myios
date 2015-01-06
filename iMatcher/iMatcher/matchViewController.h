//
//  matchViewController.h
//  iMatcher
//
//  Created by S Arivoli on 10/7/12.
//  Copyright (c) 2012 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

#import "porutham.h"
#import "poruthamViewController.h"
#define MALE @"Male"
#define FEMALE @"Female"

@interface matchViewController : UITableViewController <ADBannerViewDelegate>
{
    IBOutlet UIButton *btnSelFMaleStar, *btnSelMaleStar;
    IBOutlet UILabel *lblMaleStar, *lblMaleRasi, *lblFemaleStar, *lblFemaleRasi, *lblResult, *lblScore;
    IBOutlet UIImageView *imgFemaleAvatar, *imgMaleAvatar;
    
    ADBannerView *adView;
    BOOL bannerIsVisible;
    
    porutham *por;
    
}

-(IBAction)getStarList:(id)sender;
-(IBAction)getMatchInfo:(id)sender;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;


-(void)assignInfo:(NSString*)gender valueArr:(NSArray*)val;

@property (nonatomic,assign) BOOL bannerIsVisible;


@end
