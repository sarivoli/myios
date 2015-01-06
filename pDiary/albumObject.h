//
//  albumObject.h
//  albumview
//
//  Created by Arivoli on 2/18/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface albumObject : NSObject
{
    
    NSString* sTitle;
    
    UIImage* posterImage;
    
    NSMutableArray* imageList;
    
    int nImageCount;
    
}



@property (nonatomic, retain) NSString* sTitle;

@property (nonatomic, retain) UIImage* posterImage;

@property (nonatomic, retain) NSMutableArray* imageList;


@property (nonatomic, assign) int nImageCount;



@end
