//
//  ReportViewController.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <QuickLook/QuickLook.h>
#import "NummusMainViewControllerAppDelegate.h"
#import "IncomeExpensesData.h"
#import "CategoryData.h"
#import "AccountData.h"
#import "CustomControllerCell.h"
#import "PieChartViewController.h"

@interface ReportViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIActionSheetDelegate, QLPreviewControllerDataSource>
{
    NummusMainViewControllerAppDelegate *appDelegate;
}

//Title
@property (weak, nonatomic) IBOutlet UILabel *screenTitle;

//Main Buttons
- (IBAction)incomeButton:(UIButton *)sender;
- (IBAction)expensesButton:(UIButton *)sender;
- (IBAction)reportButton:(UIButton *)sender;

//Swipe Left
- (IBAction)swipeLeftCancel:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender;

//Edit table
@property (strong, nonatomic) UITableView *tableBeingEdit;
@property (weak, nonatomic) IBOutlet UIButton *doneEditingButtonProperties;
@property (weak, nonatomic) IBOutlet UIButton *doneEditingExpenseButtonProperties;
- (IBAction)doneEditingButton:(UIButton *)sender;

//Income Properties
//*****************************************************************************************************
//SubView Buttons
- (IBAction)dateIncomeButton:(UIButton *)sender;
- (IBAction)accountIncomeButton:(UIButton *)sender;
- (IBAction)categoryIncomeButton:(UIButton *)sender;

//TableViews
@property (strong, nonatomic) IBOutlet UITableView *incomeTableView; //TAG = 1
@property (strong, nonatomic) IBOutlet UITableView *incomeCategoriesTableView; //TAG = 2

//SubViews
@property (strong, nonatomic) IBOutlet PieChartViewController *incomePieChartView; 
@property (strong, nonatomic) IBOutlet UIView *incomeCategoryView;
@property (strong, nonatomic) IBOutlet UIView *incomeListView;

//Account Income Graph Screen
- (IBAction)nextButtonAccountGraph:(UIButton *)sender;
- (IBAction)previousButtonAccountGraph:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *monthLabelAccountGraph;
@property (weak, nonatomic) IBOutlet UILabel *emptyGraphLabel;

//Category Income Screen
@property (weak, nonatomic) IBOutlet UILabel *monthLabelIncomeCategoryGraph;
@property (weak, nonatomic) IBOutlet UILabel *emptyIncomeCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalIncomeCategoryLabel;
- (IBAction)nextButtonIncomeCategory:(UIButton *)sender;
- (IBAction)previousButtonIncomeCategory:(UIButton *)sender;

//List Income Screen
@property (weak, nonatomic) IBOutlet UILabel *monthLabelIncomeList;
@property (weak, nonatomic) IBOutlet UILabel *emptyIncomeListLabel;
@property (weak, nonatomic) IBOutlet UIButton *previousButtonIncomeListProperties;
@property (weak, nonatomic) IBOutlet UIButton *nextButtonIncomeListProperties;
- (IBAction)nextButtonIncomeList:(UIButton *)sender;
- (IBAction)previousButtonIncomeList:(UIButton *)sender;

//Grahp Income Subtitles
@property (weak, nonatomic) IBOutlet UILabel *graphSubtitleOne;
@property (weak, nonatomic) IBOutlet UILabel *graphSubtitleTwo;
@property (weak, nonatomic) IBOutlet UILabel *graphSubtitleThree;
@property (weak, nonatomic) IBOutlet UILabel *graphSubtitleFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphSubtitleOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphSubtitleTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphSubtitleThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphSubtitleFour;
@property (weak, nonatomic) IBOutlet UILabel *graphTotalIncome;
//*****************************************************************************************************

//Expenses Properties
//*****************************************************************************************************
//SubView Buttons
- (IBAction)dateExpenseButton:(UIButton *)sender;
- (IBAction)accountExpenseButton:(UIButton *)sender;
- (IBAction)categoryExpenseButton:(UIButton *)sender;

//SubViews
@property (strong, nonatomic) IBOutlet UIView *expenseListView;
@property (strong, nonatomic) IBOutlet PieChartViewController *expensePieChartView;
@property (strong, nonatomic) IBOutlet UIView *expenseCategoryView;

//Table Views
@property (strong, nonatomic) IBOutlet UITableView *expenseTableView; //TAG = 3
@property (strong, nonatomic) IBOutlet UITableView *categoryExpenseTableView; //TAG = 4

//List Expense Screen
- (IBAction)nextButtonExpenseList:(UIButton *)sender;
- (IBAction)previousButtonExpenseList:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *monthLabelExpenseList;
@property (weak, nonatomic) IBOutlet UILabel *emptyExpenseListLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButtonExpenseListProperties;
@property (weak, nonatomic) IBOutlet UIButton *previousButtonExpenseListProperties;

//Account Expense Graph Screen
- (IBAction)nextButtonAccountExpense:(UIButton *)sender;
- (IBAction)previousButtonAccountExpense:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *monthLabelAccountExpense;
@property (weak, nonatomic) IBOutlet UILabel *emptyGraphAccountExpense;

//Category Expense Screen
- (IBAction)nextButtonExpenseCategory:(UIButton *)sender;
- (IBAction)previousButtonExpenseCategory:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *monthLabelExpenseCategory;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabelExpenseCategory;
@property (weak, nonatomic) IBOutlet UILabel *totalLabelExpenseCategory;

//Graph Excome Subtitles
@property (weak, nonatomic) IBOutlet UILabel *graphExpenseSubTitleOne;
@property (weak, nonatomic) IBOutlet UILabel *graphExpenseSubTitleTwo;
@property (weak, nonatomic) IBOutlet UILabel *graphExpenseSubTitleThree;
@property (weak, nonatomic) IBOutlet UILabel *graphExpenseSubTitleFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphExpenseSubTileOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphExpenseSubTileTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphExpenseSubTileThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphExpenseSubTileFour;
@property (weak, nonatomic) IBOutlet UILabel *graphTotalExpenses;

//*****************************************************************************************************

//All (Income/Expenses Screen) Properties
//*****************************************************************************************************
@property (weak, nonatomic) IBOutlet UILabel *monthLabelAll;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabelAll;
@property (weak, nonatomic) IBOutlet UILabel *totalLabelAll;

@property (weak, nonatomic) IBOutlet UILabel *graphAllSubTitleOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphAllSubTitleOne;
@property (weak, nonatomic) IBOutlet UILabel *graphAllSubTitleTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageGraphAllSubTitleTwo;

@property (strong, nonatomic) IBOutlet PieChartViewController *pieChartViewAll;

- (IBAction)previousButtonAll:(UIButton *)sender;
- (IBAction)nextButtonAll:(UIButton *)sender;
- (IBAction)buttonSendPDF:(UIButton *)sender;

//*****************************************************************************************************

//Instance Methods
- (void) setSubViewScreen:(int)sender;
- (void) additionalViewDidLoad;
- (void) returnMainView;
- (void) createIncomeDictionary;
- (void) createIncomeAccountGraph;
- (void) createIncomeCategoryTableView;
- (void) createExpenseDictionary;
- (void) createExpenseAccountGraph;
- (void) createExpenseCategoryTableView;
- (void) createIncExpGraph;
- (void) monthToShow:(int)month ofYear:(int)year withOperation:(int)operation forView:(int)sender;
- (NSString *) defineMonth:(int)month completeDescription:(int)complete;
- (int) returnMonth:(NSString *)month;
- (void) initializeAllData;
- (void) generatePDF;
- (void) hideSubtitles:(int)sender;

@end
