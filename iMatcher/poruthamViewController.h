//
//  poruthamViewController.h
//  iMatcher
//
//  Created by Arivoli on 11/28/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
#import "matchCell.h"
@interface poruthamViewController : UITableViewController
{
    
    porutham *por;
    NSDictionary *matchDetails; //Result porutham details based on matchInfo
    NSArray *poruthamList; //To list all available porutham

}
@property(nonatomic) NSArray *matchInfo; //to store Male and Female star and rasi info

@end
