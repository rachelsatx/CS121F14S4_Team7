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
#import "MenuMainView.h"
#import "DataStore.h"

@interface MenuViewController () {
    DataStore* _dataStore;
    MenuMainView* _mainView;
    MenuInstructionsView* _instructionsView;
}
@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create frame for additional views
    CGRect viewFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    // Create the Main View
    _mainView = [[MenuMainView alloc] initWithFrame:viewFrame];
    [_mainView setDelegate:self];
    [self.view addSubview:_mainView];
    
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

- (void)newGame:(id)sender
{
    // If new game, DataStore should be empty
    _dataStore = [[DataStore alloc] init];
    [self performSegueWithIdentifier:@"MenuToPreDay" sender:self];
}

- (void)continueGame:(id)sender
{
    // If continue game, we need to load the DataStore from JSON
    [self performSegueWithIdentifier:@"MenuToPreDay" sender:self];
}

-(void)continueGame:(id)sender
{
    NSString *savePath = [[NSBundle mainBundle] pathForResource:@"save1" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:savePath];
    NSError *error = nil;
    
    NSDictionary* dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                              error:&error];
    
    [_dataStore initWithDictionary:dataDictionary];
    [self performSegueWithIdentifier:@"MenuToPreDay" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"MenuToPreDay"])
    {
        // Get reference to the destination view controller
        PreDayViewController* preDayViewController = [segue destinationViewController];
        
        // Pass dataStore to the view controller
        [preDayViewController setDataStore:_dataStore];
    }
}

- (IBAction)unwindToMenu:(UIStoryboardSegue*)unwindSegue
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
