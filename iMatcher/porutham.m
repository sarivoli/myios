    //
//  porutham.m
//  iPorutham
//
//  Created by S Arivoli on 9/25/12.
//  Copyright (c) 2012 Arivoli. All rights reserved.
//

#import "porutham.h"
#define kUthamam  @"Uthamam" //Good
#define kMathimam @"Mathimam" //Not Bad
#define kAthamam @"Athamam" //Bad
#define kTotStar 27
#define kTotRasi 12


//static NSMutableArray *stars,*rasi;
//static NSMutableDictionary *poruthamList,*plistDictionary;
//static FMDatabase *db;
static NSString *dataBasePath, *dataBaseName;
static BOOL dbExists;

@implementation porutham
+ (void) initialize
{
     dataBaseName = @"sMatcher.sqlite";
    
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
            FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select appver from userinfo"]];
            while ([results next]) {
                NSLog(@"APP Version: %@",[results stringForColumn:@"appver"]);
                if([[NSString stringWithFormat:@"%@",[results stringForColumn:@"appver"] ] isEqualToString:@"2"]){
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
-(NSArray*) getStarInfo:(NSString*)idn{
    /* Returns star information for a given idn or entire list */
    NSDictionary *userInfo = [self getUserInfo];
    
    NSMutableArray *starInfo = [[NSMutableArray alloc]init];
    NSString *whereClass=@"";
    if(idn!=nil)
        {
        whereClass = [NSString stringWithFormat:@" AND st.idn=%@ ",idn];
        }
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"SELECT st.idn,slang.star_name as name,st.description,st.ORDERINDEX, st.ganam,st.yoni, st.yonidesc, st.rajju,st.vedhastaridn,st.tree,st.nadi,ras.idn rasiIdn,ras.rasi_name, ras.rasi_desc,ras.img FROM STARS st left Join rasi ras on(st.rasiIdn=ras.idn) left join star_lang slang on(slang.star_idn = st.idn and slang.lang_idn=%@) WHERE st.ACTIVE='Y'  %@ ORDER BY st.ORDERINDEX, st.IDN",[userInfo objectForKey:@"langidn" ],whereClass]];
                            
    while ([results next]) {
        NSMutableDictionary *infoObj =[[NSMutableDictionary alloc]init];
        [infoObj setObject:[results stringForColumn:@"name"] forKey:@"name"];
        [infoObj setObject:[results stringForColumn:@"description"] forKey:@"desc"];        
        [infoObj setObject:[results stringForColumn:@"idn"] forKey:@"idn"];   
        [infoObj setObject:[results stringForColumn:@"ganam"] forKey:@"ganam"];   
        [infoObj setObject:[results stringForColumn:@"yoni"] forKey:@"yoni"];   
        [infoObj setObject:[results stringForColumn:@"yonidesc"] forKey:@"yonidesc"];   
        [infoObj setObject:[results stringForColumn:@"rajju"] forKey:@"rajju"];    
        [infoObj setObject:[results stringForColumn:@"vedhastaridn"] forKey:@"vedhaidn"];    
        [infoObj setObject:[results stringForColumn:@"tree"] forKey:@"tree"];    
        [infoObj setObject:[results stringForColumn:@"rasiIdn"] forKey:@"rasiIdn"];  
        [infoObj setObject:[results stringForColumn:@"rasi_name"] forKey:@"rasiName"];
        [infoObj setObject:[results stringForColumn:@"rasi_desc"] forKey:@"rasiDesc"];
        [infoObj setObject:[results stringForColumn:@"img"] forKey:@"img"];


        [infoObj setObject:[results stringForColumn:@"nadi"] forKey:@"nadi"];

//        [infoObj setObject:[results stringForColumn:@"rajju"] forKey:@"rajju"];   

        
        [infoObj setObject:[results stringForColumn:@"ORDERINDEX"] forKey:@"order"];        


        [starInfo addObject:infoObj];
        //[starInfo addObject:[results stringForColumn:@"name"]];
        //NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    return starInfo;
}
-(NSArray*) getRasiInfo:(NSString*)idn{
    /* Returns star information for a given idn or entire list */
    NSMutableArray *rasiInfo = [[NSMutableArray alloc]init];
    NSString *whereClass=@"";
    if(idn!=nil)
        {
        //NSLog(@"Idn in param %@",idn);
        whereClass = [NSString stringWithFormat:@" AND idn=%@ ",idn];
        }
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT idn,rasi_name,rasi_desc,planet_idn,vasiya_rasi,ORDERINDEX FROM RASI WHERE ACTIVE='Y' %@ ORDER BY ORDERINDEX, IDN",whereClass]];
    while ([results next]) {
        NSMutableDictionary *infoObj =[[NSMutableDictionary alloc]init];
        [infoObj setObject:[results stringForColumn:@"rasi_name"] forKey:@"name"];
        [infoObj setObject:[results stringForColumn:@"rasi_desc"] forKey:@"desc"];        
        [infoObj setObject:[results stringForColumn:@"idn"] forKey:@"idn"];    
        [infoObj setObject:[results stringForColumn:@"planet_idn"] forKey:@"planet_idn"];    
        [infoObj setObject:[results stringForColumn:@"vasiya_rasi"] forKey:@"vasiya_rasi"];    
        [infoObj setObject:[results stringForColumn:@"ORDERINDEX"] forKey:@"order"];        

        
        [rasiInfo addObject:infoObj];
        //[starInfo addObject:[results stringForColumn:@"name"]];
        // NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    return rasiInfo;
}


-(NSArray*)getPoruthamList{
    NSMutableArray *porList = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT idn,name,desc, mandatory FROM porutham WHERE ACTIVE='Y' ORDER BY ORDERINDEX, IDN"];
    while ([results next]) {
        NSMutableDictionary *infoObj =[[NSMutableDictionary alloc]init];
        [infoObj setObject:[results stringForColumn:@"name"] forKey:@"name"];
        [infoObj setObject:[results stringForColumn:@"desc"] forKey:@"desc"];        
        [infoObj setObject:[results stringForColumn:@"idn"] forKey:@"idn"];  
        [infoObj setObject:[results stringForColumn:@"mandatory"] forKey:@"mandatory"];    

        
        [porList addObject:infoObj];

        //NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    return porList;
}


-(NSArray*)getStars{
    NSMutableArray *starList = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT name FROM STARS WHERE ACTIVE='Y' ORDER BY ORDERINDEX, IDN"];
    while ([results next]) {
        [starList addObject:[results stringForColumn:@"name"]];
        //NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    return starList;
}
-(NSArray*)getRasi{
    NSMutableArray *rasiList = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:@"SELECT rasi_name FROM RASI WHERE ACTIVE='Y'  ORDER BY ORDERINDEX, IDN"];
    while ([results next]) {
        [rasiList addObject:[results stringForColumn:@"rasi_name"]];
        //NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    
    return  rasiList;
    
}
-(NSString*)dinaPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo
{    

    int girlStarIndex = [[[girlInfo objectAtIndex:0]  objectForKey:@"order"] intValue];
    int boyStarIndex = [[[boyInfo objectAtIndex:0] objectForKey:@"order"] intValue];
    int starCount =[[self getOrderIndex:boyStarIndex girlIndex:girlStarIndex totalCount:kTotStar] intValue ] ;
    //NSLog(@"boy index %i, girl index %i", boyStarIndex, girlStarIndex);
    //  NSLog(@"dina Match Count %i", starCount);
    NSArray *dinaMatchValues =[[NSArray alloc]initWithObjects:@"2",@"4",@"6",@"8",@"11",@"13",@"15",@"18",@"20",@"24",@"26", nil];
    
    //If both are having same star
    if(girlStarIndex==boyStarIndex)
        {    
            if(starCount==27)
                {
                return kUthamam;
                }
            //Rohini, Thiruvathirai, Poosam, Maham, Hastham, Thirivonam -- Uthamam match
            NSArray *sameStarUthamamMatch =[[NSArray alloc]initWithObjects:@"4",@"6",@"8",@"10",@"13",@"22",nil];
            if([sameStarUthamamMatch indexOfObject:[NSString stringWithFormat:@"%i", boyStarIndex]]!=NSNotFound)
            {
                       
                return kUthamam;
            }
            //Ashwini, Bharani, Karthikai, Mrigashrish, Punarpoosam, Uthiram, Chithirai, Anusham --Mathimam match
            NSArray *sameStarMathimamMatch =[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"5",@"7",@"12",@"14",@"17",nil];
            if([sameStarMathimamMatch indexOfObject:[NSString stringWithFormat:@"%i", boyStarIndex]]!=NSNotFound)
            {

                return kMathimam;
            }
            return kAthamam;
        }else if(starCount==7 | starCount==22){
                return kAthamam;
        }else if ([dinaMatchValues indexOfObject:[NSString stringWithFormat:@"%i", starCount]] !=NSNotFound) {
            // NSLog(@"result is %@",[dinaMatchValues indexOfObject:[NSString stringWithFormat:@"%@", starCount]]);
                return kUthamam;
        }
    
        
    return kAthamam;
}
-(NSString*)ganaPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSString *girlGanam = [[girlInfo objectAtIndex:0]  objectForKey:@"ganam"];
    NSString *boyGanam = [[boyInfo objectAtIndex:0]  objectForKey:@"ganam"];
    
    //If both boy and girl belongs to Rakshash gana the match is uthamam.
    
    if([girlGanam isEqualToString:@"D"])
        {
            if([boyGanam isEqualToString:@"D"])
            {
                return kUthamam;
            }
            return kMathimam;
        }else if ([girlGanam isEqualToString:@"M"]) {
            if([boyGanam isEqualToString:@"M"])
                {
                return kUthamam;
                }
                return kMathimam;                
        }else if ([boyGanam isEqualToString:@"D"]) {
            return kMathimam;
        }else if ([boyGanam isEqualToString:@"R"]) {
            return kMathimam;
        }
    return kAthamam;
   
}
-(NSString*)mahendraPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    
    //boy star should be in 4,7,10,13,16,19,22,25 position
    int girlStarIndex = [[[girlInfo objectAtIndex:0]  objectForKey:@"order"] intValue];
    int boyStarIndex = [[[boyInfo objectAtIndex:0] objectForKey:@"order"] intValue];
    NSArray *matchIndexList = [[ NSArray alloc]initWithObjects:@"1",@"4",@"7",@"10",@"13",@"16",@"19",@"22",@"25", nil];
//    int starCount =0;
//    if(boyStarIndex > girlStarIndex)
//        {
//        starCount = boyStarIndex - girlStarIndex +1;
//        }else {
//            starCount = (kTotStar - girlStarIndex)+boyStarIndex + 1;
//        }
    if([matchIndexList indexOfObject:[self getOrderIndex:boyStarIndex girlIndex:girlStarIndex totalCount:kTotStar] ]!=NSNotFound){
        return kUthamam;
    }
    return kAthamam;

}
-(NSString*)sthreePorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    int girlStarIndex = [[[girlInfo objectAtIndex:0]  objectForKey:@"order"] intValue];
    int boyStarIndex = [[[boyInfo objectAtIndex:0] objectForKey:@"order"] intValue];
    int starCount = [[self getOrderIndex:boyStarIndex girlIndex:girlStarIndex totalCount:kTotStar] intValue ];
//    int starCount =0;
//    if(boyStarIndex > girlStarIndex)
//        {
//        starCount = boyStarIndex - girlStarIndex +1;
//        }else {
//            starCount = (kTotStar - girlStarIndex)+boyStarIndex + 1;
//        }
    if(starCount>13){
        return kUthamam;
    }else if (starCount>7) {
        return kMathimam;
    }
    return kAthamam;
    
}
-(NSString*)yoniPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    
    NSDictionary *enimy = [[NSDictionary alloc]initWithObjectsAndKeys:@"Cow",@"Tiger",@"Elephant",@"Lion",@"Snake",@"Keeri",@"Monkey",@"Goat",@"Rat",@"Cat",@"Dog",@"Deer",@"Horse",@"Buffalo", nil];
    NSString *fAnimal = [[girlInfo objectAtIndex:0]  objectForKey:@"yonidesc"];
    NSString *mAnimal = [[boyInfo objectAtIndex:0]  objectForKey:@"yonidesc"]; 
    NSString *fyoni = [[girlInfo objectAtIndex:0]  objectForKey:@"yoni"];
    NSString *myoni = [[boyInfo objectAtIndex:0]  objectForKey:@"yoni"]; 
    if([enimy objectForKey:fAnimal]==mAnimal)
        {
            return kAthamam;
        }
    if([fyoni isEqualToString:@"F"])
        {
            if([myoni isEqualToString:@"M"])
                {
                    return kAthamam;
                }
        return kMathimam;
        }else if ([myoni isEqualToString:@"M"]) {
            return kMathimam;
        }
                
    return kAthamam;
}
-(NSString*)rashiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSLog(@"Entering into rasi porutham %@, %@", boyInfo, girlInfo);
    NSString *fRasiIndex=[[girlInfo objectAtIndex:1]  objectForKey:@"order"];
    NSString *mRasiIndex=[[boyInfo objectAtIndex:1]  objectForKey:@"order"];
    NSArray *noMatchIndex=[[NSArray alloc]initWithObjects:@"2",@"3",@"4",@"6",@"8", nil];
    NSArray *noGoodRasi=[[NSArray alloc]initWithObjects:@"11", @"5", @"4",@"10", nil];
    NSArray *goodMatchIndex=[[NSArray alloc]initWithObjects:@"1",@"7",@"9",@"10",@"11",@"12", nil];

    NSString *rasiCount =[self getOrderIndex:[mRasiIndex intValue] girlIndex:[fRasiIndex intValue] totalCount:kTotRasi];
    if([noMatchIndex indexOfObject:rasiCount]!=NSNotFound)
        {
            return kAthamam;
        }else if ([goodMatchIndex indexOfObject:rasiCount]!=NSNotFound) {
            if([rasiCount isEqualToString:@"7"])
                {
                    if([noGoodRasi indexOfObject:mRasiIndex]==NSNotFound)
                    {
                        return kUthamam;
                    }else {
                        return kAthamam;
                    }
                }
            return kUthamam;
        }
    return kAthamam;

}
-(NSString*)rashiAthipathiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSString *fPlanetInd=[[girlInfo objectAtIndex:1]  objectForKey:@"planet_idn"];
    NSString *mPlanetIdn=[[boyInfo objectAtIndex:1]  objectForKey:@"planet_idn"];
    NSString *whereClass =[[NSString alloc]initWithFormat:@"AND ((planet_idn = %@ AND map_planet_idn=%@) OR (planet_idn = %@ AND map_planet_idn=%@))",fPlanetInd,mPlanetIdn,mPlanetIdn,fPlanetInd];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT planet_idn, map_planet_idn, map_code FROM PLANETMAP WHERE ACTIVE='Y' %@ ",whereClass]];
    //NSLog(@"SELECT planet_idn, map_planet_idn, map_code FROM PLANETMAP WHERE ACTIVE='Y' %@ ",whereClass);
    NSMutableArray *planetRes = [[NSMutableArray alloc]init];
    while ([results next]) {
        [planetRes addObject:[results stringForColumn:@"map_code"]]; 
    }
    //NSLog(@"Male Planet = %@, Female Plane =%@",mPlanetIdn, fPlanetInd);
    //NSLog(@"Planet Information %@",planetRes);
    [db close];
    if ([planetRes count]>1) {
        if ([planetRes indexOfObject:@"F"]!=NSNotFound && [planetRes indexOfObject:@"X"]!=NSNotFound) {
            //If one of them Friends and another one is enemy then it is mathimam
            return kMathimam;
        }else if ([planetRes indexOfObject:@"E"]!=NSNotFound && [planetRes indexOfObject:@"X"]!=NSNotFound) {
            //If one of them Equal and another one is enemy then it is Not match
            return kAthamam;
        }else if ([planetRes indexOfObject:@"F"]!=NSNotFound && [planetRes indexOfObject:@"E"]!=NSNotFound) {
            //If one of them Friends and another one is Equal then it is Uthamam
            return kUthamam;
        }else if ([[planetRes objectAtIndex:0] isEqualToString: @"F"] && [[planetRes objectAtIndex:1] isEqualToString: @"F"] ) {
            //If both are friends then it is uthamam
            return kUthamam;
        }
    }
    return kAthamam;
}
-(NSString*)vasiyaPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSArray *fVasiyaRasiIdns=[[[girlInfo objectAtIndex:1]  objectForKey:@"vasiya_rasi"] componentsSeparatedByString:@","];
    NSString *mRasiIdn=[[boyInfo objectAtIndex:1]  objectForKey:@"idn"];
    if ([fVasiyaRasiIdns indexOfObject:mRasiIdn]!=NSNotFound) {
        return kUthamam;
    }
    return kAthamam;
}

