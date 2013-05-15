//
//  matchInfoViewController.h
//  iMatcher
//
//  Created by S Arivoli on 11/20/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"

@interface matchInfoViewController : UIViewController

@property (strong, nonatomic) NSDictionary *poruthamInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITextView *txtPorDesc;

-(void)setPoruthamDetails:(int)Idn;
-(IBAction)dismissView:(id)sender;
@end
