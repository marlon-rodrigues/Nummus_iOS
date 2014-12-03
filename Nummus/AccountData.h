//
//  AccountData.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIkit.h>
#import <sqlite3.h>


@interface AccountData : NSObject

@property (nonatomic, readonly) NSInteger acc000ID;
@property (nonatomic, copy) NSString *acc000Name;

//Property to be used for graph
@property (nonatomic, copy) NSNumber *accSumAmount;

//Class methods
+ (NSMutableArray *) getAccountsToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
