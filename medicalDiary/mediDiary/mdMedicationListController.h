//
//  mdMedicationListController.h
//  mediDiary
//
//  Created by Arivoli on 10/2/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdDiary.h"

@interface mdMedicationListController : UITableViewController
{
    NSMutableArray *medicationList;
}
@property (weak, nonatomic) id visitId;

@end
