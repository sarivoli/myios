//
//  matchCell.h
//  iMatcher
//
//  Created by S Arivoli on 11/18/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "matchInfoViewController.h"
@interface matchCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblMatchTitle;
@property (strong, nonatomic) IBOutlet UIViewController *vParent;

@property (strong, nonatomic) IBOutlet UIImageView *imgResult;
@property (strong, nonatomic) IBOutlet UILabel *lblMatchDesc;
@property (strong, nonatomic) IBOutlet UIButton *btnMoreInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblResult;
@property (assign , nonatomic) int poruthamIdn;

-(IBAction)getPoruthamInfo:(id)sender;

@end
