//
//  AddCategoryViewController.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NummusMainViewControllerAppDelegate.h"
#import "CategoryData.h"

@interface AddCategoryViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *availableSegmentField;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftProperties;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRigthDoneProperties;

//Buttons Actions
- (IBAction)swipeLeftCancel:(UISwipeGestureRecognizer *)sender;
- (IBAction)availableSegmentFieldPressed:(UISegmentedControl *)sender;
- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender;

//Instance Methods
- (IBAction)textFieldReturn:(id)sender;
- (void) returnMainView;
- (void) dismissKeyboard;
- (void) saveNewCategory;
- (BOOL) validateNewCategory;


@end
