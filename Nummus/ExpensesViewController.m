//
//  ExpensesViewController.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpensesViewController.h"

const int _CATEGORYEXP = 1;
const int _AMOUNTEXP = 2;
const int _DATEEXP = 3;
const int _ACCOUNTEXP = 4;

@implementation ExpensesViewController
{
    CGPoint categoryButtonCenter;
    CGPoint amountButtonCenter;
    CGPoint dateButtonCenter;
    CGPoint accountButtonCenter;
    
    //Timer count to close the window
    NSTimer *timerCloseScreen;
    
    AVAudioPlayer *player;
    
    //Holds the list of accounts - data from database (table acc000)
    NSMutableArray *arrayAccounts;
    
    //Holds the list of categories - data from database (table ctg000)
    NSMutableArray *arrayCategories;
}

//Date
@synthesize datePicker = _datePicker;
@synthesize dateLabelField = _dateLabelField;

//TextFields
@synthesize amountTextField = _amountTextField;
@synthesize doneAmountButtonProperties = _doneAmountButtonProperties;

//Category 
@synthesize categoryTableView = _categoryTableView;
@synthesize addCategoryButton = _addCategoryButton;
@synthesize checkedRollCategoryTableView = _checkedRollCategoryTableView;

//Account
@synthesize accountTableView = _accountTableView;
@synthesize checkedRollAccountTableView = _checkedRollAccountTableView;

//Swipe Left
@synthesize swipeLeftProperties = _swipeLeftProperties;

//Swipe Rigth
@synthesize swipeRigthDoneProperties = _swipeRigthDoneProperties;

//Buttons
@synthesize categoryButton = _categoryButton;
@synthesize amountButton = _amountButton;
@synthesize dateButton = _dateButton;
@synthesize accountButton = _accountButton;

#pragma mark - view methods
//View Methods
/*************************************************************************************************/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Method with additional setup for when the view is load
    [self additionalViewDidLoad];
}

- (void)viewDidUnload
{
    //Clean the arrays and other objects with data
    appDelegate = nil;
    arrayCategories = nil;
    arrayAccounts = nil;
    player = nil;
    timerCloseScreen = nil;
    
    [self setCategoryButton:nil];
    [self setAmountButton:nil];
    [self setDateButton:nil];
    [self setAccountButton:nil];
    [self setSwipeLeftProperties:nil];
    [self setCategoryTableView:nil];
    [self setAddCategoryButton:nil];
    [self setAddCategoryButton:nil];
    [self setAccountTableView:nil];
    [self setAmountTextField:nil];
    [self setDatePicker:nil];
    [self setDateLabelField:nil];
    [self setSwipeRigthDoneProperties:nil];
    [self setDoneAmountButtonProperties:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    //Dismiss the keyboard
    [self dismissKeyboard];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Reloads the array and the tableview that holds the categories
    //filter = 1 - Expenses
    arrayCategories = [CategoryData getCategoriesToDisplay:[appDelegate getDBPath] filterBy:1];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"ctg000Name" ascending:YES selector:@selector(localizedCompare:)];
    [arrayCategories sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    [_categoryTableView reloadData];
    
    //Unmark all the previous marked row
    if (self.checkedRollCategoryTableView)
    {
        UITableViewCell *uncheckCell = [_categoryTableView cellForRowAtIndexPath:self.checkedRollCategoryTableView];    
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        
        self.checkedRollCategoryTableView = nil;
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if(buttonIndex == [alertView cancelButtonIndex])
        {
            [self returnMainView];
        }
    }   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _doneAmountButtonProperties.hidden = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _doneAmountButtonProperties.hidden = YES;    
}

//Delegate method that don`t allow the user to type more than one 'dot' in the amount textfield
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //amoun textfield tag = 1
    if (textField.tag == 1)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSArray *arrayOfString = [newString componentsSeparatedByString:@"."];
        
        if ([arrayOfString count] > 2)
        {
            return NO;
        }
    }
    
    return YES;
}

/*************************************************************************************************/

