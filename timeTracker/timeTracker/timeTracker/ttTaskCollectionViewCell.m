//
//  ttTaskCollectionViewCell.m
//  timeTracker
//
//  Created by Arivoli on 1/7/14.
//  Copyright (c) 2014 Arivoli. All rights reserved.
//

#import "ttTaskCollectionViewCell.h"

@implementation ttTaskCollectionViewCell
@synthesize lblTaskName,lblTodayHrs,lblTotalHrs;
@synthesize tlbarTaskActions,brbtnAddTime,brbtnDeleteTask,brbtnEditTask;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
