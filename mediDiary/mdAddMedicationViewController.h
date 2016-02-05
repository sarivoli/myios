//
//  mdAddMedicationViewController.h
//  mediDiary
//
//  Created by Arivoli on 10/9/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"

@interface mdAddMedicationViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtUse;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segFood;
@property (strong, nonatomic)  id visitId;
@property (weak, nonatomic) IBOutlet UIButton *btnM;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnE;
@property (weak, nonatomic) IBOutlet UIButton *btnN;
@property (nonatomic) BOOL imgSelected;

-(IBAction)saveMedication;
@property (strong, nonatomic) IBOutlet UIImageView *imgMedication;

-(IBAction)btnClicked:(id)sender;
- (IBAction)takePhoto:(UIButton *)sender;
//- (IBAction)pickPhoto:(UIButton *)sender;

@end
