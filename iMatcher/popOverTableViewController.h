//
//  popOverTableViewController.h
//  iMatcher
//
//  Created by Arivoli on 12/25/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
@protocol PopViewControllerDelegate;    // Declare a protocol name

@interface popOverTableViewController : UITableViewController
{
    NSArray *starList;
    //porutham *por;
    
}
@property(nonatomic) NSString *cameFrom;

@property(nonatomic) NSMutableDictionary *selStar;

@property (weak) id <PopViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *strGender;
@end

@protocol PopViewControllerDelegate <NSObject>
@required
- (void)dismissPop:(NSString *)gender :(NSArray *)value;

@end
