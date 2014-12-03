//
//  PreferencesViewController.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferencesViewController.h"

const int _PREFERENCES = 1;
const int _HELP = 2;
const int _ABOUT = 3;

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

@synthesize switchSound = _switchSound;
@synthesize segmentShowSavings = _segmentShowSavings;

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
    
    [self additionalViewDidLoad];
}

- (void)viewDidUnload
{
    [self setSwitchSound:nil];
    [self setSegmentShowSavings:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addCategoryButton:(UIButton *)sender 
{
    [self performSegueWithIdentifier:@"addCategoryScreen" sender:self];
}

- (IBAction)preferencesButton:(UIButton *)sender 
{
    [self setSubViewScreen:_PREFERENCES];
}

- (IBAction)helpButton:(UIButton *)sender 
{
    [self setSubViewScreen:_HELP];
}

- (IBAction)aboutButton:(UIButton *)sender 
{
    [self setSubViewScreen:_ABOUT];
}

- (IBAction)rateButton:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=550860183"]];
}

- (IBAction)sendEmailButton:(UIButton *)sender 
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Check it out this great app to control your budget!"];
        
        NSString *emailBody = @"Hey! \nCheck it out Nummus, an easy and great app to control your budget.\n \nSee more about it on facebook: www.facebook.com/nummusapp\n \nSee ya";
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

- (IBAction)supportRequestButton:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Nummus - Support Request"];
        
        NSArray *toRecipients = [NSArray arrayWithObject:@"nummussupport@redclockapps.com"];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"Support:";
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

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)swipeLeftDone:(UISwipeGestureRecognizer *)sender 
{ 
    [self updatePreferences];
    [self dismissModalViewControllerAnimated:YES];
    [self returnMainView];
}

- (IBAction)swipeRigthDone:(UISwipeGestureRecognizer *)sender 
{ 
    [self updatePreferences];
    [self dismissModalViewControllerAnimated:YES];
    [self returnMainView];
}

- (void) additionalViewDidLoad
{
    appDelegate = (NummusMainViewControllerAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSInteger isOn = [PreferencesData getPreferences:[appDelegate getDBPath] withFilter:0];
    NSInteger showBy = [PreferencesData getPreferences:[appDelegate getDBPath] withFilter:1];
    
    if (isOn == 0)
    {
        self.switchSound.on = YES;
    }
    else
    {
        self.switchSound.on = NO;
    }
    
    switch (showBy)
    {
        //0 = Month, 1 = Year, 2 = Total
        case 0:
            self.segmentShowSavings.selectedSegmentIndex = 0;
            break;
        case 1:
            self.segmentShowSavings.selectedSegmentIndex = 1;
            break;
        case 2:
            self.segmentShowSavings.selectedSegmentIndex = 2;
            break;
        default:
            break;
    }
                      
}

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

- (void) updatePreferences
{
    NSInteger _isOn;
    
    BOOL _isOnScreen = self.switchSound.isOn;
    NSInteger _showBy = self.segmentShowSavings.selectedSegmentIndex;
    
    if (_isOnScreen)
    {
        _isOn = 0;
    }
    else 
    {
        _isOn = 1;
    }
    
    [PreferencesData updatePreferences:[appDelegate getDBPath] soundPlay:_isOn showBy:_showBy];
}

@end
