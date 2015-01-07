//
//  mdDiary.h
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface mdDiary : NSObject
+ (void) initialize;

-(void)addProfile:(NSMutableDictionary*)profInfo;
-(void)addVisits:(NSMutableDictionary*)visitInfo;
-(void)addMedications:(NSMutableDictionary*)medicationInfo;


-(BOOL)delVisits:(id)visitId;


-(NSMutableDictionary*)getProfileInfo:(id)profileId;
-(NSMutableDictionary*)getVisitInfo:(id)visitId;

-(NSMutableArray*)getProfileList;
-(NSMutableArray*)getProfileVisits:(id)profileId;
-(NSMutableArray*)getMedicationList:(id)visitId;


@end
