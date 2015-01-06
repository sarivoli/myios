//
//  mdProfileViewController.h
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdVisitsViewController.h"
#import "mdProfileViewController.h"
#import "mdAddVisitsViewController.h"
@interface mdProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *contProfinfo;
@property (strong, nonatomic) IBOutlet UIView *contProfVisit;
@property (strong, nonatomic)  id currentProfileId;



@end
