    //
//  mdDiary.m
//  mediDiary
//
//  Created by Arivoli on 9/23/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdDiary.h"
static NSString *dataBasePath, *dataBaseName;
static BOOL dbExists;

@implementation mdDiary
+ (void) initialize
{
    dataBaseName = @"medDiary.sqlite";
    
    NSString *documentDir =[ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // NSString *documentDir = [documentPath objectAtIndex:0];
    //coreDBPath = [documentDir stringByAppendingPathComponent:dataBaseName];
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
    
    
    
    
    
    
    
    //NSLog(@"Class has been initialized");
    
}

-(void)addProfile:(NSMutableDictionary*)profInfo
{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    BOOL res=FALSE;
    [db open];
    res=[db executeUpdate: @"INSERT INTO profiles (name,bgroup,dob,gender,relation,notes) values(?,?,?,?,?,?)",[profInfo objectForKey:@"name"],[profInfo objectForKey:@"bgroup"],[profInfo objectForKey:@"dob"],[profInfo objectForKey:@"gender"],[profInfo objectForKey:@"relation"],[profInfo objectForKey:@"notes"]];
    //NSLog(@"%@",userInfo);
    if(!res){
        NSLog(@"Some error occured during insert profile \n %@",[db lastErrorMessage]);
    }else{

        NSLog(@"Profile Stored successfully");
    }
    //[db commit];

    [db close];
    
}
-(NSMutableArray*)getProfileList{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableArray *profileList =[[NSMutableArray alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT id,name,bgroup,dob,gender,relation,notes FROM profiles where active='Y'"]];
    while ([results next]) {
        NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
        [mdRec setObject:[results stringForColumn:@"id"] forKey:@"id"];
        [mdRec setObject:[results stringForColumn:@"name"] forKey:@"name"];

        [mdRec setObject:[results stringForColumn:@"bgroup"] forKey:@"bgroup"];

        [mdRec setObject:[results stringForColumn:@"dob"] forKey:@"dob"];

        [mdRec setObject:[results stringForColumn:@"gender"] forKey:@"gender"];

        [mdRec setObject:[results stringForColumn:@"relation"] forKey:@"relation"];

        [mdRec setObject:[results stringForColumn:@"notes"] forKey:@"notes"];
        [profileList addObject:mdRec];
        
    }
    results=NULL;
    [db close];
    return profileList;
}

-(NSMutableDictionary*)getProfileInfo:(id)profileId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT id,name,bgroup,dob,gender,relation,notes FROM profiles where active='Y' and id=%@",profileId]];
    while ([results next]) {
        [mdRec setObject:[results stringForColumn:@"id"] forKey:@"id"];
        [mdRec setObject:[results stringForColumn:@"name"] forKey:@"name"];
        
        [mdRec setObject:[results stringForColumn:@"bgroup"] forKey:@"bgroup"];
        
        [mdRec setObject:[results stringForColumn:@"dob"] forKey:@"dob"];
        
        [mdRec setObject:[results stringForColumn:@"gender"] forKey:@"gender"];
        
        [mdRec setObject:[results stringForColumn:@"relation"] forKey:@"relation"];
        
        [mdRec setObject:[results stringForColumn:@"notes"] forKey:@"notes"];
        
    }
    results=NULL;
    
    [db close];
    return mdRec;
}
-(void)addVisits:(NSMutableDictionary*)visitInfo{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    BOOL res=FALSE;
    [db open];
    res=[db executeUpdate: @"INSERT INTO visits (profid,visitdate,hospital,drname,contactinfo,reason) values(?,?,?,?,?,?)",[visitInfo objectForKey:@"profileid"],[visitInfo objectForKey:@"visitdate"],[visitInfo objectForKey:@"hospital"],[visitInfo objectForKey:@"drname"],[visitInfo objectForKey:@"contactinfo"],[visitInfo objectForKey:@"reason"]];
    //NSLog(@"%@",userInfo);
    if(!res){
        NSLog(@"Some error occured during insert visits \n %@",[db lastErrorMessage]);
     
    }else{

        NSLog(@"Visits Stored successfully");
    }
    //[db commit];

    [db close];

    
}


-(BOOL)delVisits:(id)visitId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    bool res=FALSE;
    [db open];
    res=[db executeUpdate: @"UPDATE visits set active='N' , upddt=datetime() where visitid=?",visitId];
    //NSLog(@"%@",userInfo);
    
//    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"UPDATE visits set active='N' where visitid=%@",visitId]];
  //  NSLog(@"REsult --> %@",results);
    if(!res){
        NSLog(@"Some error occured during update \n %@",[db lastErrorMessage]);
        return false;
    }
    NSLog(@"Deleted visit info :%@",visitId);
   //results=NULL;
   //[db commit];

    [db close];
    return true;

}

-(BOOL)setCurrentlyTaking:(NSString *)currentlyTaking  PrescriptionID:(id)perId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    bool res=FALSE;
    [db open];
    res=[db executeUpdate: @"UPDATE perscription set curtaking=? , upddt=datetime() where perid=?",currentlyTaking,perId];
    //NSLog(@"%@",userInfo);
    
    //    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"UPDATE visits set active='N' where visitid=%@",visitId]];
    //  NSLog(@"REsult --> %@",results);
    if(!res){
        NSLog(@"Some error occured during update \n %@",[db lastErrorMessage]);
        return false;
    }
    NSLog(@"Updated medications info :%@",perId);
    //results=NULL;
    //[db commit];
    
    [db close];
    return true;
    
}

