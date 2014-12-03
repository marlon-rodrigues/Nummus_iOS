//
//  ReportViewController.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"

#define kDefaultPageHeight 792
#define kDefaultPageWidth  612
#define kMargin 50
#define kColumnMargin 10

@implementation ReportViewController
{
    NSNumberFormatter *currencyFormatter;
    
    NSDate *currentDate;
    
    //Holds the list of income categories
    NSMutableArray *arrayIncomeCategorySum;
    //Holds the list of incomes
    NSMutableArray *arrayIncomeList;
    
    //Holds the list of expense categories
    NSMutableArray *arrayExpenseCategorySum;
    //Holds the list of expenses
    NSMutableArray *arrayExpenseList;
    
    //Temporary path where the pdf file is saved
    NSString *pdfFilePath;
}

//Edit Tables Properties
@synthesize doneEditingExpenseButtonProperties = _doneEditingExpenseButtonProperties;
@synthesize previousButtonIncomeListProperties = _previousButtonIncomeListProperties;
@synthesize nextButtonIncomeListProperties = _nextButtonIncomeListProperties;
@synthesize doneEditingButtonProperties = _doneEditingButtonProperties;

@synthesize tableBeingEdit = _tableBeingEdit;

//All (Income/Expense Screen) Properties
//****************************************************************************
@synthesize monthLabelAll = _monthLabelAll;
@synthesize emptyLabelAll = _emptyLabelAll;
@synthesize totalLabelAll = _totalLabelAll;

@synthesize graphAllSubTitleOne = _graphAllSubTitleOne;
@synthesize imageGraphAllSubTitleOne = _imageGraphAllSubTitleOne;
@synthesize graphAllSubTitleTwo = _graphAllSubTitleTwo;
@synthesize imageGraphAllSubTitleTwo = _imageGraphAllSubTitleTwo;

@synthesize pieChartViewAll = _pieChartViewAll;

@synthesize screenTitle = _screenTitle;
//****************************************************************************

//Expense Properties
//****************************************************************************
//Table Views
@synthesize expenseTableView = _expenseTableView;
@synthesize categoryExpenseTableView = _categoryExpenseTableView;

//Graph Expense Subtitle
@synthesize graphExpenseSubTitleOne = _graphExpenseSubTitleOne;
@synthesize graphExpenseSubTitleTwo = _graphExpenseSubTitleTwo;
@synthesize graphExpenseSubTitleThree = _graphExpenseSubTitleThree;
@synthesize graphExpenseSubTitleFour = _graphExpenseSubTitleFour;
@synthesize imageGraphExpenseSubTileOne = _imageGraphExpenseSubTileOne;
@synthesize imageGraphExpenseSubTileTwo = _imageGraphExpenseSubTileTwo;
@synthesize imageGraphExpenseSubTileThree = _imageGraphExpenseSubTileThree;
@synthesize imageGraphExpenseSubTileFour = _imageGraphExpenseSubTileFour;
@synthesize graphTotalExpenses = _graphTotalExpenses;

//Expense Category Labels
@synthesize monthLabelExpenseCategory = _monthLabelExpenseCategory;
@synthesize emptyLabelExpenseCategory = _emptyLabelExpenseCategory;
@synthesize totalLabelExpenseCategory = _totalLabelExpenseCategory;

//Expense Account Labels
@synthesize monthLabelAccountExpense = _monthLabelAccountExpense;
@synthesize emptyGraphAccountExpense = _emptyGraphAccountExpense;

//SubViews
@synthesize expenseListView = _expenseListView;
@synthesize expensePieChartView = _expensePieChartView;
@synthesize expenseCategoryView = _expenseCategoryView;

//Expense List Labels
@synthesize monthLabelExpenseList = _monthLabelExpenseList;
@synthesize emptyExpenseListLabel = _emptyExpenseListLabel;
@synthesize nextButtonExpenseListProperties = _nextButtonExpenseListProperties;
@synthesize previousButtonExpenseListProperties = _previousButtonExpenseListProperties;

//****************************************************************************

//Income Properties
//****************************************************************************
//Income List Labels
@synthesize monthLabelIncomeList = _monthLabelIncomeList;
@synthesize emptyIncomeListLabel = _emptyIncomeListLabel;

//Income Category Labels
@synthesize monthLabelIncomeCategoryGraph = _monthLabelIncomeCategoryGraph;
@synthesize emptyIncomeCategoryLabel = _emptyIncomeCategoryLabel;
@synthesize totalIncomeCategoryLabel = _totalIncomeCategoryLabel;

//Graph Income subtitle
@synthesize graphSubtitleOne = _graphSubtitleOne;
@synthesize graphSubtitleTwo = _graphSubtitleTwo;
@synthesize graphSubtitleThree = _graphSubtitleThree;
@synthesize graphSubtitleFour = _graphSubtitleFour;
@synthesize imageGraphSubtitleOne = _imageGraphSubtitleOne;
@synthesize imageGraphSubtitleTwo = _imageGraphSubtitleTwo;
@synthesize imageGraphSubtitleThree = _imageGraphSubtitleThree;
@synthesize imageGraphSubtitleFour = _imageGraphSubtitleFour;
@synthesize graphTotalIncome = _graphTotalIncome;

//Income Account Labels
@synthesize monthLabelAccountGraph = _monthLabelAccountGraph;
@synthesize emptyGraphLabel = _emptyGraphLabel;

//TableViews
@synthesize incomeTableView = _incomeTableView;
@synthesize incomeCategoriesTableView = _incomeCategoriesTableView;

//SubViews
@synthesize incomePieChartView = _incomePieChartView;
@synthesize incomeCategoryView = _incomeCategoryView;
@synthesize incomeListView = _incomeListView;
//****************************************************************************

#pragma mark - view methods
//View methods
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
    
    //Executes additional methods when the view is load
    [self additionalViewDidLoad];
}

