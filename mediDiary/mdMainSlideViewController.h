//
//  mdMainSlideViewController.h
//  mediDiary
//
//  Created by Arivoli on 4/2/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mdSummaryForNowViewController.h"
#import "mdDiary.h"
@interface mdMainSlideViewController : UIPageViewController<UIPageViewControllerDataSource>
{
    int pageIndex;
    NSMutableArray *profileList;
    
}
@property (strong, nonatomic) UIPageViewController *pageController;

@end
