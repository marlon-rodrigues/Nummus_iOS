//
//  CategoryData.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIkit.h>
#import <sqlite3.h>

@interface CategoryData : NSObject

@property (nonatomic, readonly) NSInteger ctg000ID;
@property (nonatomic, copy) NSString *ctg000Name;
@property (nonatomic, copy) NSNumber *ctg000isIncome;

//Property to be used for the table view
@property (nonatomic, copy) NSNumber *ctgSumAmount;

//Class methods
+ (NSMutableArray *) getCategoriesToDisplay:(NSString *)dbPath filterBy:(int)filter;
+ (void) finalizeStatements;
+ (BOOL) validateNewCategory:(NSString *)dbPath filterBy:(int)filter compareTo:(NSString *)nameCategory;

//Instance methods
- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) addCategory:(NSString *)dbPath;

@end
