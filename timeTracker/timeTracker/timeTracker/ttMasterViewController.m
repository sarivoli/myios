//
//  ttMasterViewController.m
//  timeTracker
//
//  Created by Arivoli on 12/20/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "ttMasterViewController.h"


@interface ttMasterViewController () {
    //   NSMutableArray *_objects;
}
@end

@implementation ttMasterViewController
@synthesize currentPopoverSegue;


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[ttProjects initialize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refReshProjList) name:@"refreshProjList" object:nil];
    
    myProject = [[ttProjects alloc]init];
    projects = [[NSMutableArray alloc]init];
    projects = [myProject getProjectList];
    
    //FMDatabase *db = [FMDatabase databaseWithPath:@"/tmp/tmp.db"];

	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"appBackImage2.png"]]];

    addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewProject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    //self.detailViewController
    self.detailViewController = (ttDetailCollectionViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewProject:(id)sender
{
    /*if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];*/
    viewAddProj = [[ttAddProjectsViewController alloc]init];
    
    popoverController = [[UIPopoverController alloc] initWithContentViewController:viewAddProj];
    viewAddProj.delegate = self;
    //popoverController.delegate = self;
    [popoverController presentPopoverFromBarButtonItem:addButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //[popoverController presentPopoverFromRect:self.view.bounds  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ttProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appBackImage.png"]]];
    //[cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appBackImage.png"]]];

    NSMutableDictionary *rec = projects[indexPath.row];
    cell.lblProjName.text= [rec objectForKey:@"pname"];
    cell.lblTaskCount.text= [rec objectForKey:@"cnt"];
    
    //NSDecimalNumber *tothDN= [[NSDecimalNumber alloc] initWithInt:[[rec objectForKey:@"totm"] integerValue]];
    //[tothDN decimalNumberByDividingBy:60];
    //-(float)getTotalHours:(int)hours minutes:(int)mins{

    cell.lblTotHours.text = [NSString stringWithFormat:@"%.2lf",[myProject getTotalHours:[[rec objectForKey:@"toth"] integerValue] minutes:[[rec objectForKey:@"totm"] integerValue]]] ;
    //
    
    //cell.textLabel.text = [rec objectForKey:@"pname"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"edited at %ld",(long)[indexPath row]);
        [myProject deleteProject:[[projects objectAtIndex:indexPath.row] objectForKey:@"pid"]];
        //[projects removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self refReshProjList];


    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }*/
    self.detailViewController.taskLists = [myProject getTaskListForProject:[[projects objectAtIndex:indexPath.row] objectForKey:@"pid"]];
    self.detailViewController.currentProj =[[projects objectAtIndex:indexPath.row] objectForKey:@"pid"];
    
    // [[self.detailViewController collectionView] reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   /* if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }*/
    currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;

}
-(void)addProject:(NSMutableDictionary *)projectDet
{
    [myProject addProjects:projectDet];
    [self hideProjPopover];
    [self refReshProjList];
}

-(void)hideProjPopover{
    //  [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss
    [popoverController dismissPopoverAnimated:YES];
}
-(void)refReshProjList{
    projects = [myProject getProjectList];
    [self.tableView reloadData];
}

@end