-(NSString*)rajjuPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSString *frajju=[[girlInfo objectAtIndex:0]  objectForKey:@"rajju"];
    NSString *mrajju=[[boyInfo objectAtIndex:0]  objectForKey:@"rajju"];
    if([frajju isEqual:mrajju]){
        return kAthamam;
    }
    return kUthamam;
    
}
-(NSString*)vedhaiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSString *fVedhaIdn=[[girlInfo objectAtIndex:0]  objectForKey:@"vedhaidn"];
    NSString *mVedhaIdn=[[boyInfo objectAtIndex:0]  objectForKey:@"vedhaidn"];

    NSString *mOrderIdn=[[boyInfo objectAtIndex:0]  objectForKey:@"order"];
    if ([fVedhaIdn isEqual:mOrderIdn] || ([fVedhaIdn isEqual:@"0"] && [mVedhaIdn isEqual:@"0"])) {
        return kAthamam;
    }
    return kUthamam;

}
-(NSString*)nadiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSString *fNaadi=[[girlInfo objectAtIndex:0]  objectForKey:@"nadi"];
    NSString *mNaadi=[[boyInfo objectAtIndex:0]  objectForKey:@"nadi"];
    if([fNaadi isEqual:mNaadi] && ([fNaadi isEqual:@"E"] && [mNaadi isEqual:@"E"]))
        {
            return kAthamam;
        }
    return kUthamam;
}
-(NSString*)maraPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo{
    NSString *fTree=[[girlInfo objectAtIndex:0]  objectForKey:@"tree"];
    NSString *mTree=[[boyInfo objectAtIndex:0]  objectForKey:@"tree"];
    if([fTree isEqual:@"1"] || [mTree isEqual:@"1"])
        {
        return kUthamam;
        }

    return kAthamam;
}



