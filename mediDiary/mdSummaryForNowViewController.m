//
//  mdSummaryForNowViewController.m
//  mediDiary
//
//  Created by Arivoli on 4/2/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import "mdSummaryForNowViewController.h"

@interface mdSummaryForNowViewController ()

@end

@implementation mdSummaryForNowViewController
@synthesize lblSlideNo,currentIndex,currentProfileId;
- (void)viewWillAppear:(BOOL)animated;
{
    sessions = [[NSArray alloc] initWithObjects:@"Morning", @"Noon", @"Evening",@"Night", nil];
    currentMedicationList = [[NSMutableDictionary alloc] init];
    [currentMedicationList setObject:[[NSMutableArray alloc] init] forKey:@"Morning"];
    [currentMedicationList setObject:[[NSMutableArray alloc] init] forKey:@"Noon"];
    [currentMedicationList setObject:[[NSMutableArray alloc] init] forKey:@"Evening"];
    [currentMedicationList setObject:[[NSMutableArray alloc] init] forKey:@"Night"];
    [self loadCurrentMedicationList];
    
    self.lblSlideNo.text=[currentProfileInfo valueForKey:@"name"];

}
-(void)loadCurrentMedicationList{
    md=[[mdDiary alloc]init];
    currentProfileInfo = [md getProfileInfo:self.currentProfileId];
    NSMutableArray *medicationList = [md getCurrentMedicationForProfile:self.currentProfileId];
    /*   for (NSString *val in sessions) {
     //       [currentMedicationList objectForKey:val]= [[NSMutableArray alloc] init];
     //       [currentMedicationList setValue:[[NSMutableArray alloc] init] forKey:val];
     [currentMedicationList setValue:@"" forKey:val];
     
     //     [currentMedicationList objectForKey:val] = [[NSMutableArray alloc] init];
     
     
     }*/
    for (NSDictionary *medications in medicationList) {
        //NSArray *frequency = [[NSArray alloc] init];
        NSArray *frequency =[(NSString *)[medications objectForKey:@"freq"] componentsSeparatedByString:@"-"];
        
        if ([[frequency objectAtIndex:0] isEqualToString:@"1"]) {
            [currentMedicationList[[sessions objectAtIndex:0]] addObject:medications];
        }
        if ([[frequency objectAtIndex:1] isEqualToString:@"1"]) {
            [currentMedicationList[[sessions objectAtIndex:1]] addObject:medications];
        }
        if ([[frequency objectAtIndex:2] isEqualToString:@"1"]) {
            [currentMedicationList[[sessions objectAtIndex:2]] addObject:medications];
        }
        if ([[frequency objectAtIndex:3] isEqualToString:@"1"]) {
            [[currentMedicationList objectForKey:[sessions objectAtIndex:3]]  addObject:medications];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    self.view.layer.masksToBounds = NO;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view.layer.shadowOpacity = 0.5f;
    self.view.layer.shadowPath = shadowPath.CGPath;
    NSLog(@"loading child view id #: %@",self.currentProfileId);
    //    { @"Morning":[],@"Noon":[],@"Evening":[],@"Night":[]};
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    int rowCount =[[currentMedicationList objectForKey:[sessions objectAtIndex:self.segSessions.selectedSegmentIndex]] count];

    
    NSLog(@"Values in this section %d",rowCount);
    if(rowCount > 0)
        return rowCount;
    return 1;
    
    //    return [[currentMedicationList objectForKey:[sessions objectAtIndex:self.segSessions.selectedSegmentIndex]] count];
            
    
    
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    //Region *region = [regions objectAtIndex:section];
    //return [region name];
    return [sessions objectAtIndex:section];
}*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected index %ld",(long)indexPath.row);
    NSArray *cellValues = [currentMedicationList objectForKey:[sessions objectAtIndex:self.segSessions.selectedSegmentIndex]];
    if([cellValues count]>0 && [[cellValues objectAtIndex:indexPath.row] count]>0)
        {
           if( ![[[cellValues objectAtIndex:indexPath.row] objectForKey:@"image"] isEqualToString:@""]){
               mdImgViewController *imgView = [[mdImgViewController alloc] init];
            
               imgView.imgName =[md getImageFullPath: [[cellValues objectAtIndex:indexPath.row] objectForKey:@"image"]];
               
               NSLog(@"Image name --> %@ ",[[cellValues objectAtIndex:indexPath.row] objectForKey:@"image"]);
               imgView.pgTitle = [[cellValues objectAtIndex:indexPath.row] objectForKey:@"name"];
               //imgView.imgName = @"";
               
               [self presentViewController:imgView animated:YES completion:nil];

               
               
           }
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    /*Region *region = [regions objectAtIndex:indexPath.section];
    TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    cell.textLabel.text = timeZoneWrapper.localeName;
     */
    NSArray *cellValues =[currentMedicationList objectForKey:[sessions objectAtIndex:self.segSessions.selectedSegmentIndex]];
    if([cellValues count]>0)
        {
            cell.textLabel.text =[[cellValues objectAtIndex:indexPath.row] objectForKey:@"name"];
        // NSString *detailedText = @"%@ - Format",[[cellValues objectAtIndex:indexPath.row] objectForKey:@"food"];
        // cell.detailTextLabel.text =
        // NSLog(@"image %@",[[cellValues objectAtIndex:indexPath.row] objectForKey:@"image"]);
        NSString *detailedText = [[NSString alloc] init];
        detailedText =[NSString stringWithFormat:@"(%@) - %@",[[cellValues objectAtIndex:indexPath.row] objectForKey:@"food"], [[cellValues objectAtIndex:indexPath.row] objectForKey:@"use"]];
        cell.detailTextLabel.text = detailedText;

        if( [[[cellValues objectAtIndex:indexPath.row] objectForKey:@"image"] isEqualToString:@""]){
                //do nothing
                UIImage *image = [UIImage imageNamed:@"camera.png"];
                cell.imageView.image =  image;

            }else{
                NSData *pngData = [NSData dataWithContentsOfFile:[md getImageFullPath:[[cellValues objectAtIndex:indexPath.row] objectForKey:@"image"]]];
                UIImage *image = [UIImage imageWithData:pngData];
                cell.imageView.image =  image;
        
            }
        }
    else
        {
            cell.textLabel.text =@"No medication found for this session";
            cell.detailTextLabel.text = @"";
            cell.imageView.image =  nil;
    }
    
    return cell;
}
-(IBAction)reloadSummary:(id)sender{
    
    [self.tblSummaryList reloadData];

}


@end
