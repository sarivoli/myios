//
//  pdViewController.m
//  pDiary
//
//  Created by Arivoli on 5/9/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "pdViewController.h"
#import "pdMainViewCell.h"
@interface pdViewController ()
{
    NSArray *arrayOfRecord;
}

@end

@implementation pdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self mainCollectV] setDataSource:self];
    [[self mainCollectV]setDelegate:self];
    
    
    [[self view] setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"photoDieryBack.png"]]];
    arrayOfRecord = [[NSArray alloc] initWithObjects:@"First",@"Second",@"Third",@"Fore", nil];
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayOfRecord count]/2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    pdMainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [[cell lblName] setText: [NSString stringWithFormat:@"Cell %i",indexPath.row]];
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
