//
//  mdAddMedicationViewController.h
//  mediDiary
//
//  Created by Arivoli on 10/9/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"

@interface mdAddMedicationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtUse;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segFood;
@property (strong, nonatomic)  id visitId;
@property (weak, nonatomic) IBOutlet UIButton *btnM;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnE;
@property (weak, nonatomic) IBOutlet UIButton *btnN;

-(IBAction)saveMedication;
-(IBAction)btnClicked:(id)sender;
@end