- (void)viewDidUnload
{
    //Clear all objects that need to be clear
    appDelegate = nil;
    arrayIncomeList = nil;
    arrayIncomeCategorySum = nil;
    arrayExpenseList = nil;
    arrayExpenseCategorySum = nil;
    
    [self setIncomeTableView:nil];
    [self setIncomePieChartView:nil];
    [self setMonthLabelAccountGraph:nil];
    [self setGraphSubtitleOne:nil];
    [self setGraphSubtitleTwo:nil];
    [self setGraphSubtitleThree:nil];
    [self setGraphSubtitleFour:nil];
    [self setImageGraphSubtitleOne:nil];
    [self setImageGraphSubtitleTwo:nil];
    [self setImageGraphSubtitleThree:nil];
    [self setImageGraphSubtitleFour:nil];
    [self setEmptyGraphLabel:nil];
    [self setGraphTotalIncome:nil];
    [self setIncomeCategoriesTableView:nil];
    [self setMonthLabelIncomeCategoryGraph:nil];
    [self setEmptyIncomeCategoryLabel:nil];
    [self setTotalIncomeCategoryLabel:nil];
    [self setIncomeCategoryView:nil];
    [self setIncomeListView:nil];
    [self setMonthLabelIncomeList:nil];
    [self setEmptyIncomeListLabel:nil];
    [self setExpenseTableView:nil];
    [self setMonthLabelExpenseList:nil];
    [self setEmptyExpenseListLabel:nil];
    [self setExpenseListView:nil];
    [self setExpensePieChartView:nil];
    [self setExpenseCategoryView:nil];
    [self setMonthLabelAccountExpense:nil];
    [self setEmptyGraphAccountExpense:nil];
    [self setCategoryExpenseTableView:nil];
    [self setMonthLabelExpenseCategory:nil];
    [self setTotalLabelExpenseCategory:nil];
    [self setEmptyLabelExpenseCategory:nil];
    [self setGraphExpenseSubTitleOne:nil];
    [self setGraphExpenseSubTitleTwo:nil];
    [self setGraphExpenseSubTitleThree:nil];
    [self setGraphExpenseSubTitleFour:nil];
    [self setImageGraphExpenseSubTileOne:nil];
    [self setImageGraphExpenseSubTileTwo:nil];
    [self setImageGraphExpenseSubTileThree:nil];
    [self setImageGraphExpenseSubTileFour:nil];
    [self setGraphTotalExpenses:nil];
    [self setScreenTitle:nil];
    [self setMonthLabelAll:nil];
    [self setEmptyLabelAll:nil];
    [self setTotalLabelAll:nil];
    [self setGraphAllSubTitleOne:nil];
    [self setImageGraphAllSubTitleOne:nil];
    [self setGraphAllSubTitleTwo:nil];
    [self setImageGraphAllSubTitleTwo:nil];
    [self setPieChartViewAll:nil];
    [self setDoneEditingButtonProperties:nil];
    [self setPreviousButtonIncomeListProperties:nil];
    [self setNextButtonIncomeListProperties:nil];
    [self setDoneEditingExpenseButtonProperties:nil];
    [self setNextButtonExpenseListProperties:nil];
    [self setPreviousButtonExpenseListProperties:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/*************************************************************************************************/

#pragma mark - TableView Delegate
//TableView methods
/*************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //1 = Income TableView
    //2 = Income Categories TableView
    //3 = Expense TableView
    //4 = Expense Category TableView

    switch (tableView.tag)
    {
        case 1:
            return arrayIncomeList.count;
            break;
            
        case 2:
            return arrayIncomeCategorySum.count;
            break;
            
        case 3:
            return arrayExpenseList.count;
            break;
            
        case 4:
            return arrayExpenseCategorySum.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 = Income TableView
    //2 = Income Categories TableView
    //3 = Expense TableView
    //4 = Expense Category TableView
    
    static NSString *cellIdentifier = @"Cell";
    
    CustomControllerCell *cell = nil;
    
    if (tableView.tag == 1) 
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         
        if (cell == nil)
        {
            //cell = [[CustomControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell = [[CustomControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier numberOfItens:1];
        }
        
        IncomeExpensesData *incExpObj = [arrayIncomeList objectAtIndex:indexPath.row];
        
        cell.categoryLabel.text = incExpObj.incExpCategory;
        cell.dateLabel.text = incExpObj.incExpDate;
        cell.amountLabel.text = [currencyFormatter stringFromNumber:incExpObj.incExpAmount];
        cell.accountLabel.text = incExpObj.incExpAccount;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (tableView.tag == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[CustomControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier numberOfItens:2];
        }
        
        CategoryData *ctgObj = [arrayIncomeCategorySum objectAtIndex:indexPath.row];

        cell.categoryLabel.text = ctgObj.ctg000Name;
        cell.amountLabel.text = [currencyFormatter stringFromNumber:ctgObj.ctgSumAmount];
    }
    else if (tableView.tag == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[CustomControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier numberOfItens:1];
        }
        
        IncomeExpensesData *incExpObj = [arrayExpenseList objectAtIndex:indexPath.row];
        
        cell.categoryLabel.text = incExpObj.incExpCategory;
        cell.dateLabel.text = incExpObj.incExpDate;
        cell.amountLabel.text = [currencyFormatter stringFromNumber:incExpObj.incExpAmount];
        cell.accountLabel.text = incExpObj.incExpAccount;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (tableView.tag == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[CustomControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier numberOfItens:2];
        }
        
        CategoryData *ctgObj = [arrayExpenseCategorySum objectAtIndex:indexPath.row];
        
        cell.categoryLabel.text = ctgObj.ctg000Name;
        cell.amountLabel.text = [currencyFormatter stringFromNumber:ctgObj.ctgSumAmount];  
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 = Income TableView
    //2 = Income Categories TableView
    //3 = Expense TableView
    //4 = Expense Category TableView
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView.tag == 1)
    {
        self.doneEditingButtonProperties.hidden = NO;
        [tableView setEditing:YES]; 
        self.tableBeingEdit = tableView;
        
        self.monthLabelIncomeList.hidden = YES;
        self.previousButtonIncomeListProperties.hidden = YES;
        self.nextButtonIncomeListProperties.hidden = YES;
    }
    else if(tableView.tag == 3)
    {
        self.doneEditingExpenseButtonProperties.hidden = NO;
        [tableView setEditing:YES];
        self.tableBeingEdit = tableView;
        
        self.monthLabelExpenseList.hidden = YES;
        self.previousButtonExpenseListProperties.hidden = YES;
        self.nextButtonExpenseListProperties.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 = Income TableView
    //2 = Income Categories TableView
    //3 = Expense TableView
    //4 = Expense Category TableView
    
    BOOL _deleted = NO;
    IncomeExpensesData *incExpObj;
    
    if (tableView.tag == 1)
    {
        incExpObj = [arrayIncomeList objectAtIndex:indexPath.row];
        
        _deleted = [incExpObj deleteIncomeExpense:[appDelegate getDBPath] withID:incExpObj.incExpID];
        
        if (_deleted)
        {
            [tableView reloadData];
            [self hideSubtitles:1];
            [self hideSubtitles:3];
            [self initializeAllData];
        }
    }
    else if (tableView.tag == 3)
    {
        incExpObj = [arrayExpenseList objectAtIndex:indexPath.row];
        
        _deleted = [incExpObj deleteIncomeExpense:[appDelegate getDBPath] withID:incExpObj.incExpID];
        
        if (_deleted)
        {
            [tableView reloadData];
            [self hideSubtitles:2];
            [self hideSubtitles:3];
            [self initializeAllData];
        } 
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Implemented to prevent that when the user swipes left to go back to previous screen the delete button appears
    
    if (self.doneEditingButtonProperties.isHidden == NO || self.doneEditingExpenseButtonProperties.hidden == NO)
    {
        return YES;
    }
    else 
    {
        return NO;
    }
}

/*************************************************************************************************/

#pragma mark - my methods
//My Methods
/*************************************************************************************************/
- (IBAction)swipeLeftCancel:(UISwipeGestureRecognizer *)sender 
{
    [self returnMainView];
}

- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender
{
    [self returnMainView];
}

- (IBAction)incomeButton:(UIButton *)sender 
{
    [self setSubViewScreen:1];
    self.screenTitle.text = @"income report";
}

- (IBAction)expensesButton:(UIButton *)sender 
{
    [self setSubViewScreen:2];
    self.screenTitle.text = @"expenses report";
}

- (IBAction)reportButton:(UIButton *)sender 
{
    [self setSubViewScreen:3];
    self.screenTitle.text = @"income/expenses report";
}

- (void) returnMainView
{
    [self dismissModalViewControllerAnimated:YES];
    [self viewDidUnload];
}

- (void) additionalViewDidLoad
{
    appDelegate = (NummusMainViewControllerAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //Set the currency style
    currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormatter setMaximumFractionDigits:2];
    [currencyFormatter setLocale:[NSLocale currentLocale]];
    
    //Set the income list table view
    UILabel *_titleBarIncomeTableView = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 320, 25)];
    _titleBarIncomeTableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _titleBarIncomeTableView.textAlignment = UITextAlignmentCenter;
    _titleBarIncomeTableView.text = @"List Income";
    _titleBarIncomeTableView.backgroundColor = [UIColor colorWithRed:0.7761 green:0.8625 blue:0.7636 alpha:1.0];
    _titleBarIncomeTableView.textColor = [UIColor whiteColor];
    
    _incomeTableView.tableHeaderView = _titleBarIncomeTableView;
    _incomeTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    //Make the corners of the category tableview round
    [self.incomeTableView.layer setCornerRadius:8.0];
    
    //Set the income category table view
    UILabel *_titleBarIncomeCategoryTableView = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 320, 25)];
    _titleBarIncomeCategoryTableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _titleBarIncomeCategoryTableView.textAlignment = UITextAlignmentCenter;
    _titleBarIncomeCategoryTableView.text = @"SubTotal by Categories";
    _titleBarIncomeCategoryTableView.backgroundColor = [UIColor colorWithRed:0.7761 green:0.8625 blue:0.7636 alpha:1.0];
    _titleBarIncomeCategoryTableView.textColor = [UIColor whiteColor];
    
    _incomeCategoriesTableView.tableHeaderView = _titleBarIncomeCategoryTableView;
    _incomeCategoriesTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    //Make the corners of the category tableview round
    [self.incomeCategoriesTableView.layer setCornerRadius:8.0];
    
    //Set the expense list table view
    UILabel *_titleBarExpenseTableView = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 320, 25)];
    _titleBarExpenseTableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _titleBarExpenseTableView.textAlignment = UITextAlignmentCenter;
    _titleBarExpenseTableView.text = @"List Expenses";
    _titleBarExpenseTableView.backgroundColor = [UIColor colorWithRed:0.6484 green:0.1974 blue:0.2516 alpha:1.0];
    _titleBarExpenseTableView.textColor = [UIColor whiteColor];
    
    _expenseTableView.tableHeaderView = _titleBarExpenseTableView;
    _expenseTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    //Make the corners of the category tableview round
    [self.expenseTableView.layer setCornerRadius:8.0];
    
    //Set the expense category table view
    UILabel *_titleBarExpenseCategoryTableView = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 320, 25)];
    _titleBarExpenseCategoryTableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _titleBarExpenseCategoryTableView.textAlignment = UITextAlignmentCenter;
    _titleBarExpenseCategoryTableView.text = @"SubTotal by Categories";
    _titleBarExpenseCategoryTableView.backgroundColor = [UIColor colorWithRed:0.6484 green:0.1974 blue:0.2516 alpha:1.0];
    _titleBarExpenseCategoryTableView.textColor = [UIColor whiteColor];
    
    _categoryExpenseTableView.tableHeaderView = _titleBarExpenseCategoryTableView;
    _categoryExpenseTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    //Make the corners of the category tableview round
    [self.categoryExpenseTableView.layer setCornerRadius:8.0];
        
    [self initializeAllData];
    
    [self setSubViewScreen:1];
}

