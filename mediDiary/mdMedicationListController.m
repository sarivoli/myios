//
//  mdMedicationListController.m
//  mediDiary
//
//  Created by Arivoli on 10/2/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdMedicationListController.h"

@interface mdMedicationListController ()

@end

@implementation mdMedicationListController
@synthesize visitId;
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
    medicationList = [[NSMutableArray alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"View is reloading from Medication LIst ");
    [self refreshMedicationData];
    /*
     mdDiary *mdbase=[[mdDiary alloc]init];
    medicationList = [mdbase getMedicationList:visitId];
    if([medicationList count]==0){
        NSMutableDictionary *noResult=[[NSMutableDictionary alloc]init];
        [noResult setObject:@"No Medication Found" forKey:@"name"];
        [noResult setObject:@"" forKey:@"freq"];
        [noResult setObject:@"" forKey:@"food"];

        [medicationList addObject:noResult];
    }
    NSLog(@"Number of mediations %lu",(unsigned long)[medicationList count]);
    //[self.tableView numberOfRowsInSection:[medicationList count]];
     [self.tableView reloadData];
     */
    
    //NSString *gen,*starName, *rasiName, *defalt = [[NSString alloc]init];
    
    
    //[por saveUserInfo:userInfo];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Rx";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [medicationList count];
    //return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"MediCell";
    mdMedicationListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[mdMedicationListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        //        [[cell textLabel]setText:[urllist objectAtIndex:[indexPath row]]];
    }
    
    [[cell lblMedicationName] setText:[[medicationList objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [[cell lblMedicationDec] setText:[[medicationList objectAtIndex:indexPath.row] objectForKey:@"use"]];
    [[cell lblFrequency] setText:[[medicationList objectAtIndex:indexPath.row] objectForKey:@"freq"]];
    if([[[medicationList objectAtIndex:indexPath.row] objectForKey:@"food"] isEqualToString:@""]){
        
        [[cell lblTime] setText:@""];
    
    }else{
        [[cell lblTime] setText:[NSString stringWithFormat:@"(%@)",[[medicationList objectAtIndex:indexPath.row] objectForKey:@"food"]]];
    }
    NSLog(@"Image file %@",[[medicationList objectAtIndex:indexPath.row] objectForKey:@"image"]);
    if([[[medicationList objectAtIndex:indexPath.row] objectForKey:@"image"] isEqualToString:@""]){
        [[cell imgMedicationImgIndicator] setHidden:true];
        
    }else{
        [[cell imgMedicationImgIndicator] setHidden:false];

    }
    // [[cell swCurTaking] setSelected:(BOOL)[[medicationList objectAtIndex:indexPath.row] objectForKey:@"curtaking"]];
    NSLog(@"Currently Taking %@",[[medicationList objectAtIndex:indexPath.row] objectForKey:@"curtaking"]);
    if ([[[medicationList objectAtIndex:indexPath.row] objectForKey:@"curtaking"] isEqualToString:@"False"]){
        [[cell swCurTaking] setOn:false];
    }else{
        [[cell swCurTaking] setOn:TRUE];

    }
    cell.delegate = self;
    cell.cellIndex = indexPath.row;
    
    
    
    //      [[cell textLabel] setText:[[medicationList objectAtIndex:indexPath.row] objectForKey:@"name"]];
    //[[cell detailTextLabel] setText:[[medicationList objectAtIndex:indexPath.row] objectForKey:@"use"]];
    //NSLog(@"Cell info  -- %@",cell);
    return cell;
    // Configure the cell...
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
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
        
        NSLog(@"Deleting the entry from row  %@",[medicationList[indexPath.row] objectForKey:@"perid"]);
        mdDiary *mdbase=[[mdDiary alloc]init];
        [mdbase delMedications: [medicationList[indexPath.row] objectForKey:@"perid"]];
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self refreshMedicationData];

        
        
        //-(BOOL)delMedications:(id)perId{

        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

    
-(void)refreshMedicationData{
    
    mdDiary *mdbase=[[mdDiary alloc]init];
    medicationList = [mdbase getMedicationList:visitId];
   /* if([medicationList count]==0){
        NSMutableDictionary *noResult=[[NSMutableDictionary alloc]init];
        [noResult setObject:@"No Medication Found" forKey:@"name"];
        [noResult setObject:@"" forKey:@"freq"];
        [noResult setObject:@"" forKey:@"food"];
        
        [medicationList addObject:noResult];
    }*/
    NSLog(@"Number of mediations %lu",(unsigned long)[medicationList count]);
    //[self.tableView numberOfRowsInSection:[medicationList count]];
    [self.tableView reloadData];

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (IBAction)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data
{
    // Do additional actions as required.
    mdDiary *mdbase=[[mdDiary alloc]init];
    NSString *curTakingVal =  @"True";

    switch ([data tag]) {
        case 1:
            if( [[[medicationList objectAtIndex: cellIndex] objectForKey:@"curtaking"] isEqualToString:@"False"]){
                curTakingVal = @"True";
            }else{
                curTakingVal = @"False";
                
            }
            [mdbase setCurrentlyTaking:curTakingVal PrescriptionID:[[medicationList objectAtIndex: cellIndex] objectForKey:@"perid"]];
            [self refreshMedicationData];

            break;
        case 2:
            [self viewImage:cellIndex];

        default:
            break;
    }
    

}
-(IBAction)viewImage:(NSInteger)index{
    mdImgViewController *imgView = [[mdImgViewController alloc] init];
    mdDiary *mdbase=[[mdDiary alloc]init];
    NSDictionary *currentValue = [medicationList objectAtIndex: index] ;
    if( [[currentValue objectForKey:@"image"] isEqualToString:@""]){
        //do nothing
    }else{
        imgView.imgName =[mdbase getImageFullPath: [currentValue objectForKey:@"image"]];
    }
    NSLog(@"Image name --> %@ for the title %@",[currentValue objectForKey:@"name"],imgView.imgName);
    imgView.pgTitle = [currentValue objectForKey:@"name"];
    //imgView.imgName = @"";

    [self presentViewController:imgView animated:YES completion:nil];
    
    //   [self.navigationController pushViewController:imgView animated:YES ];
 
}
@end
