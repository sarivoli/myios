//
//  poruthamCell.m
//  iMatcher
//
//  Created by Arivoli on 12/12/12.
//  Copyright (c) 2012 arivoli. All rights reserved.
//

#import "poruthamCell.h"

@implementation poruthamCell
@synthesize lblResult,lblTitel,txtDesc,imgResult;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Initialization code
        NSArray *newArray = [[NSBundle mainBundle]loadNibNamed:@"poruthamCell" owner:self options:nil];
        self = [newArray objectAtIndex:0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
