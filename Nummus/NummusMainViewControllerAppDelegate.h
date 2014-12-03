//
//  NummusMainViewControllerAppDelegate.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeExpensesData.h"
#import "CategoryData.h"
#import "AccountData.h"

@interface NummusMainViewControllerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Determine if the databse is or isn`t in the phone
- (void) copyDataBaseIfNeeded;
//Get the path of the database
- (NSString *) getDBPath;

@end
