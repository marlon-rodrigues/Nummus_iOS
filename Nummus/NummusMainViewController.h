//
//  NummusMainViewControllerViewController.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeExpensesData.h"
#import "NummusMainViewControllerAppDelegate.h"
#import "PreferencesData.h"

@interface NummusMainViewController : UIViewController 
{
    NummusMainViewControllerAppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UILabel *totalSavings;

//Instance Methods
- (void) totalIncomeExpensesValues:(NSMutableArray *)incExpArray;
- (void) defineColorLabelTotalSavings: (double)totalSavingsDefined;
- (void) getDataToCalculateSavings;

//Buttons
- (IBAction)buttonPreferences:(UIButton *)sender;
- (IBAction)buttonIncome:(UIButton *)sender;
- (IBAction)buttonReport:(UIButton *)sender;
- (IBAction)buttonExpenses:(UIButton *)sender;

@end
