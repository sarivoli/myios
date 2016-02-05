//
//  mdImgViewController.h
//  mediDiary
//
//  Created by Arivoli on 3/26/15.
//  Copyright (c) 2015 Arivoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mdImgViewController : UIViewController
@property (strong, nonatomic) NSString *imgName;
@property (strong, nonatomic) NSString *pgTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgImageToView;

-(IBAction)cancelModelWindow:(id)sender;
@end
