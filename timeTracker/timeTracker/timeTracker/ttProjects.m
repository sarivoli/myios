//
//  ttProjects.m
//  timeTracker
//
//  Created by Arivoli on 12/20/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "ttProjects.h"
static NSString *dataBasePath, *dataBaseName;
static BOOL dbExists;

@implementation ttProjects
+ (void) initialize
{
    dataBaseName = @"tTracker.sqlite";
    
    NSString *documentDir =[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    dataBasePath= [documentDir stringByAppendingPathComponent: dataBaseName];
    NSLog(@"DB Path this %@",dataBasePath);
    
    NSFileManager *fileManager= [NSFileManager defaultManager];
    
    
    dbExists = [fileManager fileExistsAtPath:dataBasePath];
    NSError *Myerror = [[NSError alloc]init];
    BOOL delDB=TRUE;
    BOOL newDB=TRUE;
    
    if(dbExists)
        {
        FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
        [db open];
        FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select * from appver"]];
        while ([results next]) {
            NSLog(@"APP Version: %@",[results stringForColumn:@"appver"]);
            if([[NSString stringWithFormat:@"%@",[results stringForColumn:@"appver"] ] isEqualToString:@"1.0"]){
                delDB=FALSE;
                newDB=FALSE;
                break;
            }
        }
        [db close];
        }else{
            delDB=FALSE;
        }
    if(delDB){
        NSLog(@"DB LOCation: %@",dataBasePath);
        [fileManager removeItemAtPath:dataBasePath error:&Myerror];
        if (Myerror != nil){
            NSLog(@"delete Database status: %@", [Myerror localizedDescription]);
        }
    }
    if(newDB){
        NSString *dbFromBundle = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:dataBaseName];
        NSLog(@"DB Bundle:  %@",dbFromBundle);
        [fileManager copyItemAtPath:dbFromBundle toPath:dataBasePath error:&Myerror];
        /* if (Myerror != nil){
         NSLog(@"adding Database status: %@", [Myerror localizedDescription]);
         }*/
    }
    
    
}




