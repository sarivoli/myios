//
//  starListViewController.m
//  iMatcher
//
//  Created by S Arivoli on 10/7/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "starListViewController.h"

@interface starListViewController ()

@end

@implementation starListViewController
@synthesize gender, selStar,cameFrom ;


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
    porutham *myp = [[porutham alloc]init];
    starList = [myp getStarInfo:nil];
    NSString *pgTitle = @"Your";
    if(self.gender){
        pgTitle = self.gender;
    }
      [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperback.jpg"]]];
    self.title = [NSString stringWithFormat:@"Select %@ Star",pgTitle];
    //[self.navigationItem setTitle:[NSString stringWithFormat:@"Select %@ Star",self.gender]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [starList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        //        [[cell textLabel]setText:[urllist objectAtIndex:[indexPath row]]];
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellback.png"]]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];

    }
    [[cell textLabel] setText:[[starList objectAtIndex:indexPath.row] objectForKey:@"name"] ];
    [[cell detailTextLabel] setText:[[starList objectAtIndex:indexPath.row] objectForKey:@"rasiDesc"] ];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0 ];

    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    [[cell imageView]setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[starList objectAtIndex:indexPath.row] objectForKey:@"img"]]]];

    //NSLog(@"%@",[[starList objectAtIndex:indexPath.row] objectForKey:@"name"]);
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    //rasiListViewController *rasiLstView = [[rasiListViewController alloc]init];
    self.selStar = [starList objectAtIndex:indexPath.row];
    //rasiLstView.selStar = self.selStar;
    //rasiLstView.gender =self.gender;
    
    porutham *myp = [[porutham alloc]init];
    NSArray *selRasi=[[NSArray alloc] initWithArray:[myp getRasiInfo:[self.selStar objectForKey:@"rasiIdn"]]];
    //NSLog(@"Rasi Info %@",selRasi);
    if ([self.cameFrom isEqualToString:@"Profile"]) {
        NSMutableDictionary *userinfo = [[NSMutableDictionary alloc]init];
        [userinfo setObject:[self.selStar objectForKey:@"idn"] forKey:@"star_idn"];
        [userinfo setObject:[[selRasi objectAtIndex:0] objectForKey:@"idn"] forKey:@"rasi_idn"];
        [userinfo setObject:self.gender forKey:@"gender"];
        
        [myp saveUserInfo:userinfo];        
    }else{
        matchViewController *matV = [[matchViewController alloc]init];
        [matV assignInfo:self.gender valueArr:[NSArray arrayWithObjects:self.selStar,[selRasi objectAtIndex:0], nil]];
        
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