- (void) initializeAllData
{
    //Initialize the date
    NSDate *sourceDate = [NSDate date];
    
    //Get the GMT timezone and the system timezone
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    
    //Calculates the offset to generate a new date to correspond to local system time zone
    NSInteger sourceGMTOffSet = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffSet = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffSet - sourceGMTOffSet;
    
    currentDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    NSString *strDate = [[NSString alloc] initWithFormat:@"%@", currentDate];
    int year = [[strDate substringToIndex:4] intValue];
    int month = [[[strDate substringFromIndex:5] substringToIndex:4] intValue]; //Take a look at this later
    
    //Show month income list
    [self monthToShow:month ofYear:year withOperation:0 forView:3];
    //Populates the income list
    [self createIncomeDictionary];
    
    //Show month income account graph
    [self monthToShow:month ofYear:year withOperation:0 forView:1];
    //Build the account graph for income 
    [self createIncomeAccountGraph];
    
    //Show month income category table view
    [self monthToShow:month ofYear:year withOperation:0 forView:2];
    //Populates the tableview with the sum of categories - 0 for income
    [self createIncomeCategoryTableView];
    
    //Show month expense list
    [self monthToShow:month ofYear:year withOperation:0 forView:4];
    //Populates the expense list 
    [self createExpenseDictionary];
    
    //Show month income account graph
    [self monthToShow:month ofYear:year withOperation:0 forView:5];
    //Build the account graph for expenses
    [self createExpenseAccountGraph];
    
    //Show month income category table view
    [self monthToShow:month ofYear:year withOperation:0 forView:6];
    //Populates the tableview with the sum of categories
    [self createExpenseCategoryTableView];
    
    //Show month all graph screen
    [self monthToShow:month ofYear:year withOperation:0 forView:7];
    //Populates the tableview with the sum of categories
    [self createIncExpGraph];
}

