//
//  mdVisitsViewController.h
//  mediDiary
//
//  Created by Arivoli on 9/26/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"
#import "mdVisitsInfoViewController.h"

@interface mdVisitsViewController : UITableViewController{
    NSMutableArray *profileVisits;
}

@property (strong, nonatomic)  id currentProfileId;

@end
