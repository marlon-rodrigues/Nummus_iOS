//
//  IncomeExpensesData.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IncomeExpensesData.h"
#import "NummusMainViewControllerAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *add_Stmt = nil;
static sqlite3_stmt *delete_Stmt = nil;

@implementation IncomeExpensesData
{
    NSNumber *values;
    NSNumber *subValues;
}

@synthesize incExpID = _incExpID;
@synthesize incExpCategory = _incExpCategory;
@synthesize incExpAmount = _incExpAmount;
@synthesize incExpDate = _incExpDate;
@synthesize incExpAccount = _incExpAccount;
@synthesize incExpIsIncome = _incExpIsIncome;
@synthesize incExpFormattedDate = _incExpFormattedDate;

+ (NSMutableArray *) getInitialDataToDisplay:(NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year
{
    NSMutableArray *incExpArray = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        NSString *querySql;
        switch (filter)
        {
                //0 = Month, 1 = Year, 2 = All 
            case 0:
                querySql = [NSString stringWithFormat:@"SELECT _id, Amount, isIncome from IncExp WHERE date LIKE '%@%%' AND date LIKE '%%%@'", month, year];
                break;
            case 1:
                querySql = [NSString stringWithFormat:@"SELECT _id, Amount, isIncome from IncExp WHERE date LIKE '%%%@'",year];
                break;
            case 2:
                querySql = [NSString stringWithFormat:@"SELECT _id, Amount, isIncome from IncExp"];
                break;
            default:
                break;
        }
        
        //const char *sql = "select _id, Amount, isIncome from IncExp";
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                
                IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc] initWithPrimaryKey:primaryKey];
                incExpObj.incExpAmount = [NSNumber numberWithDouble:(double)sqlite3_column_double(selectstmt, 1)];
                incExpObj.incExpIsIncome = [NSNumber numberWithInt:(int)sqlite3_column_int(selectstmt, 2)];
                
                [incExpArray addObject:incExpObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }

    //Close the connection with the database
    [self finalizeStatements];
    
    return incExpArray;
}

+ (NSMutableArray *) getDataToDisplayInReport:(NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year;
{
    NSMutableArray *arrayListIncome = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        NSString *querySql = [NSString stringWithFormat:@"SELECT _id, Category, Amount, Date, Account, isIncome FROM IncExp WHERE date LIKE '%@%%' AND date LIKE '%%%@' AND isIncome = %i ORDER BY isIncome, date", month, year, filter];
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                
                IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc] initWithPrimaryKey:primaryKey];
                
                int idCategory = sqlite3_column_int(selectstmt, 1);
                incExpObj.incExpAmount = [NSNumber numberWithDouble:(double)sqlite3_column_double(selectstmt, 2)];
                incExpObj.incExpDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
                int idAccount = sqlite3_column_int(selectstmt, 4);
                incExpObj.incExpIsIncome = [NSNumber numberWithInt:(int)sqlite3_column_int(selectstmt, 5)];
                incExpObj.incExpCategory = [incExpObj getNameCategory:idCategory];
                incExpObj.incExpAccount = [incExpObj getNameAccount:idAccount];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                incExpObj.incExpFormattedDate = [dateFormatter dateFromString:incExpObj.incExpDate];
                
                [arrayListIncome addObject:incExpObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }

    //Close the connection with the database
    [self finalizeStatements];
    
    return arrayListIncome;
}

+ (NSMutableArray *) getDataToDisplayByAccount:(NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year
{
    NSMutableArray *arraySumAccounts = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        
        //Original SQL
        //SELECT category , sum(amount), date FROM incexp WHERE date like "07%" and date like"%2012" AND isIncome = 0 group by category 
        NSString *querySql = [NSString stringWithFormat:@"SELECT account, SUM(amount) FROM IncExp WHERE date LIKE '%@%%' AND date LIKE '%%%@' AND isIncome = %i GROUP BY account", month, year, filter];
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                AccountData *accObj = [[AccountData alloc]init];
                IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc]init];
                
                int idAccount = sqlite3_column_int(selectstmt, 0);
                accObj.acc000Name = [incExpObj getNameAccount:idAccount];
                accObj.accSumAmount = [NSNumber numberWithDouble:(double)sqlite3_column_double(selectstmt, 1)];   
            
                [arraySumAccounts addObject:accObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }

    //Close the connection with the database
    [self finalizeStatements];
    
    return arraySumAccounts;
}