- (void) setSubViewScreen:(int)sender
{
    for (UIView *subView in [self.view subviews])
    {
        if (subView.tag >= 1 && subView.tag <=3)
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

- (IBAction)dateIncomeButton:(UIButton *)sender 
{
    _incomeListView.hidden = NO;
    _incomePieChartView.hidden = YES;
    _incomeCategoryView.hidden = YES;
    
}

- (IBAction)accountIncomeButton:(UIButton *)sender 
{
    _incomeListView.hidden = YES;
    _incomePieChartView.hidden = NO;
    _incomeCategoryView.hidden = YES;
}

- (IBAction)categoryIncomeButton:(UIButton *)sender 
{
    _incomeListView.hidden = YES;
    _incomePieChartView.hidden = YES;
    _incomeCategoryView.hidden = NO;
}

- (IBAction)dateExpenseButton:(UIButton *)sender 
{ 
    _expenseListView.hidden = NO;
    _expensePieChartView.hidden = YES;
    _expenseCategoryView.hidden = YES;
}

- (IBAction)accountExpenseButton:(UIButton *)sender 
{
    _expenseListView.hidden = YES;
    _expensePieChartView.hidden = NO;
    _expenseCategoryView.hidden = YES;
}

- (IBAction)categoryExpenseButton:(UIButton *)sender 
{
    _expenseListView.hidden = YES;
    _expensePieChartView.hidden = YES;
    _expenseCategoryView.hidden = NO;
}

#pragma mark - income view
//Income
/*************************************************************************************************/
- (void) createIncomeDictionary
{
    //at first this class was used to create a dictionary of income, but for the next version, I changed to just generate a normal list
    //but I kept the name of the class the same
    
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelIncomeList.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
    
    yearShowing = [dateShowing substringFromIndex:6];
    
    arrayIncomeList = [IncomeExpensesData getDataToDisplayInReport:[appDelegate getDBPath] withFilter:0 onMonth:monthShowing onYear:yearShowing];
    
    if (arrayIncomeList.count > 0)
    {
        self.incomeTableView.hidden = NO;
        self.emptyIncomeListLabel.hidden = YES;
    }
    else
    {
        self.incomeTableView.hidden = YES;
        self.emptyIncomeListLabel.hidden = NO;
    }
    
    [_incomeTableView reloadData];
}

- (IBAction)nextButtonIncomeList:(UIButton *)sender 
{
    self.incomeTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelIncomeList.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:3];
    
    //Build the income category table view
    [self createIncomeDictionary];
}

- (IBAction)previousButtonIncomeList:(UIButton *)sender 
{
    self.incomeTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelIncomeList.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:3];
    
    //Build the income category table view
    [self createIncomeDictionary];
}

- (void) createIncomeAccountGraph
{
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelAccountGraph.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
        
    yearShowing = [dateShowing substringFromIndex:6];
    
    NSMutableArray *arraySumAccounts = [IncomeExpensesData getDataToDisplayByAccount:[appDelegate getDBPath] withFilter:0 onMonth:monthShowing onYear:yearShowing];
    
    float tempValue1 = 0;
    float tempValue2 = 0;
    float tempValue3 = 0;
    float tempValue4 = 0;
    
    float total = 0;
    
    NSString *graphLabel;
    
    if (arraySumAccounts.count > 0)
    {
        self.emptyGraphLabel.hidden = YES;
        self.graphTotalIncome.hidden = NO;
    }
    else
    {
        self.emptyGraphLabel.hidden = NO;
        self.graphTotalIncome.hidden = YES;
    }
    
    for (int i=0; i<[arraySumAccounts count]; i++)
    {
        AccountData *accObj = [arraySumAccounts objectAtIndex:i];
        
        switch (i) 
        {
            case 0:
                tempValue1 = [accObj.accSumAmount floatValue];
                self.graphSubtitleOne.hidden = NO;
                self.imageGraphSubtitleOne.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue1];
                self.graphSubtitleOne.text = graphLabel;
                self.imageGraphSubtitleOne.backgroundColor = [UIColor colorWithRed:0.5709 green:0.7744 blue:0.3871 alpha:1.0];
                break;
            case 1:
                tempValue2 = [accObj.accSumAmount floatValue];
                self.graphSubtitleTwo.hidden = NO;
                self.imageGraphSubtitleTwo.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue2];
                self.graphSubtitleTwo.text = graphLabel;
                self.imageGraphSubtitleTwo.backgroundColor = [UIColor colorWithRed:0.8963 green:0.0519 blue:0.1903 alpha:1.0];
                break;    
            case 2:
                tempValue3 = [accObj.accSumAmount floatValue];
                self.graphSubtitleThree.hidden = NO;
                self.imageGraphSubtitleThree.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue3];
                self.graphSubtitleThree.text = graphLabel;
                self.imageGraphSubtitleThree.backgroundColor = [UIColor colorWithRed:0.8639 green:0.4783 blue:0.0 alpha:1.0];
                break;
            case 3:
                tempValue4 = [accObj.accSumAmount floatValue];
                self.graphSubtitleFour.hidden = NO;
                self.imageGraphSubtitleFour.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue4];
                self.graphSubtitleFour.text = graphLabel;
                self.imageGraphSubtitleFour.backgroundColor = [UIColor colorWithRed:0.1567 green:0.3548 blue:1.0 alpha:1.0];
               break;
            default:
                break;
        }
    }
    
    total = tempValue1 + tempValue2 + tempValue3 + tempValue4;
    
    [_incomePieChartView setValuesForGraph:tempValue1 setGraphValue2:tempValue2 setGraphValue3:tempValue3 setGraphValue4:tempValue4 ];
    [_incomePieChartView setNeedsDisplay];
        
    self.graphTotalIncome.text = [NSString stringWithFormat:@"Total Income: $%.2f", total];
}

- (IBAction)nextButtonAccountGraph:(UIButton *)sender 
{
    [self hideSubtitles:1];
    
    NSString *dateShowing = self.monthLabelAccountGraph.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:1];
    
    //Build the account graph for income
    [self createIncomeAccountGraph];
}

- (IBAction)previousButtonAccountGraph:(UIButton *)sender 
{
    [self hideSubtitles:1];
    
    NSString *dateShowing = self.monthLabelAccountGraph.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:1];
    
    //Build the account graph for income
    [self createIncomeAccountGraph];
}

- (void) createIncomeCategoryTableView
{
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelIncomeCategoryGraph.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
    
    yearShowing = [dateShowing substringFromIndex:6];
    
    arrayIncomeCategorySum = [IncomeExpensesData getDataToDisplayByCategory:[appDelegate getDBPath] withFilter:0 onMonth:monthShowing onYear:yearShowing];
    
    float total = 0;
    
    if (arrayIncomeCategorySum.count > 0)
    {
        self.incomeCategoriesTableView.hidden = NO;
        self.emptyIncomeCategoryLabel.hidden = YES;
        self.totalIncomeCategoryLabel.hidden = NO;
    }
    else
    {
        self.incomeCategoriesTableView.hidden = YES;
        self.emptyIncomeCategoryLabel.hidden = NO;
        self.totalIncomeCategoryLabel.hidden = YES;
    }
    
    for (int i=0; i<[arrayIncomeCategorySum count]; i++)            
    {
        CategoryData *ctgObj = [arrayIncomeCategorySum objectAtIndex:i];
        total += [ctgObj.ctgSumAmount floatValue];
    }
    
    self.totalIncomeCategoryLabel.text = [NSString stringWithFormat:@"Total Income: $%.2f", total];
    
    [_incomeCategoriesTableView reloadData];
}

- (IBAction)nextButtonIncomeCategory:(UIButton *)sender 
{
    self.incomeCategoriesTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelIncomeCategoryGraph.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:2];
    
    //Build the income category table view
    [self createIncomeCategoryTableView];
}

