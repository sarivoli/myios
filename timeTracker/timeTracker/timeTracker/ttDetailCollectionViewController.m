//
//  ttDetailCollectionViewController.m
//  timeTracker
//
//  Created by Arivoli on 1/7/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import "ttDetailCollectionViewController.h"

@interface ttDetailCollectionViewController ()

@end

@implementation ttDetailCollectionViewController
@synthesize currentSorting,currentView,selectedTask,currentProjeInfo;



- (void)setTaskLists:(id)newTaskList
{
    if (_taskLists != newTaskList) {
        _taskLists = newTaskList;
        
        // Update the view.
        [self reloadTaskList];
    }
    
}
- (void)setCurrentProj:(id)projectId
{
    if (_currentProj != projectId) {
        _currentProj = projectId;
        
        // Update the view.
        [self refreshHeader];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    currentView = [NSString stringWithFormat:@""];
    currentSorting = [NSString stringWithFormat:@""];
    selectedTask = [NSString stringWithFormat:@""];
    //currentProj=[NSString stringWithFormat:@""];
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    //projects = [[NSMutableArray alloc]init];
    self.taskLists = [myProject getTaskList];
    [self refreshHeader];


    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myProject = [[ttProjects alloc]init];

    [self.collectionView  setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"appBackImage"]]];
    self.selectedTask =@"";
    
    //[self attachTooBarButtons];

    //[self.collectionView registerNib:[UINib nibWithNibName:@"poruthamCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"poruthamCellV"];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return   self.taskLists.count;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    ttTaskCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [[cell lblTaskName] setText:[[self.taskLists objectAtIndex:indexPath.row] objectForKey:@"tname"]];
    
    [[cell lblTotalHrs] setText:[NSString stringWithFormat:@"%.2lf",[myProject getTotalHours:[[self.taskLists objectAtIndex:indexPath.row]objectForKey:@"thrs"]  minutes:[[self.taskLists objectAtIndex:indexPath.row]objectForKey:@"tmns"]]]];
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    //NSMutableDictionary *selectedTaskInfo =[[NSMutableDictionary alloc] init];
    //selectedTaskInfo = [self.taskLists objectAtIndex:indexPath.row];
    ttTimeEntryViewController  *ctlTimeEntry = [[ttTimeEntryViewController alloc] init];
    [ctlTimeEntry setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [ctlTimeEntry setModalPresentationStyle:UIModalPresentationFormSheet];
    ctlTimeEntry.delegate = self;
    //ctlTimeEntry.lblProjName.text = [selectedTaskInfo objectForKey:@"pname"];
    //ctlTimeEntry.lblTaskName.text = [selectedTaskInfo objectForKey:@"tname"];
    ctlTimeEntry.taskInfo = [self.taskLists objectAtIndex:indexPath.row];
    //self.selectedTask =   [selectedTaskInfo objectForKey:@"tid"];

    [self presentViewController:ctlTimeEntry animated:YES completion:nil];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 213);
}

-(void)reloadTaskList{
    [self.collectionView reloadData];
    
}
-(void)refreshHeader{
    //NSLog(@"Current Project : %@ -",self.currentProj);
    if(self.currentProj ==NULL)
        {
            self.title = @"Recent Tasks";
            self.currentProjeInfo=nil;
        }else{
            ttProjects *cProject = [[ttProjects alloc]init];
            self.currentProjeInfo = [cProject getProjectInfo:self.currentProj];
            self.title=[NSString stringWithFormat:@"%@ Tasks", [currentProjeInfo objectForKey:@"pname"]];
        }
    [self attachTooBarButtons];
        
}
-(void)attachTooBarButtons
{
    //toolBarVieww =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];

    NSMutableArray *toolBarButtons = [[NSMutableArray alloc]init];
    if(self.currentProj!=NULL)
        {
            UIBarButtonItem *btnAddTask = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddTaskForm)];
            [toolBarButtons addObject:btnAddTask];
        }
    UISegmentedControl *segTaskView =[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:[UIImage imageNamed:@"clock.png"],[UIImage imageNamed:@"task.png"],nil]];
    segTaskView.segmentedControlStyle = UISegmentedControlStyleBar;
    
    UIBarButtonItem *btnSeg =[[UIBarButtonItem alloc]initWithCustomView:segTaskView];
    [toolBarButtons addObject:btnSeg];
    
    //    UIBarButtonItem *btnAddTask = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTask)];
    //[toolBarButtons addObject:btnAddTask];
    
    
    self.navigationItem.rightBarButtonItems = toolBarButtons;
}
-(void)showAddTaskForm{
    viewAddTask =[[ttAddTaskViewController alloc]init];
    viewAddTask.currentPid = self.currentProj;
    addTaskPopOver=[[UIPopoverController alloc]initWithContentViewController:viewAddTask];
    viewAddTask.delegate=self;
    [addTaskPopOver presentPopoverFromBarButtonItem:[self.navigationItem.rightBarButtonItems objectAtIndex:0] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
-(void)addTaskInfo:(NSMutableDictionary *)taskData
{
    [myProject addTask:taskData];
    [self hideProjPopover];
    self.taskLists = [myProject getTaskListForProject:self.currentProj];
    [self reloadTaskList];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProjList" object:nil];
   // [self.masterDelegate refReshProjList];
    
}
-(void)hideProjPopover{
    //  [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss
    [addTaskPopOver dismissPopoverAnimated:YES];
}

-(void)dismissPresentView:(UIViewController*)sender{
    //[self dismissPresentView:sender];
    [sender dismissViewControllerAnimated:YES completion:nil];
    //        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveTimeEntry:(NSMutableDictionary*)timeDet{
    NSLog(@"Saving time entry");
    [myProject addTimeEntry:timeDet];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProjList" object:nil];


}


@end
