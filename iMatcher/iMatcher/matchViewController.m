//
//  matchViewController.m
//  iMatcher
//
//  Created by S Arivoli on 10/7/12.
//  Copyright (c) 2012 Arivoli. All rights reserved.
//

#import "matchViewController.h"
#import "starListViewController.h"

#define kUthamam  @"Uthamam" //Good
#define kMathimam @"Mathimam" //Not Bad
#define kAthamam @"Athamam" //Bad
static NSMutableArray *maleInfo, *femaleInfo;

@interface matchViewController ()

@end

@implementation matchViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"sMatcher";
    por = [[porutham alloc]init];
    NSDictionary *userInfo = [por getUserInfo];
    //defalt =[userInfo objectForKey:@"default"];
    [self assignInfo:[userInfo objectForKey:@"gender"] valueArr:[NSArray arrayWithObjects:[[por getStarInfo:[userInfo objectForKey:@"star_idn"]] objectAtIndex:0],[[por getRasiInfo:[userInfo objectForKey:@"rasi_idn"]] objectAtIndex:0], nil]];

    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperback.jpg"]]];
    
    //[[self tableView] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"paperback.jpg"]]];
    //UIBarButtonItem *btn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(setUserSetting)];
    
    //self.navigationItem.rightBarButtonItem=btn;
	
    // Do any additional setup after loading the view, typically from a nib.
    //[self.navigationController setNavigationBarHidden:YES];

}
-(IBAction)getStarList:(id)sender{
    starListViewController *V2 = [[starListViewController alloc] init];
    if(sender == btnSelFMaleStar ){
        V2.gender = FEMALE;        
    }else{
        V2.gender = MALE;
    }
    [self.navigationController pushViewController:V2 animated:YES];       
     /*V2.modalPresentationStyle = UIModalPresentationFormSheet;
    V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController presentModalViewController:V2 animated:YES];
    V2.view.superview.frame = CGRectMake(0, 0, 540, 620); //it's important to do this after presentModalViewController
    // V2.view.superview.center = V1.view.center;
    */
    
}
-(void)assignInfo:(NSString*)gender valueArr:(NSArray*)val
{
    if([gender isEqualToString:MALE])
        {
            maleInfo = [NSMutableArray arrayWithArray:val];
         }else{
            femaleInfo = [NSMutableArray arrayWithArray:val];
        }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Female info: %@",femaleInfo);
    NSLog(@"Male info: %@",maleInfo);
    
    if (maleInfo) {
        [lblMaleStar  setText:[[maleInfo objectAtIndex:0] objectForKey:@"name"]];
        [lblMaleRasi  setText:[[maleInfo objectAtIndex:1] objectForKey:@"desc"]];
    }
    if(femaleInfo)
        {
            //NSLog(@"Female info %@",[femaleInfo objectAtIndex:0]);
            //  NSLog(@"Female info %@",[[femaleInfo objectAtIndex:0]objectForKey:@"idn"]);

            [lblFemaleStar  setText:[[femaleInfo objectAtIndex:0] objectForKey:@"name"]];
            [lblFemaleRasi  setText:[[femaleInfo objectAtIndex:1] objectForKey:@"desc"]];

        }
    //UITableView *tblV =(UITableView*)[self.view viewWithTag:5];

    if(maleInfo && femaleInfo)
        {
            NSDictionary *matchDetails = [por getPoruthamResult:maleInfo girlStar:femaleInfo];
            int totalPorutham = [[matchDetails objectForKey:@"total"] intValue ];
            [lblScore setText:[NSString stringWithFormat:@"%i/12", totalPorutham]];
            for (int img=0; img<12; img++) {
                UIImageView *imgV =(UIImageView*)[self.view viewWithTag:img+10];
                if(totalPorutham>img){
                        [imgV setImage:[UIImage imageNamed:@"redheart.png"]];
                    }else {
                        [imgV setImage:[UIImage imageNamed:@"blackheart.png"]];
                    }
            }
        
        //print over all result
        [lblResult setText:[matchDetails objectForKey:@"result"]];

            
        
        }
    
    //NSLog(@"Male Info  \n %@",maleInfo);
    //NSLog(@"Female Info \n %@",femaleInfo);

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(IBAction)getMatchInfo:(id)sender{
    poruthamViewController *matchRes = [[poruthamViewController alloc]init];
    if(!maleInfo | !femaleInfo)
        {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill up Male and Female Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        }else {
             matchRes.matchInfo = [NSArray arrayWithObjects:maleInfo, femaleInfo, nil];
            [self.navigationController pushViewController:matchRes animated:YES];

        }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    starListViewController *V2 = (starListViewController*)[segue destinationViewController];

    if([[segue identifier ] isEqualToString:@"femalesegue"])
        {
        V2.gender = FEMALE;        
        }else
        {
            V2.gender = MALE;
        }

 }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    if([indexPath row]==1 && [indexPath section]==1){
        [self getMatchInfo:self];
    }
    //NSLog(@"welcome %@", indexPath);
}


@end
