//
//  AddCategoryViewController.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddCategoryViewController.h"

@implementation AddCategoryViewController
{
    NummusMainViewControllerAppDelegate *appDelegate;
}

@synthesize nameTextField = _nameTextField;
@synthesize availableSegmentField = _availableSegmentField;
@synthesize swipeLeftProperties = _swipeLeftProperties;
@synthesize swipeRigthDoneProperties = _swipeRigthDoneProperties;

#pragma mark - view methods
//View Methods
//***********************************************************************************************************
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
    
    [_nameTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    //Clean the objects with data
    appDelegate = nil; 
    
    [self setNameTextField:nil];
    [self setAvailableSegmentField:nil];
    [self setSwipeLeftProperties:nil];
    [self setSwipeRigthDoneProperties:nil];
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


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if(buttonIndex == [alertView cancelButtonIndex])
        {
            [self returnMainView];
        }
        else 
        {
            [_nameTextField becomeFirstResponder];
        }
    }
}
//*********************************************************************************************************** 

#pragma mark - my methods
//My methods
//*********************************************************************************************************** 
- (IBAction) swipeLeftCancel:(UISwipeGestureRecognizer *)sender 
{
    UIAlertView *alertCancel = [[UIAlertView alloc] initWithTitle:@"Cancel add category" message:@"Confirm cancel?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alertCancel.tag = 1;
    [alertCancel show];
}

- (IBAction) swipeRigthDone:(UISwipeGestureRecognizer *)sender
{
    BOOL _isValidate = [self validateNewCategory];
    if (_isValidate == TRUE)
    {
        [self saveNewCategory];
        [self returnMainView];    
    }
}

- (IBAction)availableSegmentFieldPressed:(UISegmentedControl *)sender 
{
    [self dismissKeyboard];
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(void)dismissKeyboard
{
    [_nameTextField resignFirstResponder];
}

- (void) returnMainView
{ 
    [self dismissModalViewControllerAnimated:YES];
    [self viewDidUnload];
}

- (void) saveNewCategory
{
    appDelegate = (NummusMainViewControllerAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //Create a category object
    //Initiates with the primary key = 0 because it will not be used
    CategoryData *categoryObj = [[CategoryData alloc] initWithPrimaryKey:0];
    
    NSNumber *_isIncome = [[NSNumber alloc] initWithInt:_availableSegmentField.selectedSegmentIndex];
    
    categoryObj.ctg000Name = _nameTextField.text;
    categoryObj.ctg000isIncome = _isIncome;
    
    [categoryObj addCategory:[appDelegate getDBPath]];
}

- (BOOL) validateNewCategory
{
    appDelegate = (NummusMainViewControllerAppDelegate *) [[UIApplication sharedApplication] delegate];

    NSString *messageTitle;
    NSString *message;
    
    BOOL _validated = YES;
    
    if (_nameTextField.text.length == 0)
    {
        _validated = NO;
        messageTitle = @"Ops!";
        message = @"Please, provide the category name";
    }
    
    int _isIncome = _availableSegmentField.selectedSegmentIndex;
    Boolean _validatedDataBase = [CategoryData validateNewCategory:[appDelegate getDBPath] filterBy:_isIncome compareTo:_nameTextField.text];
    
    if (_validatedDataBase == NO)
    {
        _validated = NO;
        messageTitle = @"Ops!";
        message = @"Category name already exist";        
    }
    
    if (_validated == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageTitle message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
        [_nameTextField becomeFirstResponder];
    }
    
    return _validated;
}

@end
