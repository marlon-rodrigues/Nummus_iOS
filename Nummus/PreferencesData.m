//
//  PreferencesData.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferencesData.h"
#import "NummusMainViewControllerAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *update_Stmt = nil;

@implementation PreferencesData

@synthesize pfr000Sound = _pfr000Sound;
@synthesize pfr000ShowSavings = _pfr000ShowSavings;

+ (NSInteger) getPreferences:(NSString *)dbPath withFilter:(int)filter
{
    NSInteger _preferences = -1;
    
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        //If successful creates a select statement
        const char *sql = "SELECT * FROM pfr000";
        sqlite3_stmt *selectstmt;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(selectstmt) == SQLITE_ROW)
            {
                //0 = Sounds
                //1 = ShowBy
                if (filter == 0)
                {
                    _preferences = sqlite3_column_int(selectstmt, 0);    
                }
                else
                {
                    _preferences = sqlite3_column_int(selectstmt, 1);
                }
            }
            sqlite3_finalize(selectstmt);
        }
    }
    
    //Close the connection with the database
    [self finalizeStatements];
    
    return _preferences;
}

+ (void) updatePreferences:(NSString *)dbPath soundPlay:(NSInteger)isOn showBy:(NSInteger)userSelection
{
    //Open a conection with the dabatase
    //Consult the sqlite3 web site for references
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        if (update_Stmt == nil)
        {
            const char *sql = "UPDATE pfr000 SET sound = ?, showSavings = ?";
            if (sqlite3_prepare_v2(database, sql, -1, &update_Stmt, NULL) != SQLITE_OK)
            {
                NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database)); 
            }
        }
        
        sqlite3_bind_int(update_Stmt, 1, isOn);
        sqlite3_bind_int(update_Stmt, 2, userSelection);
        
        if (sqlite3_step(update_Stmt) != SQLITE_DONE)
        {
           NSAssert1(0, @"Error while updating data. '%s'", sqlite3_errmsg(database)); 
        }
        
        update_Stmt = nil;
    }

    [self finalizeStatements];
}

+ (void) finalizeStatements
{
    if(database)
    {
        sqlite3_close(database);
    }
    
    if (update_Stmt)
    {
        sqlite3_finalize(update_Stmt);
    }
}

@end
