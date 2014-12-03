//
//  PreferencesViewController.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "NummusMainViewControllerAppDelegate.h"
#import "PreferencesData.h"

@interface PreferencesViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    NummusMainViewControllerAppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UISwitch *switchSound;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentShowSavings;

//Buttons
- (IBAction)addCategoryButton:(UIButton *)sender;
- (IBAction)preferencesButton:(UIButton *)sender;
- (IBAction)helpButton:(UIButton *)sender;
- (IBAction)aboutButton:(UIButton *)sender;
- (IBAction)sendEmailButton:(UIButton *)sender;
- (IBAction)rateButton:(UIButton *)sender;
- (IBAction)supportRequestButton:(UIButton *)sender;

//Swipe
- (IBAction)swipeLeftDone:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender;

//Instance Methods
- (void) returnMainView;
- (void) updatePreferences;
- (void) setSubViewScreen:(int)sender;
- (void) additionalViewDidLoad;

@end
