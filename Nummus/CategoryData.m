//
//  CategoryData.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryData.h"
#import "NummusMainViewControllerAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *add_Stmt = nil;

@implementation CategoryData
@synthesize ctg000ID = _ctg000ID;
@synthesize ctg000Name = _ctg000Name;
@synthesize ctg000isIncome = _ctg000isIncome;
@synthesize ctgSumAmount = _ctgSumAmount;

+ (NSMutableArray *) getCategoriesToDisplay:(NSString *)dbPath filterBy:(int)filter
{
    NSMutableArray *arrayCategories = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        NSString *querySql = [NSString stringWithFormat:@"SELECT _id, name FROM ctg000 where isIncome = %i order by name",filter];
        const char *sql = [querySql UTF8String];
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                CategoryData *categoryObj = [[CategoryData alloc] initWithPrimaryKey:primaryKey];
                categoryObj.ctg000Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                
                [arrayCategories addObject:categoryObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }
  
    //Close the connection with the database
    [self finalizeStatements];
    
    return arrayCategories;
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
}

+ (BOOL) validateNewCategory:(NSString *)dbPath filterBy:(int)filter compareTo:(NSString *)nameCategory
{
    BOOL _validated = YES;
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        const char *sql = "SELECT name, isIncome FROM ctg000";
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                NSString *stringToCompare = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
                int _isIncome = sqlite3_column_int(selectstmt, 1);
                
                if (filter == 0)
                {
                    if (_isIncome == 0 && [stringToCompare.lowercaseString isEqualToString:nameCategory.lowercaseString])
                    {
                        _validated = NO;
                    }
                }
                else 
                {
                    if (_isIncome == 1 && [stringToCompare.lowercaseString isEqualToString:nameCategory.lowercaseString])
                    {
                        _validated = NO;
                    }
                }
            }
            sqlite3_finalize(selectstmt);
        }
    }

    //Close the connection with the database
    [self finalizeStatements];
    
    return _validated;
}

- (id) initWithPrimaryKey:(NSInteger)pk 
{
    self = [super init];
    
    _ctg000ID = pk;
    
    return self;
}

- (void) addCategory:(NSString *)dbPath
{
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        if (add_Stmt == nil)
        {
            const char *sql = "INSERT into ctg000(name, isIncome) values(?,?)";
            if (sqlite3_prepare_v2(database, sql, -1, &add_Stmt, NULL) != SQLITE_OK)
            {
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
        }
        
        sqlite3_bind_text(add_Stmt, 1, [_ctg000Name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(add_Stmt, 2, [_ctg000isIncome intValue]);
        
        if (sqlite3_step(add_Stmt) != SQLITE_DONE)
        {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
        else
        {
            _ctg000ID = sqlite3_last_insert_rowid(database);
        }
        
        //Reset the statement
        //sqlite3_reset(add_Stmt); DOESN`T WORK
        add_Stmt = nil;
    }

    //Close the connection with the database
    [CategoryData finalizeStatements];
}

@end