-(NSString*)getOrderIndex:(int)boyIndex girlIndex:(int)girlIndex totalCount:(int)totlCnt{
    
    int starCount =0;
    if (!totlCnt) {
        totlCnt=kTotStar;
    }
    if(boyIndex > girlIndex)
        {
        starCount = boyIndex - girlIndex +1;
        }else if(boyIndex==girlIndex)
            {
                starCount = 1;
            }else
            {
                starCount = (totlCnt - girlIndex)+boyIndex + 1;
            }
    return [NSString stringWithFormat:@"%i",starCount];
}
-(NSDictionary*)getPoruthamResult:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo
{

    NSArray *poruthamListValue=  [self getPoruthamList];
    NSMutableDictionary *matchDetails = [[NSMutableDictionary alloc]init];
    //poruthamListValue = [self getPoruthamList];
    
    [matchDetails setObject:[self dinaPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:0] objectForKey:@"idn"]];
    [matchDetails setObject:[self ganaPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:1] objectForKey:@"idn"]];
    [matchDetails setObject:[self mahendraPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:2] objectForKey:@"idn"]];
    [matchDetails setObject:[self sthreePorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:3] objectForKey:@"idn"]];
    [matchDetails setObject:[self yoniPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:4] objectForKey:@"idn"]];
    
    [matchDetails setObject:[self rashiPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:5] objectForKey:@"idn"]];
    
    [matchDetails setObject:[self rashiAthipathiPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:6] objectForKey:@"idn"]];
    [matchDetails setObject:[self vasiyaPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:7] objectForKey:@"idn"]];
    [matchDetails setObject:[self rajjuPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:8] objectForKey:@"idn"]];
    [matchDetails setObject:[self vedhaiPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:9] objectForKey:@"idn"]];
    [matchDetails setObject:[self nadiPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:10] objectForKey:@"idn"]];
    [matchDetails setObject:[self maraPorutham:boyInfo girlStar:girlInfo] forKey:[[poruthamListValue objectAtIndex:11] objectForKey:@"idn"]];
    
    NSDictionary *girlStar = [girlInfo objectAtIndex:0];
    NSDictionary *boyStar = [boyInfo objectAtIndex:0];
    NSString *finalResult = @"No Match";
    int totalPorutham=0;
    
    for(int j=1,k=[matchDetails count];j<k;j++)
        {
        NSString *poruthamVal=[matchDetails objectForKey:[NSString stringWithFormat:@"%i",j]];
        if([poruthamVal isEqualToString:kUthamam] || [poruthamVal isEqualToString:kMathimam]){
            totalPorutham++;
        }
        }
    
    [matchDetails setObject:[NSString stringWithFormat:@"%i",totalPorutham] forKey:@"total"];
    
    if([[girlStar  objectForKey:@"order"] intValue] == [[boyStar objectForKey:@"order"] intValue]){
        if([[girlStar objectForKey:@"idn"]intValue]>=[[boyStar objectForKey:@"idn"] intValue ])
            {
            NSArray *greatStar = [[NSArray alloc]initWithObjects:@"4", @"6", @"10", @"13",@"16",@"22",@"26",@"27", nil]; //rohini, thiruvathirai, maham,astham, visagarm, thiruvonam, uthiratathi, revathi
            NSArray *okStar = [[NSArray alloc]initWithObjects:@"7", @"8", @"11", @"12",@"14",@"17",@"20",@"1",@"3",@"5", nil]; //punarpoosam, poosam, pooram, uthiram, chithirai, anusham, pooradam, ashwini, karthigai, mirugashrisham

            if([greatStar indexOfObject:[girlStar objectForKey:@"order"]]!=NSNotFound && ([[matchDetails objectForKey:@"9"] isEqualToString:kAthamam])!=TRUE ){
                finalResult=@"Perfect Match";
                }
            if([okStar indexOfObject:[girlStar objectForKey:@"order"]]!=NSNotFound && [[matchDetails objectForKey:@"9"] isEqualToString: kAthamam]!=TRUE){
                finalResult=@"Moderate Match";
                }
            }
        
    }else if([[matchDetails objectForKey:@"9"] isEqualToString: kAthamam]!=TRUE){ //Check if rajju is there or not
        if(totalPorutham>7){
            finalResult = @"Perfect Match";
        }else if (totalPorutham<=7 && totalPorutham>=5){
            finalResult= @"Moderate Match";
        }
        
    }
        
   
    
    
    
    [matchDetails setObject:finalResult forKey:@"result"];
    return matchDetails;
    
}
-(NSString*)getOverAllResult:(NSDictionary*)result{
    NSString *strResult = [[NSString alloc]initWithFormat:@"Get Details"];
    return strResult;
}
-(void)saveUserInfo:(NSMutableDictionary*)userInfo{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"UPDATE userinfo set gender='%@',star_idn=%@,rasi_idn=%@",[userInfo objectForKey:@"gender"],[userInfo objectForKey:@"star_idn"],[userInfo objectForKey:@"rasi_idn"]]];
    //NSLog(@"%@",userInfo);

    while ([results next]) {
        NSLog(@"Stored successfully");
    }
    results=NULL;
    [db close];
    
}
-(void)saveDefault:(NSString*)sDefault{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"UPDATE userinfo set sdefault='%@'",sDefault]];    
    while ([results next]) {
        NSLog(@"Stored successfully");
    }
    [db close];
    
}

