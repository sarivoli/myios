//
//  mdMainSlideViewController.m
//  mediDiary
//
//  Created by Arivoli on 4/2/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import "mdMainSlideViewController.h"

@interface mdMainSlideViewController ()

@end

@implementation mdMainSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 0;
    profileList = [[NSMutableArray alloc] init];
    mdDiary *mdbase=[[mdDiary alloc]init];
    profileList = [mdbase getProfileList];
    
    
    //pageIndex = 0;
    NSLog(@"loading main slide view %d",pageIndex);
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    mdSummaryForNowViewController *initialViewController = [self getView:pageIndex];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
   

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(mdSummaryForNowViewController *)getView:(int)index{
    mdSummaryForNowViewController *myView = [[mdSummaryForNowViewController alloc] init];
    myView.currentIndex=index;
    myView.currentProfileId = 0;
    if([profileList count]>0)
        {
            myView.currentProfileId =[[profileList objectAtIndex:index] objectForKey:@"id"];
            NSLog(@"current profile id is %@",[[profileList objectAtIndex:index] objectForKey:@"id"]);
            pageIndex = index;

        }
    return myView;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NSUInteger index = [(mdSummaryForNowViewController *)viewController currentIndex];

    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    return [self getView:(int)index];
    
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [(mdSummaryForNowViewController *)viewController currentIndex];
    index++;

    if (index == [profileList count]) {
        return nil;
    }
    return [self getView:(int)index];

    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [profileList count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return pageIndex;
}

@end
