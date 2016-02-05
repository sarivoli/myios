//
//  mdMedicationListController.h
//  mediDiary
//
//  Created by Arivoli on 10/2/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"
#import "mdMedicationListCell.h"
#import "mdImgViewController.h"

@interface mdMedicationListController : UITableViewController <CellDelegate>
{
    NSMutableArray *medicationList;
    //mdImageViewController *imgView;
}
@property (weak, nonatomic) id visitId;
-(IBAction)viewImage:(NSInteger)index;

@end
