//
//  ttDetailCollectionViewController.h
//  timeTracker
//
//  Created by Arivoli on 1/7/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttProjects.h"
#import "ttAddTaskViewController.h"
#import "ttTaskCollectionViewCell.h"
#import "ttTimeEntryViewController.h"

@interface ttDetailCollectionViewController : UICollectionViewController <UISplitViewControllerDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout,
    timeEntryProtocol,
    taskControllerDelegate>
{
    ttProjects *myProject;
    ttAddTaskViewController *viewAddTask;
    UIPopoverController *addTaskPopOver;
}
@property(strong,nonatomic)IBOutlet UICollectionView *collectionView;
@property(strong,nonatomic) NSString *selectedTask;
@property (strong, nonatomic) IBOutlet UICollectionView *detailViewCtrl;
@property(strong,nonatomic) NSMutableArray *taskLists;
@property(strong,nonatomic) NSString *currentProj;
@property(strong,nonatomic) NSString *currentView;
@property(strong,nonatomic) NSString *currentSorting;
@property(strong,nonatomic) NSMutableDictionary *currentProjeInfo;


-(void)reloadTaskList;
@end