-(void)saveLanguage:(NSString*)sLanguage{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"UPDATE userinfo set language=%@",sLanguage]];
    while ([results next]) {
        NSLog(@"Stored successfully");
    }
    [db close];
    
}
-(NSMutableDictionary*)getUserInfo{
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat: @"select ui.sdefault, ui.gender,ui.star_idn,  rasi_idn,slang.star_name  star_name,rasi.rasi_name,ln.lang_title language,ln.idn langidn from userinfo ui left join stars star on (star.idn = ui.star_idn) left join rasi on (rasi.idn =ui.rasi_idn) left join star_lang slang on(slang.star_idn = ui.star_idn and slang.lang_idn=ui.language ) left join language ln on (ln.idn = ui.language)"]];
    NSMutableDictionary *infoObj =[[NSMutableDictionary alloc]init];
    while ([results next]) {
        if([results stringForColumn:@"gender"]){
            [infoObj setObject:[results stringForColumn:@"gender"] forKey:@"gender"];
        }else {
            [infoObj setObject:@"" forKey:@"gender"];

        }
        [infoObj setObject:[results stringForColumn:@"star_idn"] forKey:@"star_idn"];        
        [infoObj setObject:[results stringForColumn:@"rasi_idn"] forKey:@"rasi_idn"];
        [infoObj setObject:[results stringForColumn:@"sdefault"] forKey:@"default"];
        [infoObj setObject:[results stringForColumn:@"language"] forKey:@"language"];
        [infoObj setObject:[results stringForColumn:@"langidn"] forKey:@"langidn"];


        if([results stringForColumn:@"star_name"]){
            [infoObj setObject:[results stringForColumn:@"star_name"] forKey:@"star_name"];    
        }else {
            [infoObj setObject:@"" forKey:@"star_name"];    

        }
        if([results stringForColumn:@"rasi_name"] )
            {
                [infoObj setObject:[results stringForColumn:@"rasi_name"] forKey:@"rasi_name"];    
            }else {
                [infoObj setObject:@"" forKey:@"rasi_name"]; 
            }
        //NSLog(@"Fetched successfully");
    }
    [db close];
    return infoObj;
    
}
-(NSDictionary*)getPoruthamInfo:(int)Idn{
    
    NSMutableDictionary *porInfo =[[NSMutableDictionary alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT idn,name,desc, mandatory FROM porutham WHERE ACTIVE='Y' AND idn=%i ORDER BY ORDERINDEX, IDN",Idn]];
    while ([results next]) {
        [porInfo setObject:[results stringForColumn:@"name"] forKey:@"title"];
        [porInfo setObject:[results stringForColumn:@"desc"] forKey:@"desc"];

        //NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    return porInfo;
}
-(NSArray*) getLanguages{
    NSMutableArray *langList = [[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT idn, langcode,lang_title FROM language where active='Y' order by idn"]];
    while ([results next]) {
        NSMutableDictionary * langInfo = [[NSMutableDictionary alloc]init];
        [langInfo setObject:[results stringForColumn:@"idn"] forKey:@"idn"];
        [langInfo setObject:[results stringForColumn:@"lang_title"] forKey:@"title"];
        [langList addObject:langInfo];
        //NSLog(@"%@",[results stringForColumn:@"name"]);
    }
    [db close];
    return langList;
    
}

@end
