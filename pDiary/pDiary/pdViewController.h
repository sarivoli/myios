//
//  pdViewController.h
//  pDiary
//
//  Created by Arivoli on 5/9/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pdMainViewCell.h"

@interface pdViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectV;

@end