- (IBAction)previousButtonIncomeCategory:(UIButton *)sender 
{
    self.incomeCategoriesTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelIncomeCategoryGraph.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:2];
    
    //Build the income category table view
    [self createIncomeCategoryTableView];
}

/*************************************************************************************************/

#pragma mark - expenses view
//Expense
/*************************************************************************************************/
- (void) createExpenseDictionary
{
    //at first this class was used to create a dictionary of expenses, but for the next version, I changed to just generate a normal list
    //but I kept the name of the class the same
    
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelExpenseList.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
    
    yearShowing = [dateShowing substringFromIndex:6];
    
    arrayExpenseList = [IncomeExpensesData getDataToDisplayInReport:[appDelegate getDBPath] withFilter:1 onMonth:monthShowing onYear:yearShowing];
    
    if (arrayExpenseList.count > 0)
    {
        self.expenseTableView.hidden = NO;
        self.emptyExpenseListLabel.hidden = YES;
    }
    else
    {
        self.expenseTableView.hidden = YES;
        self.emptyExpenseListLabel.hidden = NO;
    }
    
    [_expenseTableView reloadData];
}

- (IBAction)nextButtonExpenseList:(UIButton *)sender 
{
    self.expenseTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelExpenseList.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:4];
    
    //Build the expense list table view
    [self createExpenseDictionary];
}

- (IBAction)previousButtonExpenseList:(UIButton *)sender 
{
    self.expenseTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelExpenseList.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:4];
    
    //Build the expense list table view
    [self createExpenseDictionary];
}

- (void) createExpenseAccountGraph
{
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelAccountExpense.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
    
    yearShowing = [dateShowing substringFromIndex:6];
    
    NSMutableArray *arraySumAccounts = [IncomeExpensesData getDataToDisplayByAccount:[appDelegate getDBPath] withFilter:1 onMonth:monthShowing onYear:yearShowing];
    
    float tempValue1 = 0;
    float tempValue2 = 0;
    float tempValue3 = 0;
    float tempValue4 = 0;
    
    float total = 0;
    
    NSString *graphLabel;
    
    if (arraySumAccounts.count > 0)
    {
        self.emptyGraphAccountExpense.hidden = YES;
        self.graphTotalExpenses.hidden = NO;
    }
    else
    {
        self.emptyGraphAccountExpense.hidden = NO;
        self.graphTotalExpenses.hidden = YES;
    }
    
    for (int i=0; i<[arraySumAccounts count]; i++)
    {
        AccountData *accObj = [arraySumAccounts objectAtIndex:i];
        
        switch (i) 
        {
            case 0:
                tempValue1 = [accObj.accSumAmount floatValue];
                self.graphExpenseSubTitleOne.hidden = NO;
                self.imageGraphExpenseSubTileOne.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue1];
                self.graphExpenseSubTitleOne.text = graphLabel;
                self.imageGraphExpenseSubTileOne.backgroundColor = [UIColor colorWithRed:0.5709 green:0.7744 blue:0.3871 alpha:1.0];
                break;
            case 1:
                tempValue2 = [accObj.accSumAmount floatValue];
                self.graphExpenseSubTitleTwo.hidden = NO;
                self.imageGraphExpenseSubTileTwo.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue2];
                self.graphExpenseSubTitleTwo.text = graphLabel;
                self.imageGraphExpenseSubTileTwo.backgroundColor = [UIColor colorWithRed:0.8963 green:0.0519 blue:0.1903 alpha:1.0];
                break;    
            case 2:
                tempValue3 = [accObj.accSumAmount floatValue];
                self.graphExpenseSubTitleThree.hidden = NO;
                self.imageGraphExpenseSubTileThree.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue3];
                self.graphExpenseSubTitleThree.text = graphLabel;
                self.imageGraphExpenseSubTileThree.backgroundColor = [UIColor colorWithRed:0.8639 green:0.4783 blue:0.0 alpha:1.0];
                break;
                break;
            case 3:
                tempValue4 = [accObj.accSumAmount floatValue];
                self.graphExpenseSubTitleFour.hidden = NO;
                self.imageGraphExpenseSubTileFour.hidden = NO;
                graphLabel = [NSString stringWithFormat:@"%@ - $%.2f", accObj.acc000Name, tempValue4];
                self.graphExpenseSubTitleFour.text = graphLabel;
                self.imageGraphExpenseSubTileFour.backgroundColor = [UIColor colorWithRed:0.1567 green:0.3548 blue:1.0 alpha:1.0];
                break;
            default:
                break;
        }
    }
    
    total = tempValue1 + tempValue2 + tempValue3 + tempValue4;
    
    [_expensePieChartView setValuesForGraph:tempValue1 setGraphValue2:tempValue2 setGraphValue3:tempValue3 setGraphValue4:tempValue4 ];
    [_expensePieChartView setNeedsDisplay];
    
    self.graphTotalExpenses.text = [NSString stringWithFormat:@"Total Expenses: $%.2f", total];
}

- (IBAction)nextButtonAccountExpense:(UIButton *)sender 
{
    [self hideSubtitles:2];
    
    NSString *dateShowing = self.monthLabelAccountExpense.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:5];
    
    //Build the account graph for expenses
    [self createExpenseAccountGraph];
}

- (IBAction)previousButtonAccountExpense:(UIButton *)sender 
{
    [self hideSubtitles:2];
    
    NSString *dateShowing = self.monthLabelAccountExpense.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:5];
    
    //Build the account graph for expenses
    [self createExpenseAccountGraph];
}

- (void) createExpenseCategoryTableView
{
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelExpenseCategory.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
    
    yearShowing = [dateShowing substringFromIndex:6];
    
    arrayExpenseCategorySum = [IncomeExpensesData getDataToDisplayByCategory:[appDelegate getDBPath] withFilter:1 onMonth:monthShowing onYear:yearShowing];
    
    float total = 0;
    
    if (arrayExpenseCategorySum.count > 0)
    {
        self.categoryExpenseTableView.hidden = NO;
        self.emptyLabelExpenseCategory.hidden = YES;
        self.totalLabelExpenseCategory.hidden = NO;
    }
    else
    {
        self.categoryExpenseTableView.hidden = YES;
        self.emptyLabelExpenseCategory.hidden = NO;
        self.totalLabelExpenseCategory.hidden = YES;
    }
    
    for (int i=0; i<[arrayExpenseCategorySum count]; i++)
    {
        CategoryData *ctgObj = [arrayExpenseCategorySum objectAtIndex:i];
        total += [ctgObj.ctgSumAmount floatValue];
    }
    
    self.totalLabelExpenseCategory.text = [NSString stringWithFormat:@"Total Expenses: $%.2f", total];
    
    [_categoryExpenseTableView reloadData];
}

- (IBAction)nextButtonExpenseCategory:(UIButton *)sender
{
    self.categoryExpenseTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelExpenseCategory.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:6];
    
    //Build the expense category table view
    [self createExpenseCategoryTableView];
}

