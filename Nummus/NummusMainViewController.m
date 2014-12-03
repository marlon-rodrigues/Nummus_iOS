//
//  NummusMainViewControllerViewController.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NummusMainViewController.h"

@implementation NummusMainViewController
{
    //Holds the list of incomes and expenses - fill with data from the database (table incExp)
    NSMutableArray *incomeExpensesArray;
    
    //Holds the actual date
    NSDate *currentDate;
}

#pragma mark - view methods
//View Methods
/*************************************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Loads all the incomes and expenses to calculate the total of savings
    appDelegate = (NummusMainViewControllerAppDelegate *)[[UIApplication sharedApplication]delegate];
    [self getDataToCalculateSavings];
    
    //Access the method that calculate the total of savings
    [self totalIncomeExpensesValues:incomeExpensesArray];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
} 

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Loads all the incomes and expenses and calculates the total of savings
    [self getDataToCalculateSavings];
    [self totalIncomeExpensesValues:incomeExpensesArray];
}

/*************************************************************************************************/

#pragma mark - my methods
//My Methods
/*************************************************************************************************/
//Gets the data to calculate the savings
- (void) getDataToCalculateSavings
{
    NSString *_month = nil;
    NSString *_year = nil;
    
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
    
    //Uses the preferences table to determine which total of savings to show
    int _showBy = [PreferencesData getPreferences:[appDelegate getDBPath] withFilter:1];
    
    _month = [[strDate substringFromIndex:5] substringToIndex:2];
    _year = [strDate substringToIndex:4];
    
    incomeExpensesArray = [IncomeExpensesData getInitialDataToDisplay:[appDelegate getDBPath] withFilter:_showBy onMonth:_month onYear:_year];
}

//Calculates the total savings
- (void) totalIncomeExpensesValues:incExpArray
{
    double total = 0;
    double totalIncome = 0;
    double totalExpenses = 0;
    
    
    for (int i=0; i < [incExpArray count]; i++)
    {
        IncomeExpensesData *incExpObj = [incExpArray objectAtIndex:i];
        
        if ([incExpObj.incExpIsIncome intValue] == 0)
        {
            totalIncome += [incExpObj.incExpAmount doubleValue];
        }
        else if ([incExpObj.incExpIsIncome intValue]== 1)
        {
            totalExpenses += [incExpObj.incExpAmount doubleValue];
        }
    }
    
    total = totalIncome - totalExpenses;
    
    _totalSavings.text = [NSString stringWithFormat:@"Savings $%.2f", total];
    
    [self defineColorLabelTotalSavings:total];
}


//Sets the color of the text field that holds the value of total savings
- (void) defineColorLabelTotalSavings:(double)totalSavingsDefined
{
    if (totalSavingsDefined < 0)
    {
        _totalSavings.textColor = [UIColor colorWithRed:0.7404 green:0.3993 blue:0.1470 alpha:1.0];
    }
    else 
    {
        _totalSavings.textColor = [UIColor colorWithRed:0.3979 green:0.5954 blue:0.4414 alpha:1.0];
    }
}

- (IBAction)buttonPreferences:(UIButton *)sender
{
     [self performSegueWithIdentifier:@"preferencesScreen" sender:self];
}

- (IBAction)buttonReport:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"reportScreen" sender:self];
}

- (IBAction)buttonExpenses:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"expensesScreen" sender:self];
}

- (IBAction)buttonIncome:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"incomeScreen" sender:self];
}


@end
