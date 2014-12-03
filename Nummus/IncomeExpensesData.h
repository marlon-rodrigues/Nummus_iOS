//
//  IncomeExpensesData.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIkit.h>
#import <sqlite3.h>

@interface IncomeExpensesData : NSObject

@property (nonatomic, readonly) NSInteger incExpID;
@property (nonatomic, copy) NSString *incExpCategory;
@property (nonatomic, copy) NSNumber *incExpAmount;
@property (nonatomic, copy) NSString *incExpDate;
@property (nonatomic, copy) NSString *incExpAccount;
@property (nonatomic, copy) NSNumber *incExpIsIncome;
@property (nonatomic, copy) NSDate *incExpFormattedDate;

//Class methods
+ (NSMutableArray *) getInitialDataToDisplay: (NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year;
+ (NSMutableArray *) getDataToDisplayInReport: (NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year;
+ (NSMutableArray *) getDataToDisplayByAccount: (NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year;
+ (NSMutableArray *) getDataToDisplayByCategory: (NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year;
+ (NSMutableArray *) getDataToDisplayByIsIncome: (NSString *)dbPath onMonth:(NSString *)month onYear:(NSString *)year;
+ (NSMutableArray *) getDataForPDF: (NSString *)dbPath onMonth:(NSString *)month onYear:(NSString *)year;;
+ (void) finalizeStatements;

//Instance methods
- (id) initWithPrimaryKey:(NSInteger)pk;
- (BOOL) addIncomeExpense:(NSString *)dbPath;
- (BOOL) deleteIncomeExpense: (NSString *)dbPath withID:(int)idToDelet;
- (NSNumber *) getIdCategory:(NSString *)nameCategory;
- (NSNumber *) getIdAccount:(NSString *)nameAccount;
- (NSString *) getNameCategory:(int)idCategory;
- (NSString *) getNameAccount:(int)idAccount;

@end