- (IBAction)previousButtonExpenseCategory:(UIButton *)sender 
{
    self.categoryExpenseTableView.hidden = YES;
    
    NSString *dateShowing = self.monthLabelExpenseCategory.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:6];
    
    //Build the expense category table view
    [self createExpenseCategoryTableView];
}

/*************************************************************************************************/

#pragma mark - all(income/expenses) view
//All (Income/Expenses) Screen
/*************************************************************************************************/
- (void) createIncExpGraph
{
    NSString *monthShowing;
    NSString *yearShowing;
    
    NSString *dateShowing = self.monthLabelAll.text;
    monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
    if (monthShowing.length < 2)
    {
        monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
    }
    
    yearShowing = [dateShowing substringFromIndex:6];
    
    NSMutableArray *arraySumIncExp = [IncomeExpensesData getDataToDisplayByIsIncome:[appDelegate getDBPath] onMonth:monthShowing onYear:yearShowing];
    
    float tempValue1 = 0;
    float tempValue2 = 0;
    
    float total = 0;
    
    int tempIsIncome = -1;
    
    NSString *graphLabel;
    
    if (arraySumIncExp.count > 0)
    {
        self.emptyLabelAll.hidden = YES;
        self.totalLabelAll.hidden = NO;
    }
    else
    {
        self.emptyLabelAll.hidden = NO;
        self.totalLabelAll.hidden = YES;
    }
    
    for (int i=0; i<[arraySumIncExp count]; i++)
    {
        IncomeExpensesData *incExpObj = [arraySumIncExp objectAtIndex:i];
        
        tempIsIncome = [incExpObj.incExpIsIncome intValue];
        
        if (tempIsIncome == 0)
        {
            tempValue1 = [incExpObj.incExpAmount floatValue];
            self.graphAllSubTitleOne.hidden = NO;
            self.imageGraphAllSubTitleOne.hidden = NO;
            graphLabel = [NSString stringWithFormat:@"Income - $%.2f", tempValue1];
            self.graphAllSubTitleOne.text = graphLabel;
            self.imageGraphAllSubTitleOne.backgroundColor = [UIColor colorWithRed:0.5709 green:0.7744 blue:0.3871 alpha:1.0];
        }
        else
        {
            tempValue2 = [incExpObj.incExpAmount floatValue];
            self.graphAllSubTitleTwo.hidden = NO;
            self.imageGraphAllSubTitleTwo.hidden = NO;
            graphLabel = [NSString stringWithFormat:@"Expenses - $%.2f", tempValue2];
            self.graphAllSubTitleTwo.text = graphLabel;
            self.imageGraphAllSubTitleTwo.backgroundColor = [UIColor colorWithRed:0.8936 green:0.0519 blue:0.1903 alpha:1.0];
        }
    }
    
    total = tempValue1 - tempValue2;
    
    [_pieChartViewAll setValuesForGraph:tempValue1 setGraphValue2:tempValue2 setGraphValue3:0 setGraphValue4:0];
    [_pieChartViewAll setNeedsDisplay];
    
    self.totalLabelAll.text = [NSString stringWithFormat:@"Total Savings: $%.2f", total];
}

- (IBAction)previousButtonAll:(UIButton *)sender 
{
    [self hideSubtitles:3];
    
    NSString *dateShowing = self.monthLabelAll.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:1 forView:7];
    
    //Build the account graph for income
    [self createIncExpGraph];
}

- (IBAction)nextButtonAll:(UIButton *)sender 
{
    [self hideSubtitles:3];
    
    NSString *dateShowing = self.monthLabelAll.text;
    
    int month = [self returnMonth:[dateShowing substringToIndex:3]];
    int year = [[dateShowing substringFromIndex:6]intValue];
    
    [self monthToShow:month ofYear:year withOperation:2 forView:7];
    
    //Build the account graph for income
    [self createIncExpGraph];
}

- (IBAction)buttonSendPDF:(UIButton *)sender
{
    [self generatePDF];
}
/*************************************************************************************************/
- (void) hideSubtitles:(int)sender
{
    //sender = 1 - income graph screen
    //sender = 2 - expense graph screen
    //sender = 3 - report graph screen
    
    switch (sender)
    {
        case 1:
            self.graphSubtitleOne.hidden = YES;
            self.imageGraphSubtitleOne.hidden = YES;
            self.graphSubtitleTwo.hidden = YES;
            self.imageGraphSubtitleTwo.hidden = YES;
            self.graphSubtitleThree.hidden = YES;
            self.imageGraphSubtitleThree.hidden = YES;
            self.graphSubtitleFour.hidden = YES;
            self.imageGraphSubtitleFour.hidden = YES;
            break;
            
        case 2:
            self.graphExpenseSubTitleOne.hidden = YES;
            self.imageGraphExpenseSubTileOne.hidden = YES;
            self.graphExpenseSubTitleTwo.hidden = YES;
            self.imageGraphExpenseSubTileTwo.hidden = YES;
            self.graphExpenseSubTitleThree.hidden = YES;
            self.imageGraphExpenseSubTileThree.hidden = YES;
            self.graphExpenseSubTitleFour.hidden = YES;
            self.imageGraphExpenseSubTileFour.hidden = YES;
            break;
            
        case 3:
            self.graphAllSubTitleOne.hidden = YES;
            self.imageGraphAllSubTitleOne.hidden = YES;
            self.graphAllSubTitleTwo.hidden = YES;
            self.imageGraphAllSubTitleTwo.hidden = YES;
            break;
            
        default:
            break;
    }
}


- (void) monthToShow:(int)month ofYear:(int)year withOperation:(int)operation forView:(int)sender
{   
    //sender = 1 - income account graph screen
    //sender = 2 - income category table view screen
    //sender = 3 - income list screen 
    //sender = 4 - expense list screen
    //sender = 5 - expense account graph screen
    //sender = 6 - expense category table view screen
    //sender = 7 - all graph screen
    
    //Operation = 0 - just show
    //Operation = 1 - previous month
    //Operation = 2 - next month
    
    NSString *title;
    
    if (operation == 0)
    {
        title = [self defineMonth:month completeDescription:1];
        title = [title stringByAppendingFormat:@" - %i", year];
    }
    else if (operation == 1)
    {
        //For months and years
        if (month == 1)
        {
            year -= 1;
            month = 12;
        }
        else
        {
            month -= 1;
        }
        
        title = [self defineMonth:month completeDescription:1];
        title = [title stringByAppendingFormat:@" - %i", year];
    }
    else if (operation == 2)
    {
        //For months and years
        if (month == 12)
        {
            year += 1;
            month = 1;
        }
        else
        {
            month += 1;
        }
        
        title = [self defineMonth:month completeDescription:1];
        title = [title stringByAppendingFormat:@" - %i", year];
    }
    
    switch (sender)
    {
        case 1:
            self.monthLabelAccountGraph.text = title; 
            break;
            
        case 2:
            self.monthLabelIncomeCategoryGraph.text = title;
            break;
            
        case 3:
            self.monthLabelIncomeList.text = title;
            break;
            
        case 4:
            self.monthLabelExpenseList.text = title;
            break;
            
        case 5:
            self.monthLabelAccountExpense.text = title; 
            break;
            
        case 6:
            self.monthLabelExpenseCategory.text = title;
            break;
            
        case 7:
            self.monthLabelAll.text = title;
            break;
            
        default:
            break;
    }
}

