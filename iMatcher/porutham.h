//
//  porutham.h
//  iPorutham
//
//  Created by S Arivoli on 9/25/12.
//  Copyright (c) 2012 Arivoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface porutham : NSObject
{
    NSError *Myerror;
}

+(void)initialize;
-(NSString*)dinaPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)ganaPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)mahendraPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)sthreePorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)yoniPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)rashiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)rashiAthipathiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)vasiyaPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)rajjuPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)vedhaiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)nadiPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;
-(NSString*)maraPorutham:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;


-(NSString*)getOrderIndex:(int)boyIndex girlIndex:(int)girlIndex totalCount:(int)totlCnt;
-(NSDictionary*)getPoruthamResult:(NSArray*) boyInfo girlStar: (NSArray*) girlInfo;

-(NSArray*) getRasiInfo:(NSString*)idn;
-(NSArray*) getStarInfo:(NSString*)idn;
-(NSArray*)getPoruthamList;
-(NSArray*) getLanguages;


-(NSString*)getOverAllResult:(NSDictionary*)result;
-(void)saveUserInfo:(NSMutableDictionary*)userInfo;
-(void)saveLanguage:(NSString*)sLanguage;

-(NSMutableDictionary*)getUserInfo;
-(void)saveDefault:(NSString*)sDefault;

-(NSDictionary*)getPoruthamInfo:(int)Idn;

-(NSArray*)getStars;
-(NSArray*)getRasi;
@end
