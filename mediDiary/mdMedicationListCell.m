//
//  mdMedicationListCell.m
//  mediDiary
//
//  Created by Arivoli on 3/15/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import "mdMedicationListCell.h"

@implementation mdMedicationListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClicks:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnCellAtIndex:withData:)]) {
        [self.delegate didClickOnCellAtIndex:_cellIndex withData:sender];
    }
}
@end