- (NSString *)defineMonth:(int)month completeDescription:(int)complete
{
    //complete = 0 (complete description)
    //complete = 1 (abreviation)
    
    NSString *monthName;
    
    if (complete == 0)
    {
        switch (month) 
        {
            case 1:
                monthName = @"January";
                break;
            case 2:
                monthName = @"February";
                break;
            case 3:
                monthName = @"March";
                break;
            case 4:
                monthName = @"April";
                break;
            case 5:
                monthName = @"May";
                break;
            case 6:
                monthName = @"June";
                break;
            case 7:
                monthName = @"July";
                break;
            case 8:
                monthName = @"August";
                break;
            case 9:
                monthName = @"September";
                break;
            case 10:
                monthName = @"October";
                break;
            case 11:
                monthName = @"November";
                break;
            case 12:
                monthName = @"December";
                break;
            default:
                break;
        }
    }
    else
    {
        switch (month) 
        {
            case 1:
                monthName = @"Jan";
                break;
            case 2:
                monthName = @"Feb";
                break;
            case 3:
                monthName = @"Mar";
                break;
            case 4:
                monthName = @"Apr";
                break;
            case 5:
                monthName = @"May";
                break;
            case 6:
                monthName = @"Jun";
                break;
            case 7:
                monthName = @"Jul";
                break;
            case 8:
                monthName = @"Aug";
                break;
            case 9:
                monthName = @"Sep";
                break;
            case 10:
                monthName = @"Oct";
                break;
            case 11:
                monthName = @"Nov";
                break;
            case 12:
                monthName = @"Dec";
                break;
            default:
                break;
        }
    }
    
    return monthName;
}

- (int) returnMonth:(NSString *)month
{
    int numericMonth;
    
    if ([month isEqualToString:@"Jan"])
    {
        numericMonth = 1;
    }
    else if ([month isEqualToString:@"Feb"])
    {
        numericMonth = 2;
    }
    else if ([month isEqualToString:@"Mar"])
    {
        numericMonth = 3;
    }
    else if ([month isEqualToString:@"Apr"])
    {
        numericMonth = 4;
    }
    else if ([month isEqualToString:@"May"])
    {
        numericMonth = 5;
    }
    else if ([month isEqualToString:@"Jun"])
    {
        numericMonth = 6;
    }
    else if ([month isEqualToString:@"Jul"])
    {
        numericMonth = 7;
    }
    else if ([month isEqualToString:@"Aug"])
    {
        numericMonth = 8;
    }
    else if ([month isEqualToString:@"Sep"])
    {
        numericMonth = 9;
    }
    else if ([month isEqualToString:@"Oct"])
    {
        numericMonth = 10;
    }
    else if ([month isEqualToString:@"Nov"])
    {
        numericMonth = 11;
    }
    else if ([month isEqualToString:@"Dec"])
    {
        numericMonth = 12;
    }
    
    return numericMonth;
}

- (IBAction)doneEditingButton:(UIButton *)sender 
{
    if (self.tableBeingEdit.tag == 1)
    {
        self.monthLabelIncomeList.hidden = NO;
        self.previousButtonIncomeListProperties.hidden = NO;
        self.nextButtonIncomeListProperties.hidden = NO;
        
        self.doneEditingButtonProperties.hidden = YES;
    }
    else if (self.tableBeingEdit.tag == 3)
    {
        self.monthLabelExpenseList.hidden = NO;
        self.previousButtonExpenseListProperties.hidden = NO;
        self.nextButtonExpenseListProperties.hidden = NO;
        
        self.doneEditingExpenseButtonProperties.hidden = YES;
    }

    [self.tableBeingEdit setEditing:NO];
    self.tableBeingEdit = nil;
}

