//
//  popOverTableViewController.m
//  iMatcher
//
//  Created by Arivoli on 12/25/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "popOverTableViewController.h"

@interface popOverTableViewController ()

@end

@implementation popOverTableViewController
@synthesize strGender;
@synthesize delegate;
@synthesize selStar,cameFrom;

-
(id)initWithStyle:(UITableViewStyle)style
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
    if(self.strGender){
        pgTitle = self.strGender;
    }
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperback.jpg"]]];
    self.title = [NSString stringWithFormat:@"Select %@ Star",pgTitle];

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    self.selStar = [starList objectAtIndex:indexPath.row];
    porutham *myp = [[porutham alloc]init];
    NSArray *selRasi=[[NSArray alloc] initWithArray:[myp getRasiInfo:[self.selStar objectForKey:@"rasiIdn"]]];
    //NSLog(@"Genderinfo ******> %@",self.strGender);
    [self.delegate dismissPop:self.strGender :[NSArray arrayWithObjects: self.selStar,[selRasi objectAtIndex:0], nil]];
    
}


@end
