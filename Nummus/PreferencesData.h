//
//  PreferencesData.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIkit.h>
#import <sqlite3.h>

@interface PreferencesData : NSObject

@property (nonatomic, readonly) NSInteger pfr000Sound;
@property (nonatomic, readonly) NSInteger pfr000ShowSavings;

//Class Methods
+ (NSInteger) getPreferences:(NSString *)dbPath withFilter:(int)filter;
+ (void) updatePreferences:(NSString *)dbPath soundPlay:(NSInteger)isOn showBy:(NSInteger)userSelection;
+ (void) finalizeStatements;

@end
