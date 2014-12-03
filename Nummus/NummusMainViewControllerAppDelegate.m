//
//  NummusMainViewControllerAppDelegate.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NummusMainViewControllerAppDelegate.h"

@implementation NummusMainViewControllerAppDelegate

@synthesize window = _window;

#pragma mark - My methods
//My Methods
//*********************************************************************************************************************************************************
- (void) copyDataBaseIfNeeded 
{
    //Using NSFileManager we can perfome many file system operations
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    //Gets the path in phone that should contain the database
    NSString *dbPath = [self getDBPath];
    
    //Check to see if exists in the phone
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    //If not, creates 
    if (!success)
    {
        //Gets the database from the resources files in my project
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DBNummus.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
        {
            NSAssert1(0, @"Failed to create writable database file with message '%@'", [error localizedDescription]);
        }
    }
}

- (NSString *) getDBPath
{
    //Search for standard documents using NSSearchPathForDirectionsInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the users directory and not the system
    //Expand any tildes and identify home directories
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"DBNummus.sqlite"]; 
}

//*********************************************************************************************************************************************************

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //My Code
    //Copy database to the user`s phone if needed
    [self copyDataBaseIfNeeded];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //If there is any connection with the database open, close it
    [IncomeExpensesData finalizeStatements];
}

@end
