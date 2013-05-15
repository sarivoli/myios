//
//  matchResultViewController.h
//  iMatcher
//
//  Created by S Arivoli on 10/10/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
#import "matchCell.h"
@interface matchResultViewController : UITableViewController
{
    porutham *por;
    NSDictionary *matchDetails; //Result porutham details based on matchInfo
    NSArray *poruthamList; //To list all available porutham
    IBOutlet UITableView *tblView;
}


@property(nonatomic) NSArray *matchInfo; //to store Male and Female star and rasi info

@end