-(BOOL)delMedications:(id)perId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    bool res=FALSE;
    [db open];
    res=[db executeUpdate: @"UPDATE perscription set active='N' , upddt=datetime() where perid=?",perId];
    //NSLog(@"%@",userInfo);
    
    //    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"UPDATE visits set active='N' where visitid=%@",visitId]];
    //  NSLog(@"REsult --> %@",results);
    if(!res){
        NSLog(@"Some error occured during update \n %@",[db lastErrorMessage]);
        return false;
    }
    NSLog(@"Deleted medications info :%@",perId);
    //results=NULL;
    //[db commit];
    
    [db close];
    return true;
    
}

-(void)addMedications:(NSMutableDictionary*)medicationInfo{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    BOOL res=FALSE;
    [db open];
    res=[db executeUpdate: @"INSERT INTO perscription (visitid,name,use,freq,food,image,curtaking) values(?,?,?,?,?,?,?)",[medicationInfo objectForKey:@"visitid"],[medicationInfo objectForKey:@"name"],[medicationInfo objectForKey:@"use"],[medicationInfo objectForKey:@"freq"],[medicationInfo objectForKey:@"food"],[medicationInfo objectForKey:@"image"],@"True"];
    //NSLog(@"%@",userInfo);
    if(!res){
        NSLog(@"Some error occured during Insert \n %@",[db lastErrorMessage]);
    }else{
        NSLog(@"Medication Stored successfully");
    }
    //[db commit];
    [db close];

    
}
-(NSMutableArray*)getProfileVisits:(id)profileId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableArray *profileVisits =[[NSMutableArray alloc]init];
    
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select visitid,profid,visitdate, hospital,drname,contactinfo,reason from visits where active='Y' and profid=%@ order by visitdate asc",profileId]];
    while ([results next]) {
        NSMutableDictionary *mdRec = [[NSMutableDictionary alloc]init];
        [mdRec setObject:[results stringForColumn:@"visitid"] forKey:@"visitid"];

        [mdRec setObject:[results stringForColumn:@"profid"] forKey:@"profid"];
        [mdRec setObject:[results stringForColumn:@"visitdate"] forKey:@"visitdate"];
        
        [mdRec setObject:[results stringForColumn:@"hospital"] forKey:@"hospital"];
        
        [mdRec setObject:[results stringForColumn:@"drname"] forKey:@"drname"];
        
        [mdRec setObject:[results stringForColumn:@"contactinfo"] forKey:@"contactinfo"];
        
        [mdRec setObject:[results stringForColumn:@"reason"] forKey:@"reason"];
        
        [profileVisits addObject:mdRec];
        
    }
    results=NULL;
    [db close];
    return profileVisits;
    
}
-(NSMutableDictionary*)getVisitInfo:(id)visitId{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    NSMutableDictionary *visitInfo = [[NSMutableDictionary alloc]init];
    
    [db open];
    
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select profid,visitdate, hospital,drname,contactinfo,reason from visits where active='Y' and visitid=%@ ",visitId]];
    while ([results next]) {
        [visitInfo setObject:[results stringForColumn:@"profid"] forKey:@"profid"];
        [visitInfo setObject:[results stringForColumn:@"visitdate"] forKey:@"visitdate"];
        
        [visitInfo setObject:[results stringForColumn:@"hospital"] forKey:@"hospital"];
        
        [visitInfo setObject:[results stringForColumn:@"drname"] forKey:@"drname"];
        
        [visitInfo setObject:[results stringForColumn:@"contactinfo"] forKey:@"contactinfo"];
        
        [visitInfo setObject:[results stringForColumn:@"reason"] forKey:@"reason"];
        
    }
    NSLog(@"Visit Information:%@",visitInfo)
    ;    results=NULL;
    [db close];
    return visitInfo;

}
-(NSMutableArray*)getMedicationList:(id)visitId{

    NSMutableArray *medicationList=[[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select perid,visitid,name, use,freq,food,image,curtaking from perscription where active='Y' and visitid=%@",visitId]];
    while ([results next]) {
        NSLog(@"getting medication list ");

        NSMutableDictionary *medicationInfo = [[NSMutableDictionary alloc]init];
        [medicationInfo setObject:[results stringForColumn:@"perid"] forKey:@"perid"];

        [medicationInfo setObject:[results stringForColumn:@"visitid"] forKey:@"visitid"];
        [medicationInfo setObject:[results stringForColumn:@"name"] forKey:@"name"];
        
        [medicationInfo setObject:[results stringForColumn:@"use"] forKey:@"use"];
        
        [medicationInfo setObject:[results stringForColumn:@"freq"] forKey:@"freq"];
        
        [medicationInfo setObject:[results stringForColumn:@"food"] forKey:@"food"];
        [medicationInfo setObject:[results stringForColumn:@"image"] forKey:@"image"];
        [medicationInfo setObject:[results stringForColumn:@"curtaking"] forKey:@"curtaking"];

        
        [medicationList addObject:medicationInfo];
    }
    results=NULL;
    [db close];
    return medicationList;
    
}

-(NSMutableArray*)getCurrentMedicationForProfile:(id)profileId{
    
    NSMutableArray *medicationList=[[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"select p.perid, p.visitid, p.name, p.use, p.freq,p.food,p.image  from perscription p left join visits v on (v.visitid = p.visitid ) where p.curtaking = 'True' and p.active='Y' and v.profid=%@",profileId]];
    while ([results next]) {
        NSLog(@"getting medication list ");
        
        NSMutableDictionary *medicationInfo = [[NSMutableDictionary alloc]init];
        [medicationInfo setObject:[results stringForColumn:@"perid"] forKey:@"perid"];
        
        [medicationInfo setObject:[results stringForColumn:@"visitid"] forKey:@"visitid"];
        [medicationInfo setObject:[results stringForColumn:@"name"] forKey:@"name"];
        
        [medicationInfo setObject:[results stringForColumn:@"use"] forKey:@"use"];
        
        [medicationInfo setObject:[results stringForColumn:@"freq"] forKey:@"freq"];
        
        [medicationInfo setObject:[results stringForColumn:@"food"] forKey:@"food"];
        [medicationInfo setObject:[results stringForColumn:@"image"] forKey:@"image"];
        
        
        [medicationList addObject:medicationInfo];
    }
    results=NULL;
    [db close];
    return medicationList;
    
}
-(NSString *)getImageFullPath:(NSString *)imageName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:imageName]; //Add the file name
    return filePath;
    
}
-(NSString *)saveImage:(UIImage *)sourceImage imageFileNamePrefix:(NSString *)prefix
{
    NSData *pngData = UIImagePNGRepresentation(sourceImage);
    NSString  *imgName = [[NSString alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    imgName =[NSString stringWithFormat:@"%@_%@_image.png",prefix,self.timeStamp];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:imgName]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    return imgName;
}
- (NSString *) timeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

@end
