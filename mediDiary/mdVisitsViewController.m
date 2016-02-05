//
//  mdVisitsViewController.m
//  mediDiary
//
//  Created by Arivoli on 9/26/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdVisitsViewController.h"

@interface mdVisitsViewController ()

@end

@implementation mdVisitsViewController
@synthesize currentProfileId;

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
    profileVisits = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    NSLog(@"from Visits: %@",currentProfileId);
    
    
    
    

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Visits";
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    mdVisitsHeaderViewController *customHeader = [[mdVisitsHeaderViewController alloc]init];
    
    return [customHeader view];
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [profileVisits count];
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
    [[cell textLabel] setText:[[profileVisits objectAtIndex:indexPath.row] objectForKey:@"visitdate"]];
    [[cell detailTextLabel] setText:[[profileVisits objectAtIndex:indexPath.row] objectForKey:@"hospital"]];
        
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"Deleting the entry from row  %@",[profileVisits[indexPath.row] objectForKey:@"visitid"]);
        mdDiary *mdbase=[[mdDiary alloc]init];
        [mdbase delVisits: [profileVisits[indexPath.row] objectForKey:@"visitid"]];
       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self refreshVisitData];

        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"View is reloading from profile view info++++");
    [self refreshVisitData];
    [self.tableView setEditing:FALSE];

        /*if([profileVisits count]==0){
        NSMutableDictionary *noResult=[[NSMutableDictionary alloc]init];
        [noResult setObject:@"No Visits Found" forKey:@"visitdate"];
        [noResult setObject:@"" forKey:@"hospital"];
        [profileVisits addObject:noResult];
    }*/

    //NSString *gen,*starName, *rasiName, *defalt = [[NSString alloc]init];
    
    
    //[por saveUserInfo:userInfo];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"visitsInfo"])
    {
        NSLog(@"Visit Info");
        mdVisitsInfoViewController *dest = [segue destinationViewController];
        dest.visitId = [[profileVisits objectAtIndex:[[self.tableView indexPathForSelectedRow] row] ] objectForKey:@"visitid"];

        
    }
   
}
-(void)refreshVisitData{
    mdDiary *mdbase=[[mdDiary alloc]init];
    profileVisits = [mdbase getProfileVisits:currentProfileId];
    [self.tableView reloadData];
}
-(void)doEdit{
    NSLog(@"Yes coming for edit");
    [self.tableView setEditing:true];
}
-(void)doDelete{
    NSLog(@"Yes coming for delete");
    
}


@end
