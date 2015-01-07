//
//  mdViewProfileInfoViewController.h
//  mediDiary
//
//  Created by Arivoli on 1/6/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "mdDiary.h"
#import "mdAddVisitsViewController.h"
@protocol fromProfileVisitViewDelegate;

@interface mdViewProfileInfoViewController : UIViewController
@property (strong, nonatomic)  id currentProfileId;
@property (strong, nonatomic) IBOutlet UILabel *lblProfileName;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblBgroup;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControls;
@property (weak) id <fromProfileVisitViewDelegate> vvdelegate;

-(IBAction)doActions:(id)sender;
@end


@protocol fromProfileVisitViewDelegate <NSObject>
@required
- (void)doEdit;
-(void)doDelete;
@end
