//
//  mdVisitsInfoViewController.h
//  mediDiary
//
//  Created by Arivoli on 10/1/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"
#import "mdMedicationListController.h"
#import "mdAddMedicationViewController.h"
@interface mdVisitsInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblDrName;
//@property (weak, nonatomic) IBOutlet UILabel *lblContactInfo;
@property (strong, nonatomic) IBOutlet UITextView *txtDescWithPhone;
@property (weak, nonatomic) id visitId;
@property (weak, nonatomic) IBOutlet UILabel *lblHospital;
//@property (weak, nonatomic) IBOutlet UILabel *lblReason;

@end
