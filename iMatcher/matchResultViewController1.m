//
//  matchResultViewController.m
//  iMatcher
//
//  Created by S Arivoli on 10/10/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "matchResultViewController.h"
#define kUthamam  @"Uthamam" //Good
#define kMathimam @"Mathimam" //Not Bad
#define kAthamam @"Athamam" //Bad

@interface matchResultViewController ()

@end

@implementation matchResultViewController
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
    por = [[porutham alloc]init];
    poruthamList = [por getPoruthamList];
    matchDetails = [[NSDictionary alloc]init];
    self.title = @"Results";
    //self.tableView.backgroundColor= [UIColor colorWithPatternImage: [UIImage imageNamed:@"paperback.jpg"]];
    [[self tableView]setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];

    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperback.jpg"]]];


    
    //Retrieve all match results
    matchDetails = [por getPoruthamResult:[matchInfo objectAtIndex:0] girlStar:[matchInfo objectAtIndex:1]];

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
    NSLog(@"%@",[[matchDetails objectForKey:[res objectForKey:@"idn"]] lowercaseString]);
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

    NSLog(@"value for porutham %@",[matchDetails objectForKey:[res objectForKey:@"idn"]]);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
