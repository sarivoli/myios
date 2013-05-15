//
//  matchCell.m
//  iMatcher
//
//  Created by S Arivoli on 11/18/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "matchCell.h"

@implementation matchCell
@synthesize lblMatchTitle;
@synthesize imgResult;
@synthesize lblMatchDesc;
@synthesize btnMoreInfo;
@synthesize lblResult;
@synthesize vParent;
@synthesize poruthamIdn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *newArray = [[NSBundle mainBundle]loadNibNamed:@"matchCell" owner:self options:nil];
        self = [newArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)getPoruthamInfo:(id)sender{
    matchInfoViewController *popupview = [[matchInfoViewController alloc]init];
    
    
	[popupview setModalPresentationStyle:UIModalPresentationFullScreen];
    [popupview setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [popupview setPoruthamDetails:poruthamIdn];
    if([vParent.presentingViewController respondsToSelector:@selector(presentViewController:animated:completion:)])
        [vParent.presentingViewController presentViewController:popupview animated:YES completion:Nil];
    else
        [vParent presentModalViewController:popupview animated:YES];
   
    
    //    [popupview.view setFrame:CGRectMake( 0.0f, 480.0f, 320.0f, 480.0f)]; //notice this is OFF screen!
    /*[UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.4];
    [newView setFrame:CGRectMake( 0.0f, 0.0f, 320.0f, 480.0f)]; //notice this is ON screen!
    [UIView commitAnimations];
    */
    /*[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                           forView:vParent.view
                             cache:YES];

    // [vParent addChildViewController:popupview];
    
    
     [vParent.view addSubview:popupview.view];
    [UIView commitAnimations];*/
    
    

}


@end