#pragma mark - TableView Delegate
//TableView methods
/*************************************************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //1 = Category TableView
    //0 or Others - Accounts TableView
    
    if (tableView.tag == 1) 
    {
        return arrayCategories.count;
    }
    else
    {
        return arrayAccounts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 = Category TableView
    //0 or Others - Accounts TableView
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;
    
    if (tableView.tag == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        //Get the objects from the array
        CategoryData *categoryObj = [arrayCategories objectAtIndex:indexPath.row];
        
        cell.textLabel.text = categoryObj.ctg000Name;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        //Get the objects from the array
        AccountData *accountObj = [arrayAccounts objectAtIndex:indexPath.row];
        
        cell.textLabel.text = accountObj.acc000Name;  
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 = Category TableView
    //0 or Others - Accounts TableView
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = nil;
    
    if (tableView.tag == 1) 
    {
        cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (self.checkedRollCategoryTableView)
        {
            UITableViewCell *uncheckCell = [tableView cellForRowAtIndexPath:self.checkedRollCategoryTableView];    
            uncheckCell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            self.checkedRollCategoryTableView = indexPath;
        }
        else
        {
            self.checkedRollCategoryTableView = indexPath;
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } 
    }
    else
    {
        cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (self.checkedRollAccountTableView)
        {
            UITableViewCell *uncheckCell = [tableView cellForRowAtIndexPath:self.checkedRollAccountTableView];    
            uncheckCell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            self.checkedRollAccountTableView = indexPath;
        }
        else
        {
            self.checkedRollAccountTableView = indexPath;
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}
/*************************************************************************************************/

#pragma mark - my methods
/*************************************************************************************************/
//My Methods
- (void) returnMainView
{
    [self dismissModalViewControllerAnimated:YES];
    [self viewDidUnload];
}

//Define which view is showing
- (void) setSubViewScreen:(int)sender
{
    for (UIView *subView in [self.view subviews])
    {
        if (subView.tag >= 1 && subView.tag <=4)
        {
            if (subView.tag == sender)
            {
                [subView setHidden:NO];
            }  
            else 
            {
                [subView setHidden:YES];
            }
        }
    }
}

//Dismiss the keyboard for all textfields
-(void)dismissKeyboard
{
    [_amountTextField resignFirstResponder];
}

//Dismiss the keyboard
- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void) additionalViewDidLoad
{
    appDelegate = (NummusMainViewControllerAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //Loads from database both categories and accounts lists
    arrayCategories = [CategoryData getCategoriesToDisplay:appDelegate.getDBPath filterBy:1];
    arrayAccounts = [AccountData getAccountsToDisplay:appDelegate.getDBPath];
    
    //Close the database - Use the categorydata object because its more complete
    [CategoryData finalizeStatements];
    
    categoryButtonCenter = _categoryButton.center;
    amountButtonCenter = _amountButton.center;
    dateButtonCenter = _dateButton.center;
    accountButtonCenter = _accountButton.center;
    
    [self setSubViewScreen:_CATEGORYEXP];
    
    //Set up the category tableview
    UILabel *_titleBarCategoryTableView = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 320, 25)];
    _titleBarCategoryTableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _titleBarCategoryTableView.textAlignment = UITextAlignmentCenter;
    _titleBarCategoryTableView.text = @"Categories";
    _titleBarCategoryTableView.backgroundColor = [UIColor colorWithRed:0.6484 green:0.1974 blue:0.2516 alpha:1.0];
    _titleBarCategoryTableView.textColor = [UIColor whiteColor];
    
    _categoryTableView.tableHeaderView = _titleBarCategoryTableView;
    _categoryTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    //Make the corners of the category tableview round
    [self.categoryTableView.layer setCornerRadius:8.0];
    
    //Set up the account tableview
    UILabel *_titleBarAccountTableView = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 320, 25)];
    _titleBarAccountTableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _titleBarAccountTableView.textAlignment = UITextAlignmentCenter;
    _titleBarAccountTableView.text = @"Accounts";
    _titleBarAccountTableView.backgroundColor = [UIColor colorWithRed:0.6484 green:0.1974 blue:0.2516 alpha:1.0];
    _titleBarAccountTableView.textColor = [UIColor whiteColor];
    
    _accountTableView.tableHeaderView = _titleBarAccountTableView;
    _accountTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    //Make the corners of the category tableview round
    [self.accountTableView.layer setCornerRadius:8.0];
    
    //Define the keyboard for the value textfield
    _amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    //Set the delegate to not let the user type more than one 'dot' in this field
    _amountTextField.delegate = self;
    
    //Select the date
    [self dateSelected:_datePicker];
    
    //Prepare to play the sound when user creates a new expense
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cashreg" ofType:@"mp3"]] error:nil];
    player.delegate = self;
    
}

- (IBAction)categoryButtonPressed:(UIButton *)sender 
{
    [self dismissKeyboard];
    [self setSubViewScreen:_CATEGORYEXP];
    [_categoryTableView reloadData];
}

- (IBAction)amountButtonPressed:(UIButton *)sender 
{
    [self setSubViewScreen:_AMOUNTEXP];
    [_amountTextField becomeFirstResponder];
}

- (IBAction)dateButtonPressed:(UIButton *)sender 
{ 
    [self dismissKeyboard];
    [self setSubViewScreen:_DATEEXP];
}

