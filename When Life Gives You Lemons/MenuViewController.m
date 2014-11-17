//
//  MenuViewController.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/17/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MenuViewController.h"
#import "PreDayViewController.h"
#import "MenuInstructionsView.h"
#import "DataStore.h"

@interface MenuViewController () {
    DataStore* _dataStore;
    MenuInstructionsView* _instructionsView;
}

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _dataStore = [[DataStore alloc] init];
    
    // Create frame for additional views
    CGRect viewFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetWidth(self.view.frame);
    
    CGRect instructionsButtonFrame = CGRectMake(width/2 - 50, height/2 + 150, 100, 20); // magic numbers
    UIButton* instructionsButton = [[UIButton alloc] initWithFrame:instructionsButtonFrame];
    [instructionsButton setTitle:@"How to Play" forState:UIControlStateNormal];
    [instructionsButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [instructionsButton addTarget:self
                        action:@selector(displayInstructions:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instructionsButton];
    
    // Create the Instructions View
    _instructionsView = [[MenuInstructionsView alloc] initWithFrame:viewFrame];
    [_instructionsView setHidden:YES];
    [self.view addSubview:_instructionsView];
}

- (void)displayInstructions:(id)sender
{
    [_instructionsView setHidden:NO];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view bringSubviewToFront:_instructionsView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"MenuToPreDay"])
    {
        // Get reference to the destination view controller
        PreDayViewController* preDayViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [preDayViewController setDataStore:_dataStore];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
