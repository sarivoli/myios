//
//  mdImgViewController.m
//  mediDiary
//
//  Created by Arivoli on 3/26/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import "mdImgViewController.h"

@interface mdImgViewController ()

@end

@implementation mdImgViewController
@synthesize imgName,pgTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSData *pngData = [NSData dataWithContentsOfFile:imgName];
    UIImage *image = [UIImage imageWithData:pngData];
    self.imgImageToView.image = image;


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

-(IBAction)cancelModelWindow:(id)sender{
    //   [self.navigationController popToViewController:self animated:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
