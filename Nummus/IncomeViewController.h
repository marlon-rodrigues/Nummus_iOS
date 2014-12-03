//
//  IncomeViewController.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "NummusMainViewControllerAppDelegate.h"
#import "CategoryData.h"
#import "AccountData.h"
#import "PreferencesData.h"

//Set the class to be delegate of textfields, tableviews and audio player
@interface IncomeViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate>
{
    NummusMainViewControllerAppDelegate *appDelegate;
}

//Main Buttons
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *amountButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;

- (IBAction)categoryButtonPressed:(UIButton *)sender;
- (IBAction)amountButtonPressed:(UIButton *)sender;
- (IBAction)dateButtonPressed:(UIButton *)sender;
- (IBAction)accountButtonPressed:(UIButton *)sender;

//Swipe Left
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftProperties;
- (IBAction)swipeLeftCancel:(UISwipeGestureRecognizer *)sender;

//Swipe Rigth
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRigthDoneProperties;
- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender;

//TableViews
//Categories tableview
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UIButton *addCategoryButton;
@property (retain, nonatomic) NSIndexPath* checkedRollCategoryTableView; //holds the value that determines if a row is checked or not
- (IBAction)addCategoryButtonPressed:(UIButton *)sender;

//Accounts tablevie
@property (strong, nonatomic) IBOutlet UITableView *accountTableView;
@property (retain, nonatomic) NSIndexPath* checkedRollAccountTableView; //holds the value that determines if a row is checked or not

//TextFields
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneAmountButtonProperties;
- (IBAction)doneAmountButton:(UIButton *)sender;

//Date
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabelField;
- (IBAction)dateSelected:(UIDatePicker *)sender;

//Instance methods
- (IBAction)textFieldReturn:(id)sender;
- (void) returnMainView;
- (void) setSubViewScreen:(int)sender;
- (void) dismissKeyboard;
- (void) additionalViewDidLoad;
- (BOOL) saveNewIncome;
- (BOOL) validateNewIncome;
- (void) finalizeScreen;

@end