#pragma mark - PDF generator
//PDF Generator
/*************************************************************************************************/
- (void) generatePDF
{
    //Verifies if there is data to be extract to a pdf file
    if (self.emptyLabelAll.isHidden == YES)
    {
        //used to print a line between incomes and expenses
        BOOL printLineForExpense = NO;
        
        //Get the date to be used in the pdf
        NSString *monthShowing;
        NSString *yearShowing;
        
        NSString *dateShowing = self.monthLabelAll.text;
        monthShowing = [NSString stringWithFormat:@"%i",[self returnMonth:[dateShowing substringToIndex:3]]];
        if (monthShowing.length < 2)
        {
            monthShowing = [NSString stringWithFormat:@"0%@", monthShowing];
        }
        
        yearShowing = [dateShowing substringFromIndex:6];
        
        //Get the array with data
        NSMutableArray *arrayListIncExp = [IncomeExpensesData getDataForPDF:[appDelegate getDBPath] onMonth:monthShowing onYear:yearShowing];
        
        // get a temprorary filename for this PDF
        NSString *path = NSTemporaryDirectory();
        pdfFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%f.pdf", [[NSDate date] timeIntervalSince1970] ]];
        
        // Create the PDF context using the default page size of 612 x 792.
        // This default is spelled out in the iOS documentation for UIGraphicsBeginPDFContextToFile
        UIGraphicsBeginPDFContextToFile(pdfFilePath, CGRectZero, nil);
        
        // get the context reference so we can render to it.
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //count the number of pages
        int currentPage = 1;
        
        // maximum height and width of the content on the page, byt taking margins into account.
        CGFloat maxWidth = kDefaultPageWidth - kMargin * 2;
        CGFloat maxHeight = kDefaultPageHeight - kMargin * 2;
        
        // define the maximum width for each string to be impressed on the pdf
        CGFloat categoryMaxWidth = (maxWidth / 5) + 25;
        CGFloat amountMaxWidth = maxWidth / 5;
        CGFloat dateMaxWidth = (maxWidth / 5) - 10;
        CGFloat accountMaxWidth = maxWidth / 5;
        CGFloat isIncomeMaxWidth = maxWidth / 5;
        
        // only create the fonts once since it is a somewhat expensive operation
        UIFont* titleFont = [UIFont boldSystemFontOfSize:17];
        UIFont* subTitleFont = [UIFont boldSystemFontOfSize:15];
        UIFont* textFont = [UIFont boldSystemFontOfSize:12];
        
        //variable that will control the heigth of the page
        CGFloat currentPageY = 0;
        
        // Mark the beginning of a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth, kDefaultPageHeight), nil);
        currentPageY = kMargin;
        
        //Draw the title
        NSString *title = [NSString stringWithFormat:@"NUMMUS - Report Income/Expenses - %@", dateShowing];
        CGSize sizeText = [title sizeWithFont:titleFont forWidth:maxWidth lineBreakMode:UILineBreakModeWordWrap];
        [title drawAtPoint:CGPointMake(kMargin, currentPageY) forWidth:maxWidth withFont:titleFont lineBreakMode:UILineBreakModeWordWrap];
        currentPageY += sizeText.height;
        
        //Draw the number of the page
        NSString* pageNumberString = [NSString stringWithFormat:@"Page %d", currentPage];
        sizeText = [pageNumberString sizeWithFont:textFont forWidth:maxWidth lineBreakMode:UILineBreakModeWordWrap];
        [pageNumberString drawAtPoint:CGPointMake(kMargin, currentPageY) forWidth:maxWidth withFont:textFont lineBreakMode:UILineBreakModeWordWrap];
        currentPageY += sizeText.height;
        
        // draw a one pixel line under page's number
        CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.2092 green:0.4642 blue:0.9319 alpha:1.0] CGColor]);
        CGContextMoveToPoint(context, kMargin, currentPageY);
        CGContextAddLineToPoint(context, kDefaultPageWidth - kMargin, currentPageY);
        CGContextStrokePath(context);
        
        //draw the subtitle
        NSString *subTitle = @"Category               Date                 Amount           Account         Type";
        sizeText = [subTitle sizeWithFont:subTitleFont forWidth:maxWidth lineBreakMode:UILineBreakModeWordWrap];
        [subTitle drawAtPoint:CGPointMake(kMargin, currentPageY) forWidth:maxWidth withFont:subTitleFont lineBreakMode:UILineBreakModeWordWrap];
        currentPageY += sizeText.height;
        
        // draw a one pixel line under the subtitle
        CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.2092 green:0.4642 blue:0.9319 alpha:1.0] CGColor]);
        CGContextMoveToPoint(context, kMargin, currentPageY);
        CGContextAddLineToPoint(context, kDefaultPageWidth - kMargin, currentPageY);
        CGContextStrokePath(context);
        
        // iterate through out the list, adding to the pdf each time.
        for (int i=0; i<[arrayListIncExp count]; i++)
        {
            IncomeExpensesData *incExpObj = [arrayListIncExp objectAtIndex:i];

            NSString *tempCategory = incExpObj.incExpCategory;
            NSString *tempDate = incExpObj.incExpDate;
            NSString *tempAmount = [NSString stringWithFormat:@"$%.2f", [incExpObj.incExpAmount floatValue]];
            NSString *tempAccount = incExpObj.incExpAccount;
            int tempisIncome = [incExpObj.incExpIsIncome intValue];
            NSString *tempIsIncome;
            if (tempisIncome == 0)
            {
                tempIsIncome = @"Income";
            }
            else
            {
                tempIsIncome = @"Expenses";
                if (!printLineForExpense)
                {
                    printLineForExpense = YES;
                    
                    // draw a red line to separate incomes from expenses
                    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.8983 green:0.2763 blue:0.0842 alpha:1.0] CGColor]);
                    CGContextMoveToPoint(context, kMargin, currentPageY);
                    CGContextAddLineToPoint(context, kDefaultPageWidth - kMargin, currentPageY);
                    CGContextStrokePath(context);
                }
            }
            
            //actual size of the text in the entire page
            sizeText = [tempCategory sizeWithFont:textFont constrainedToSize:CGSizeMake(categoryMaxWidth, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
            
            // if the current text would render beyond the bounds of the page,
            // start a new page and render it there instead
            if (sizeText.height + currentPageY > maxHeight) {
                // create a new page and reset the current page's Y value
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth, kDefaultPageHeight), nil);
                currentPageY = kMargin;
                
                // increment the page number.
                currentPage++;
                
                //print the number of the page on top
                pageNumberString = [NSString stringWithFormat:@"Page %d", currentPage];
                sizeText = [pageNumberString sizeWithFont:textFont forWidth:maxWidth lineBreakMode:UILineBreakModeWordWrap];
                [pageNumberString drawAtPoint:CGPointMake(kMargin, currentPageY) forWidth:maxWidth withFont:textFont lineBreakMode:UILineBreakModeWordWrap];
                currentPageY += sizeText.height;
            }
            
            //print the category
            [tempCategory drawInRect:CGRectMake(kMargin, currentPageY, categoryMaxWidth, maxHeight) withFont:textFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
            
            // print the date
            [tempDate drawInRect:CGRectMake(kMargin + categoryMaxWidth, currentPageY, dateMaxWidth, maxHeight) withFont:textFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
            
            // print the amount
            [tempAmount drawInRect:CGRectMake(kMargin + categoryMaxWidth + dateMaxWidth + kColumnMargin, currentPageY, amountMaxWidth, maxHeight) withFont:textFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];

            // print the account
            [tempAccount drawInRect:CGRectMake(kMargin + categoryMaxWidth + dateMaxWidth + amountMaxWidth + kColumnMargin, currentPageY, accountMaxWidth, maxHeight) withFont:textFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
            
            // print the type (income/expense)
            [tempIsIncome drawInRect:CGRectMake(kMargin + categoryMaxWidth + dateMaxWidth + amountMaxWidth + accountMaxWidth + kColumnMargin, currentPageY, isIncomeMaxWidth, maxHeight) withFont:textFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
            
            currentPageY += sizeText.height;
        }
        
        //print the total of savings
        NSString *totalSavings = [NSString stringWithFormat:@"\n%@", self.totalLabelAll.text];
        [totalSavings drawInRect:CGRectMake(kMargin, currentPageY, maxWidth, maxHeight) withFont:textFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
        
        // end and save the PDF.
        UIGraphicsEndPDFContext();
        
        // Ask the user if they'd like to see the file or email it.
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Would you like to preview or email this PDF?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Preview", @"Email", nil];
        [actionSheet showInView:self.view];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops!" message:@"No data to be exported to PDF" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Action Sheet button %d", buttonIndex);
    
    if (buttonIndex == 0) {
        
        // present a preview of this PDF File.
        QLPreviewController* preview = [[QLPreviewController alloc] init];
        preview.dataSource = self;
        [self presentModalViewController:preview animated:YES];
        
    }
    else if(buttonIndex == 1)
    {
        if ([MFMailComposeViewController canSendMail])
        {
            // email the PDF File.
            MFMailComposeViewController* mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer addAttachmentData:[NSData dataWithContentsOfFile:pdfFilePath] mimeType:@"application/pdf" fileName:@"NummusReport.pdf"];
            
            [mailer setSubject:@"Nummus - Your report is here!"];
            
            NSString *emailBody = @"Attached.";
            [mailer setMessageBody:emailBody isHTML:NO];
            
            mailer.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:mailer animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Your device doesn't support the composer sheet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
    }
}

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [NSURL fileURLWithPath:pdfFilePath];
}
/*************************************************************************************************/

@end
