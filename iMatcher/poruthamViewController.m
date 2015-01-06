//
//  poruthamViewController.m
//  iMatcher
//
//  Created by Arivoli on 11/28/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "poruthamViewController.h"
#define kUthamam  @"Uthamam" //Good
#define kMathimam @"Mathimam" //Not Bad
#define kAthamam @"Athamam" //Bad
@interface poruthamViewController ()

@end

@implementation poruthamViewController
@synthesize matchInfo;

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
    [super viewDidLoad];
    [super viewDidLoad];
    por = [[porutham alloc]init];
    poruthamList = [por getPoruthamList];
    matchDetails = [[NSDictionary alloc]init];
    self.title = @"Porutham";
    //self.tableView.backgroundColor= [UIColor colorWithPatternImage: [UIImage imageNamed:@"paperback.jpg"]];
    [[self tableView]setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
    //[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperback.jpg"]]];
    
    
    
    //Retrieve all match results
    //NSLog(@"match information %@", matchInfo);
    matchDetails = [por getPoruthamResult:[matchInfo objectAtIndex:0] girlStar:[matchInfo objectAtIndex:1]];
    //NSLog(@"match Details %@", matchDetails);



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [poruthamList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    matchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[matchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //[cell setBackgroundColor:[UIColor redColor]];
    NSDictionary *res = [poruthamList objectAtIndex:indexPath.row];
    //NSLog(@"%@",[res objectForKey:@"mandatory"]);
    if([[res objectForKey:@"mandatory"] isEqualToString:@"Y"])
        {
        //TODO: write code to hilight mandatory porutham
        
        }
    //NSLog(@"%@",[[matchDetails objectForKey:[res objectForKey:@"idn"]] lowercaseString]);
    NSString *imgName = [[NSString alloc] initWithFormat:@"%@.png",
                         [matchDetails objectForKey:[res objectForKey:@"idn"]]] ;
    [[cell imgResult]setImage:[UIImage imageNamed: [imgName lowercaseString]]];
    //if([matchDetails objectForKey:[res objectForKey:@"idn"]]!=kAthamam){
    //    [[cell imgResult] setImage:[UIImage imageNamed:@"redheart.png"]];
    // }
    cell.backgroundColor = [UIColor clearColor];
    [[cell lblResult]setText:[matchDetails objectForKey:[res objectForKey:@"idn"]]];
    [[cell lblMatchTitle]setText:[res objectForKey:@"name"]];
    [[cell lblMatchDesc]setText:[res objectForKey:@"desc"]];
    [cell setPoruthamIdn:[[res objectForKey:@"idn"]intValue]];
    cell.vParent = self;
    
    //NSLog(@"value for porutham %@",[matchDetails objectForKey:[res objectForKey:@"idn"]]);

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