- (IBAction)accountButtonPressed:(UIButton *)sender 
{
    [self dismissKeyboard];
    [self setSubViewScreen:_ACCOUNTEXP];
}

- (IBAction)addCategoryButtonPressed:(UIButton *)sender 
{
    [self performSegueWithIdentifier:@"addCategoryScreen" sender:self];
}

- (IBAction)doneAmountButton:(UIButton *)sender 
{
    [self dismissKeyboard];
    _doneAmountButtonProperties.hidden = YES;
}

- (IBAction)swipeLeftCancel:(UISwipeGestureRecognizer *)sender 
{
    UIAlertView *alertCancel = [[UIAlertView alloc] initWithTitle:@"Cancel add expenses" message:@"Confirm cancel?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alertCancel.tag = 1;
    [alertCancel show];
}

- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender 
{
    BOOL _isValidate = [self validateNewExpense];
    
    if (_isValidate == TRUE)
    {
        BOOL _isSaved = [self saveNewExpense];
        
        if (_isSaved == YES)
        {
            [self finalizeScreen];   
        }
    }   
}

- (IBAction)dateSelected:(UIDatePicker *)sender 
{
    NSDate *dateChose = [_datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *dateString = [dateFormatter stringFromDate:dateChose];
    _dateLabelField.text = dateString;
}

//Ckecks to see if there is any empty field or if there is a identique item in database before saving
- (BOOL) validateNewExpense
{
    appDelegate = (NummusMainViewControllerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *messageTitle;
    NSString *message;
    int _screen = 0;
    
    BOOL _validated = YES;
    
    if (!self.checkedRollCategoryTableView)
    {
        _validated = NO;
        messageTitle = @"Ops!";
        message = @"Please, select the category";
        _screen = 1;
    }
    
    if (!self.checkedRollAccountTableView)
    {
        _validated = NO;
        messageTitle = @"Ops!";
        message = @"Please, select the account";
        _screen = 4;
    }
    
    if (_amountTextField.text.length == 0)
    {
        _validated = NO;
        messageTitle = @"Ops!";
        message = @"Please, provide the amount";
        _screen = 2;
    }
    
    if (_validated == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageTitle message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
        
        switch (_screen)
        {
            case 1:
                [self dismissKeyboard];
                [self setSubViewScreen:_CATEGORYEXP];
                [_categoryTableView reloadData];
                break;
                
            case 2:
                [self setSubViewScreen:_AMOUNTEXP];
                [_amountTextField becomeFirstResponder];
                break;
                
            case 4:
                [self dismissKeyboard];    
                [self setSubViewScreen:_ACCOUNTEXP];
                break;
                
            default:
                break;
        }
    }
    
    return _validated;
}

//Save the new expense
- (BOOL) saveNewExpense
{
    BOOL _incExpAdded = NO;
    
    appDelegate = (NummusMainViewControllerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //Get the date from the date picker
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc]init];
    [_dateFormatter setDateFormat:@"MM/dd/YYYY"];
    NSString *_dateString = [NSString stringWithFormat:@"%@", [_dateFormatter stringFromDate:self.datePicker.date]];
    
    
    //Create a category object
    //Initiates with the primary key = 0 because it will not be used    
    IncomeExpensesData *incExpObj = [[IncomeExpensesData alloc] initWithPrimaryKey:0];
    
    incExpObj.incExpCategory = [[[_categoryTableView cellForRowAtIndexPath:self.checkedRollCategoryTableView]textLabel]text];
    incExpObj.incExpAmount = [NSNumber numberWithDouble:[_amountTextField.text doubleValue]];
    incExpObj.incExpDate = _dateString;
    incExpObj.incExpAccount = [[[_accountTableView cellForRowAtIndexPath:self.checkedRollAccountTableView]textLabel]text];
    incExpObj.incExpIsIncome = [NSNumber numberWithInt:1];
    
    //Pass the object to the app delegate so it can handle it and add to the database
    _incExpAdded =  [incExpObj addIncomeExpense:[appDelegate getDBPath]];
    
    return _incExpAdded;
}

//Shows the screen success to the user in case everything went well
- (void) finalizeScreen
{
    for (UIView *subView in [self.view subviews])
    {
        if (subView.tag == 9)
        {
            [subView setHidden:NO];
        }
        else 
        {
            if (subView.tag >= 1 && subView.tag <=4)
            {
                [subView setHidden:YES];
            }
        }
    }
    
    //Check to see if should play sound
    NSInteger _isOn = [PreferencesData getPreferences:[appDelegate getDBPath] withFilter:0];
    
    if (_isOn == 0)
    {
        //Play sound
        [player play];
    }
    
    //Show the success screen
    timerCloseScreen = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(returnMainView) userInfo:nil repeats:YES];
}

@end
