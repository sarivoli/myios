//
//  ttProjects.h
//  timeTracker
//
//  Created by Arivoli on 12/20/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface ttProjects : NSObject


-(NSMutableArray*)getProjectList;
-(NSMutableDictionary*)getProjectInfo:(NSString*)projId;

-(void)addProjects:(NSMutableDictionary*)projInfo;
-(void)deleteProject:(NSString*)projId;

-(void)addTask:(NSMutableDictionary*)taskDet;
-(NSMutableArray *)getTaskList;
-(NSMutableArray *)getTaskListForProject:(NSString*)projId;


-(void)addTimeEntry:(NSMutableDictionary*)timeData;
-(NSMutableArray *)getTimeEntries:(NSString*)taskId;
-(float)getTotalHours:(int)hours minutes:(int)mins;

+(void) initialize;
@end
