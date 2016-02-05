//
//  mdMedicationListCell.h
//  mediDiary
//
//  Created by Arivoli on 3/15/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellDelegate <NSObject>
- (IBAction)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data;
@end

@interface mdMedicationListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblMedicationName;
@property (strong, nonatomic) IBOutlet UILabel *lblFrequency;
@property (strong, nonatomic) IBOutlet UILabel *lblMedicationDec;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UIButton *imgMedicationImgIndicator;
@property (strong, nonatomic) IBOutlet UISwitch *swCurTaking;
@property (weak, nonatomic) id<CellDelegate>delegate;
- (IBAction)buttonClicks:(id)sender;
@property (assign, nonatomic) NSInteger cellIndex;
@end

