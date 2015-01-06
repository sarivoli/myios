//
//  mdHomeViewController.m
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdHomeViewController.h"

@interface mdHomeViewController ()

@end
static mdDiary *md;
static id selProfileID;


@implementation mdHomeViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //NSMutableArray *curProfileList=[[NSMutableArray alloc]init];
    md=[[mdDiary alloc]init];
    curProfileList =[md getProfileList];
    
    
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [curProfileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        //        [[cell textLabel]setText:[urllist objectAtIndex:[indexPath row]]];
    }
    [[cell textLabel] setText:[[curProfileList objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [[cell detailTextLabel] setText:[[curProfileList objectAtIndex:indexPath.row] objectForKey:@"relation"]];
    if([[[curProfileList objectAtIndex:indexPath.row] objectForKey:@"gender"] isEqualToString:@"Male"]){
            [[cell imageView]setImage:[UIImage imageNamed:@"male.png"]];
    }else{
            [[cell imageView]setImage:[UIImage imageNamed:@"female.png"]];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Nothing to add so far

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    curProfileList =[md getProfileList];
    [self.tableView reloadData];
    NSLog(@"View is reloading");
    //NSString *gen,*starName, *rasiName, *defalt = [[NSString alloc]init];
    
    
    //[por saveUserInfo:userInfo];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"addProfile"])
        {
        NSLog(@"Profile Add");
        //UINavigationViewController *dest = (UINavigationViewController *)segue.destinationViewController;
        //self.detailViewController = dest.topViewController;
        
        }
    else if([segue.identifier isEqualToString:@"viewProfile"])
        {
            NSLog(@"Profile View");
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        mdProfileViewController *dest = [segue destinationViewController];
        NSLog(@"Selected row is : %ld",(long)[path row]);
        dest.currentProfileId = [[curProfileList objectAtIndex:path.row] objectForKey:@"id"];

        
        }
}


@end