-(void)addProjects:(NSMutableDictionary*)projInfo
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    
    [db open];
    [db executeUpdate: @"INSERT INTO projects (pname,desc,type,priority,color,status) values(?,?,?,?,?,?)",[projInfo objectForKey:@"pname"],[projInfo objectForKey:@"desc"],[projInfo objectForKey:@"type"],[projInfo objectForKey:@"priority"],[projInfo objectForKey:@"color"],[projInfo objectForKey:@"status"]];
    //NSLog(@"%@",userInfo);
    
    NSLog(@"Project Stored successfully");
    [db close];
    
}
-(NSMutableArray*)getProjectList{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableArray *projectList =[[NSMutableArray alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select p.pid, p.pname, t.cnt,te.toth,te.totm, p.desc,p.type, p.priority, p.active,p.status  from projects p left join (select count(*) as cnt,pid from task group by pid) t on (p.pid=t.pid) left join ( select sum(toth)toth,sum(totm)totm,pid from (select tc.* , t.pid from ((select tid,  sum(hours) toth,sum(mins) totm  from timeentry tee group by tid)tc left join task t on(t.tid=tc.tid))) group by pid )te on(te.pid=p.pid) where p.active='Y'  order by p.upddt desc"]];
    while ([results next]) {
        NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
        [mdRec setObject:[results stringForColumn:@"pid"] forKey:@"pid"];
        [mdRec setObject:[results stringForColumn:@"pname"] forKey:@"pname"];
        
        [mdRec setObject:[results stringForColumn:@"desc"] forKey:@"desc"];
        
        [mdRec setObject:[results stringForColumn:@"type"] forKey:@"type"];
        
        [mdRec setObject:[results stringForColumn:@"priority"] forKey:@"priority"];
        if ([results stringForColumn:@"toth"]==nil)
            [mdRec setObject:@"0" forKey:@"toth"];
        else
            [mdRec setObject:[results stringForColumn:@"toth"] forKey:@"toth"];
        if ([results stringForColumn:@"totm"] ==nil)
            [mdRec setObject:@"0" forKey:@"totm"];
        else
            [mdRec setObject:[results stringForColumn:@"totm"] forKey:@"totm"];
        NSString *count = [NSString stringWithFormat:@"%@",[results stringForColumn:@"cnt"]];
        if( [count isEqualToString: @"(null)"])
            {
                count=@"0";
            }
        
         [mdRec setObject:count forKey:@"cnt"];
        
        [mdRec setObject:[results stringForColumn:@"active"] forKey:@"active"];
        [mdRec setObject:[results stringForColumn:@"status"] forKey:@"status"];

        [projectList addObject:mdRec];
        
    }
    results=NULL;
    [db close];
    return projectList;
}
-(NSMutableDictionary*)getProjectInfo:(NSString*)projId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableDictionary *projectInfo =[[NSMutableDictionary alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select p.pid, p.pname, t.cnt,te.toth,te.totm, p.desc,p.type, p.priority, p.active,p.status  from projects p left join (select count(*) as cnt,pid from task group by pid) t on (p.pid=t.pid) left join ( select sum(toth)toth,sum(totm)totm,pid from (select tc.* , t.pid from ((select tid,  sum(hours) toth,sum(mins) totm  from timeentry tee group by tid)tc left join task t on(t.tid=tc.tid))) group by pid )te on(te.pid=p.pid) where p.active='Y' and p.pid='%@' order by p.upddt desc",projId]];
    while ([results next]) {
        //NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
        [projectInfo setObject:[results stringForColumn:@"pid"] forKey:@"pid"];
        [projectInfo setObject:[results stringForColumn:@"pname"] forKey:@"pname"];
        
        [projectInfo setObject:[results stringForColumn:@"desc"] forKey:@"desc"];
        
        [projectInfo setObject:[results stringForColumn:@"type"] forKey:@"type"];
        
        if ([results stringForColumn:@"toth"]==nil)
            [projectInfo setObject:@"0" forKey:@"toth"];
        else
            [projectInfo setObject:[results stringForColumn:@"toth"] forKey:@"toth"];
        if ([results stringForColumn:@"totm"] ==nil)
            [projectInfo setObject:@"0" forKey:@"totm"];
        else
            [projectInfo setObject:[results stringForColumn:@"totm"] forKey:@"totm"];
        
        
        [projectInfo setObject:[results stringForColumn:@"priority"] forKey:@"priority"];
        NSString *count = [NSString stringWithFormat:@"%@",[results stringForColumn:@"cnt"]];
        if( [count isEqualToString: @"(null)"])
            {
            count=@"0";
            }
        
        [projectInfo setObject:count forKey:@"cnt"];
        
        [projectInfo setObject:[results stringForColumn:@"active"] forKey:@"active"];
        [projectInfo setObject:[results stringForColumn:@"status"] forKey:@"status"];
        
        //[projectList addObject:mdRec];
        break;
        
    }
    results=NULL;
    [db close];
    NSLog(@"Project Info %@",projectInfo);
    return projectInfo;
}
-(void)deleteProject:(NSString*)projId
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    
    [db open];
    id results =[db executeQuery:[NSString stringWithFormat: @"UPDATE projects SET active='N' where pid=%@",projId]];
    
    while ([results next]) {
        // NSLog(@"Project 1has been deleted %@", projId);
        //Executing this next statement to commit the previous transaction
    }
    if((bool)results ==YES)
        {
            NSLog(@"Project has been deleted %@", projId);
        }else{
            NSLog(@"error while deleting %@   \n Error message: %@", projId, db.lastErrorMessage);
        }
    [db close];
}

-(NSMutableArray *)getTaskList
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableArray *taskList =[[NSMutableArray alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select t.tid, t.pid,t.tname,t.desc, p.pname, t.priority, t.type,t.active,t.status from task t join projects p on (t.pid=p.pid) where p.active='Y' and t.active='Y' order by t.upddt desc"]];
    while ([results next]) {
        NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
        [mdRec setObject:[results stringForColumn:@"tid"] forKey:@"tid"];

        [mdRec setObject:[results stringForColumn:@"pid"] forKey:@"pid"];
        [mdRec setObject:[results stringForColumn:@"pname"] forKey:@"pname"];

        [mdRec setObject:[results stringForColumn:@"tname"] forKey:@"tname"];
        
        [mdRec setObject:[results stringForColumn:@"desc"] forKey:@"desc"];
        
        [mdRec setObject:[results stringForColumn:@"type"] forKey:@"type"];
        
        [mdRec setObject:[results stringForColumn:@"priority"] forKey:@"priority"];
        
        //[mdRec setObject:[results stringForColumn:@"color"] forKey:@"color"];
        
        [mdRec setObject:[results stringForColumn:@"active"] forKey:@"active"];
        [mdRec setObject:[results stringForColumn:@"status"] forKey:@"status"];
        
        [taskList addObject:mdRec];
        
    }
    results=NULL;
    [db close];
    return taskList;
    
}
-(NSMutableArray *)getTaskListForProject:(NSString*)projId
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableArray *taskList =[[NSMutableArray alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @" SELECT t.tid,t.pid, t.tname,tg.thrs,tg.tmns,t.desc,t.priority,t.color,t.type,t.status, p.pname,t.active FROM task t left join projects p on (t.pid = p.pid) left join (SELECT tid, sum(hours) thrs,sum(mins) tmns FROM timeentry group by tid)as tg on (tg.tid == t.tid) where t.active='Y' and t.pid=%@ order by t.upddt desc ",projId]];
    
    while ([results next]) {
        NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]initWithDictionary: [results resultDictionary]];
        /* [mdRec setObject:[results stringForColumn:@"tid"] forKey:@"tid"];
        
        [mdRec setObject:[results stringForColumn:@"pid"] forKey:@"pid"];
        [mdRec setObject:[results stringForColumn:@"tname"] forKey:@"tname"];
        [mdRec setObject:[results stringForColumn:@"pname"] forKey:@"pname"];

        [mdRec setObject:[results stringForColumn:@"desc"] forKey:@"desc"];
        
        [mdRec setObject:[results stringForColumn:@"type"] forKey:@"type"];
        
        [mdRec setObject:[results stringForColumn:@"priority"] forKey:@"priority"];
        
        //[mdRec setObject:[results stringForColumn:@"color"] forKey:@"color"];
        
        [mdRec setObject:[results stringForColumn:@"active"] forKey:@"active"];
        [mdRec setObject:[results stringForColumn:@"status"] forKey:@"status"];
        
        NSLog(@"Value is %@",[results stringForColumn:@"thrs"]);
        if ([results stringForColumn:@"thrs"]){
            [mdRec setObject:[results stringForColumn:@"thrs"] forKey:@"thrs"];

        }else{
            [mdRec setObject:0 forKey:@"thrs"];

        }
        
 
        if ([results stringForColumn:@"tmns"]){
            [mdRec setObject:[results stringForColumn:@"tmns"] forKey:@"tmns"];
            
        }else{
            [mdRec setObject:0 forKey:@"tmns"];
            
        }
 
        //        [mdRec setObject:(id)[results stringForColumn:@"tmns"]  ==NSNull.null  ?0:[results stringForColumn:@"tmns"] forKey:@"tmns"];
         */

        
        [taskList addObject:mdRec];
        
    }
    NSLog(@"Task list for project %@, %@",projId,taskList);
    results=NULL;
    [db close];
    return taskList;

    
}