+ (NSMutableArray *) getDataToDisplayByCategory:(NSString *)dbPath withFilter:(int)filter onMonth:(NSString *)month onYear:(NSString *)year
{
    NSMutableArray *arraySumCategory = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        NSString *querySql = [NSString stringWithFormat:@"SELECT category, SUM(amount) FROM IncExp WHERE date LIKE '%@%%' AND date like '%%%@' AND isIncome = %i GROUP BY category", month, year, filter];
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                CategoryData *ctgObj = [[CategoryData alloc]init];
                IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc]init];
                
                int idCategory = sqlite3_column_int(selectstmt, 0);
                ctgObj.ctg000Name = [incExpObj getNameCategory:idCategory];
                ctgObj.ctgSumAmount = [NSNumber numberWithDouble:(double)sqlite3_column_double(selectstmt, 1)];   
                
                [arraySumCategory addObject:ctgObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }

    //Close the connection with the database
    [self finalizeStatements];
    
    return arraySumCategory;
}

+ (NSMutableArray *) getDataToDisplayByIsIncome:(NSString *)dbPath onMonth:(NSString *)month onYear:(NSString *)year
{
    NSMutableArray *arrayListIncExp = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        NSString *querySql = [NSString stringWithFormat:@"SELECT isIncome, SUM(amount) FROM IncExp WHERE date LIKE '%@%%' AND date like '%%%@' GROUP BY isIncome ORDER BY isIncome", month, year];
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc] init];
                
                incExpObj.incExpIsIncome = [NSNumber numberWithInt:(int)sqlite3_column_int(selectstmt, 0)];
                incExpObj.incExpAmount = [NSNumber numberWithDouble:(double)sqlite3_column_double(selectstmt, 1)];
                
                [arrayListIncExp addObject:incExpObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }
    
    //Close the connection with the database
    [self finalizeStatements];
    
    return arrayListIncExp;
}

+ (NSMutableArray *) getDataForPDF:(NSString *)dbPath onMonth:(NSString *)month onYear:(NSString *)year
{
    NSMutableArray *arrayListIncExp = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        NSString *querySql = [NSString stringWithFormat:@"SELECT _id, Category, Amount, Date, Account, isIncome FROM IncExp WHERE date LIKE '%@%%' AND date like '%%%@' ORDER BY isIncome, date", month, year];
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc] initWithPrimaryKey:primaryKey];
                
                NSInteger _idCategory = sqlite3_column_int(selectstmt, 1);
                incExpObj.incExpAmount = [NSNumber numberWithDouble:(double)sqlite3_column_double(selectstmt, 2)];
                incExpObj.incExpDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
                NSInteger _idAccount = sqlite3_column_int(selectstmt, 4);
                incExpObj.incExpIsIncome = [NSNumber numberWithInt:(int)sqlite3_column_int(selectstmt, 5)];
                incExpObj.incExpCategory = [incExpObj getNameCategory:_idCategory];
                incExpObj.incExpAccount = [incExpObj getNameAccount:_idAccount];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                incExpObj.incExpFormattedDate = [dateFormatter dateFromString:incExpObj.incExpDate];
                
                [arrayListIncExp addObject:incExpObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }
    
    //Close the connection with the database
    [self finalizeStatements];
    
    return arrayListIncExp;
}

+ (void) finalizeStatements
{
    if(database)
    {
        sqlite3_close(database);
    }
    
    if (add_Stmt)
    {
        sqlite3_finalize(add_Stmt);   
    }
    
    if (delete_Stmt)
    {
        sqlite3_finalize(delete_Stmt);
    }
}

- (id) initWithPrimaryKey:(NSInteger)pk 
{
    self = [super init];
    
    _incExpID = pk;
    
    return self;
}

