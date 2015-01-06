//
//  mdProfileInfoViewController.h
//  mediDiary
//
//  Created by Arivoli on 9/26/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"

@interface mdProfileInfoViewController : UITableViewController

@property (strong, nonatomic)  id currentProfileId;
@property (strong, nonatomic) IBOutlet UILabel *lblProfileName;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblBgroup;

@end