-(void)addTask:(NSMutableDictionary*)taskDet{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    
    [db open];
    [db executeUpdate: @"INSERT INTO task (pid,tname,desc,type,priority,color,status) values(?,?,?,?,?,?,?)",[taskDet objectForKey:@"pid"],[taskDet objectForKey:@"tname"],[taskDet objectForKey:@"desc"],[taskDet objectForKey:@"type"],[taskDet objectForKey:@"priority"],[taskDet objectForKey:@"color"],[taskDet objectForKey:@"status"]];
    //NSLog(@"%@",userInfo);
    
    NSLog(@"Task Stored successfully");
    [db close];
}

-(void)addTimeEntry:(NSMutableDictionary*)timeData
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    
    [db open];
    [db executeUpdate: @"INSERT INTO timeentry (tid,date,hours,mins,note) values(?,?,?,?,?)",[timeData objectForKey:@"tid"],[timeData objectForKey:@"date"],[timeData objectForKey:@"hours"],[timeData objectForKey:@"mins"],[timeData objectForKey:@"note"]];
    //NSLog(@"%@",userInfo);
    
    NSLog(@"Time Entry Stored successfully");
    [db close];

}
-(NSMutableArray *)getTimeEntries:(NSString*)taskId
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableArray *timeEntryList =[[NSMutableArray alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select te.sid, te.tid,te.date,te.hours, te.mins,te.note from timeentry te where te.active='Y' and te.tid=%@ order by te.upddt desc",taskId]];
    
    while ([results next]) {
        NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
        [mdRec setObject:[results stringForColumn:@"tid"] forKey:@"tid"];
        
        [mdRec setObject:[results stringForColumn:@"sid"] forKey:@"sid"];
        [mdRec setObject:[results stringForColumn:@"date"] forKey:@"date"];
        [mdRec setObject:[results stringForColumn:@"hours"] forKey:@"hours"];
        
        [mdRec setObject:[results stringForColumn:@"mins"] forKey:@"mins"];
        
        [mdRec setObject:[results stringForColumn:@"note"] forKey:@"note"];
        
        
        [timeEntryList addObject:mdRec];
        
    }
    NSLog(@"Time Entry list for Task %@, %@",taskId,timeEntryList);
    results=NULL;
    [db close];
    return timeEntryList;
    
}

-(float)getTotalHours:(int)hours minutes:(int)mins{
    //NSInteger *minHrs = (NSInteger *)[rec objectForKey:@"totm"];
    // NSLog(@"Hours:%i, Mins:%i",hours,mins);
    int totalHours = hours+(mins/60);
    int remMins = mins%60;
    //NSLog(@"CCHours:%i, CCMins:%i",totalHours,remMins);
    //NSLog(@"return value : %.2lf",totalHours+(float)(remMins/100.00));
    return totalHours+(remMins/100.00);
    
}
@end
