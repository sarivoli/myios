//
//  sMatcherMainViewController.m
//  iMatcher
//
//  Created by Arivoli on 12/11/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "sMatcherMainViewController.h"

@interface sMatcherMainViewController ()

@end

@implementation sMatcherMainViewController
@synthesize collectionView;
@synthesize lblBrideStar,lblGroomStar;

@synthesize currentPopoverSegue;
@synthesize popoverController;
@synthesize pvc;
@synthesize lblResult;
static NSMutableArray *maleInfo, *femaleInfo;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
              
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    por = [[porutham alloc]init];
    starList =[por getStarInfo:nil];
    poruthamList = [por getPoruthamList];
    [self.lblResult setText:@""];
    [self.collectionView registerNib:[UINib nibWithNibName:@"poruthamCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"poruthamCellV"];
    
    [[self view] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"ipadpaperback.png"]]];
 
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 4;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 3;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    poruthamCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"poruthamCellV" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    int myIndex=1;
    if(indexPath.section==0){
        myIndex = indexPath.row+1;
    }else{
        myIndex = (indexPath.section*4)+(indexPath.row+1);
    }
    myIndex = myIndex-1;
    NSDictionary *porInfo = [poruthamList objectAtIndex:myIndex];
    [cell.lblTitel setText: [porInfo objectForKey:@"name"]];
    
    NSString *imgName = [[NSString alloc] initWithFormat:@"%@.png",
                         [matchDetails objectForKey:[porInfo objectForKey:@"idn"]]] ;
    [[cell imgResult]setImage:[UIImage imageNamed: [imgName lowercaseString]]];
    
    [[cell lblResult] setText:[matchDetails objectForKey:[porInfo objectForKey:@"idn"]]];
    [[cell txtDesc] setText:[porInfo objectForKey:@"desc"]];
    //[matchDetails objectForKey:[porInfo objectForKey:@"idn"]]
    
    //[cell.lblTitel setText: @"welcome"];

    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 150);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

-(void)assignInfo:(NSString*)gender valueArr:(NSArray*)val
{
    if([gender isEqualToString:MALE])
        {
            maleInfo = [NSMutableArray arrayWithArray:val];
            [lblGroomStar  setText:[[maleInfo objectAtIndex:0] objectForKey:@"name"]];
        }else{
            femaleInfo = [NSMutableArray arrayWithArray:val];
            [lblBrideStar  setText:[[femaleInfo objectAtIndex:0] objectForKey:@"name"]];
        }
    if(maleInfo && femaleInfo){
        matchDetails = [por getPoruthamResult:maleInfo girlStar:femaleInfo];
        
        int totalPorutham = [[matchDetails objectForKey:@"total"] intValue ];
        int count = 12;
        int imageWidth = 22;
        int imageHeight = 19;
        
        NSString *imgName = @"blackheard.png";
        [self.lblResult setText:[NSString stringWithFormat:@"%@(%i/%i)",[matchDetails objectForKey:@"result"],totalPorutham,count]];
        CGRect rectValue =  [self.lblResult frame];

        
        int x = rectValue.origin.x + (rectValue.size.width/2) -((imageWidth *count)/2);
        int y = rectValue.origin.y + rectValue.size.height + imageHeight;
        for(int i = 0; i < count; i++)
            {
                if(i <totalPorutham ){
                    imgName = @"redheart.png";
                }else{
                    imgName = @"blackheart.png";
                }
                UIImageView *imgVw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
                [imgVw setUserInteractionEnabled:NO];
                [imgVw setTag:i];
                imgVw.frame=CGRectMake(x, y, imageWidth, imageHeight);
                [self.view addSubview:imgVw];
                x= x+ imageWidth;
            }
        
        
        // Reload table with a slight animation
        [UIView transitionWithView:self.collectionView
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            //[tableViewReference reloadData];
                            [self.collectionView reloadData];
                            
                        } completion:NULL];

        
    }
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"Female Info: %@",femaleInfo);
    //NSLog(@"Male Info: %@",maleInfo);

    if (maleInfo) {
        [lblGroomStar  setText:[[maleInfo objectAtIndex:0] objectForKey:@"name"]];
    }
    if(femaleInfo)
        {
            [lblBrideStar  setText:[[femaleInfo objectAtIndex:0] objectForKey:@"name"]];
        }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"Male"] || [[segue identifier] isEqualToString:@"Female"]) {
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
        [pvc setStrGender:[segue identifier]];
    }
}

// PopViewControllerDelegate callback function
- (void)dismissPop:(NSString *)gender :(NSArray *)value
{
    [self assignInfo:gender valueArr:value];
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover

}
-(IBAction)getMyProfile:(id)sender{
   /* if (self.popoverController == nil) {
     profileViewController *profileView =
     [[profileViewController alloc]init];
     
     UIPopoverController *popover =
     [[UIPopoverController alloc] initWithContentViewController:profileView];
     
     popover.delegate = self;
     
     self.popoverController = popover;
     }
    
    [self.popoverController presentPopoverFromBarButtonItem:sender
    permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    */
    
     //popoverController.gender = @"male";
     //popoverController.cameFrom = @"ipad";
     //CGRect popoverRect = [self.view convertRect:[sender frame]
     //fromView:[self view]];
    
    //popoverRect.size.width = MIN(popoverRect.size.width, 100);
    
    /*     [self.popoverController
     presentPopoverFromRect:[sender frame]
     inView:self.view
     permittedArrowDirections:UIPopoverArrowDirectionAny
     animated:YES];*/
     

}
@end