- (BOOL) addIncomeExpense:(NSString *)dbPath
{
    BOOL _incExpAdded = NO;
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        if (add_Stmt == nil)
        {
            const char *sql = "INSERT into incexp(category, amount, date, account, isIncome) values(?,?,?,?,?)";
            if (sqlite3_prepare_v2(database, sql, -1, &add_Stmt, NULL) != SQLITE_OK)
            {
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
        }
        
        NSNumber *_idCategory = [self getIdCategory:_incExpCategory];
        NSNumber *_idAccount = [self getIdAccount:_incExpAccount];
        
        sqlite3_bind_int(add_Stmt, 1, [_idCategory intValue]);
        sqlite3_bind_double(add_Stmt, 2, [_incExpAmount doubleValue]);
        sqlite3_bind_text(add_Stmt, 3, [_incExpDate UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(add_Stmt, 4, [_idAccount intValue]);
        sqlite3_bind_int(add_Stmt, 5, [_incExpIsIncome intValue]);
        
        if (sqlite3_step(add_Stmt) != SQLITE_DONE)
        {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
        else
        {
            NSInteger primaryKey = sqlite3_last_insert_rowid(database);
            
            IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc] initWithPrimaryKey:primaryKey];
            incExpObj.incExpAmount = [NSNumber numberWithDouble:[_incExpAmount doubleValue]];
            incExpObj.incExpIsIncome = [NSNumber numberWithInt:(int)[_incExpIsIncome intValue]];
            
            _incExpAdded = YES;
        }
        
        //Reset the statement
        //sqlite3_reset(add_Stmt); DOESN`T WORK
        add_Stmt = nil;
    }

    //Close the connection with the database
    [IncomeExpensesData finalizeStatements];

    return _incExpAdded;
}

- (NSNumber *)getIdCategory:(NSString *)nameCategory 
{
    NSNumber *_idCategory = [[NSNumber alloc]init];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT _id FROM ctg000 where name = '%@'", nameCategory];
    const char *sql = [querySql UTF8String];
    sqlite3_stmt *selectstmt;
    
    if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(selectstmt) == SQLITE_ROW)
        {
            _idCategory = [NSNumber numberWithInt:sqlite3_column_int(selectstmt, 0)];
        }
        sqlite3_finalize(selectstmt);
    }
    else 
    {
        NSAssert1(0, @"Error while retrieving data. '%s'", sqlite3_errmsg(database));
    }
    
    
    return _idCategory;
}

- (NSNumber *)getIdAccount:(NSString *)nameAccount
{
    NSNumber *_idAccount = [[NSNumber alloc]init];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT _id FROM acc000 where name = '%@'", nameAccount];
    const char *sql = [querySql UTF8String];
    sqlite3_stmt *selectstmt;
    
    if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(selectstmt) == SQLITE_ROW)
        {
            _idAccount = [NSNumber numberWithInt:sqlite3_column_int(selectstmt, 0)];
        }
        sqlite3_finalize(selectstmt);
    }
    else 
    {
        NSAssert1(0, @"Error while retrieving data. '%s'", sqlite3_errmsg(database));
    }
    
    return _idAccount;
}

- (NSString *)getNameCategory:(int)idCategory
{
    NSString *_nameCategory = [[NSString alloc]init];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT name FROM ctg000 where _id = %i", idCategory];
    const char *sql = [querySql UTF8String];
    sqlite3_stmt *selectstmt;
    
    if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(selectstmt) == SQLITE_ROW)
        {
            _nameCategory = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)]; 
        }
        sqlite3_finalize(selectstmt);
    }
    else 
    {
        NSAssert1(0, @"Error while retrieving data. '%s'", sqlite3_errmsg(database));
    }
    
    
    return _nameCategory; 
}

- (NSString *)getNameAccount:(int)idAccount
{
    NSString *_nameAccount = [[NSString alloc]init];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT name FROM acc000 where _id = %i", idAccount];
    const char *sql = [querySql UTF8String];
    sqlite3_stmt *selectstmt;
    
    if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(selectstmt) == SQLITE_ROW)
        {
            _nameAccount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)]; 
        }
        sqlite3_finalize(selectstmt);
    }
    else 
    {
        NSAssert1(0, @"Error while retrieving data. '%s'", sqlite3_errmsg(database));
    }
    
    
    return _nameAccount; 
}

- (BOOL) deleteIncomeExpense:(NSString *)dbPath withID:(int)idToDelet
{
    BOOL _incExpDeleted = NO;
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        if (delete_Stmt == nil)
        {
            const char *sql = "DELETE FROM incexp WHERE _id = ?";
            if (sqlite3_prepare_v2(database, sql, -1, &delete_Stmt, NULL) != SQLITE_OK)
            {
                NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
            }
        }
                
        sqlite3_bind_int(delete_Stmt, 1, idToDelet);
        
        if (sqlite3_step(delete_Stmt) != SQLITE_DONE)
        {
            NSAssert1(0, @"Error while deleting data. '%s'", sqlite3_errmsg(database));
        }
        else
        {
            _incExpDeleted = YES;
        }

        //Reset the statement
        delete_Stmt = nil;
    }

    //Close the connection with the database
    [IncomeExpensesData finalizeStatements];
    
    return _incExpDeleted;
}


@end
