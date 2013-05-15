//
//  languageViewController.h
//  iMatcher
//
//  Created by Arivoli on 1/4/13.
//  Copyright (c) 2013 arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "porutham.h"
@protocol PopViewControllerDelegate;    // Declare a protocol name


@interface languageViewController : UITableViewController{
    porutham *myp;
}
@property(strong,nonatomic)NSArray *languages;

@property (weak) id <PopViewControllerDelegate> delegate;

@end


@protocol PopViewControllerDelegate <NSObject>
@required
- (void)dismissPop;

@end
