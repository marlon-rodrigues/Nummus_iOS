//
//  AccountData.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccountData.h"
#import "NummusMainViewControllerAppDelegate.h"

static sqlite3 *database = nil;

@implementation AccountData

@synthesize acc000ID = _acc000ID;
@synthesize acc000Name = _acc000Name;
@synthesize accSumAmount = _accSumAmount;

+ (NSMutableArray *) getAccountsToDisplay:(NSString *)dbPath
{
    NSMutableArray *arrayAccounts = [[NSMutableArray alloc]init];
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        const char *sql = "select _id, Name from Acc000";
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                AccountData *accountObj = [[AccountData alloc] initWithPrimaryKey:primaryKey];
                accountObj.acc000Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                
                [arrayAccounts addObject:accountObj];
            }
            sqlite3_finalize(selectstmt);
        }
    }

    //Close the connection with the database
    [self finalizeStatements];
    
    return arrayAccounts;
}

+ (void) finalizeStatements
{
    if(database)
    {
        sqlite3_close(database);
    }
}

- (id) initWithPrimaryKey:(NSInteger)pk 
{
    self = [super init];
    
    _acc000ID = pk;
    
    return self;
}


@end
