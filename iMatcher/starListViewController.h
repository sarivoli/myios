//
//  starListViewController.h
//  iMatcher
//
//  Created by S Arivoli on 10/7/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
#import "matchViewController.h"
#import "profileViewController.h"
//#import "rasiListViewController.h"

@interface starListViewController : UITableViewController
{
    NSArray *starList;
    //porutham *por;
    
}
@property(nonatomic) NSString *gender;
@property(nonatomic) NSString *cameFrom;

@property(nonatomic) NSMutableDictionary *selStar;


@end
