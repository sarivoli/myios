//
//  mdSummaryForNowViewController.h
//  mediDiary
//
//  Created by Arivoli on 4/2/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"
#import "mdImgViewController.h"


@interface mdSummaryForNowViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *sessions;
    NSMutableDictionary *currentMedicationList;
    NSMutableDictionary *currentProfileInfo;
    mdDiary *md;
}
@property (strong, nonatomic) IBOutlet UILabel *lblSlideNo;
@property (nonatomic)  int currentIndex;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segSessions;
@property (strong, nonatomic) IBOutlet UITableView *tblSummaryList;
@property (nonatomic) NSString* currentProfileId;
//@property (nonatomic) NSDictionary* currentMedicationList;
-(IBAction)viewImage:(NSInteger)index;

@end
