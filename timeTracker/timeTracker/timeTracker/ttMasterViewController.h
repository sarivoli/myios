//
//  ttMasterViewController.h
//  timeTracker
//
//  Created by Arivoli on 12/20/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttProjects.h"
#import "ttDetailCollectionViewController.h"
#import "ttAddProjectsViewController.h"
#import "ttProjectListCell.h"
#import "ttAddTaskViewController.h"
@class ttDetailCollectionViewController;

@interface ttMasterViewController : UITableViewController<UIPopoverControllerDelegate,PopViewControllerDelegate>
{
    ttProjects *myProject;
    NSMutableArray *projects;
    UIPopoverController *popoverController;
    UIBarButtonItem *addButton;
    ttAddProjectsViewController *viewAddProj;
    
}

@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) ttDetailCollectionViewController *detailViewController;

//@property (strong, nonatomic) UICollectionViewController *detailViewCtrl;



- (void)addNewProject:(id)sender;

@end
