//
//  MidDayViewController.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MidDayViewController.h"
#import "PostDayViewController.h"
#import "MidDayView.h"
#import "Model.h"

@interface MidDayViewController () {
    DataStore *_dataStore;
    MidDayView *_midDayView;
}
@end

@implementation MidDayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Run Model immediately
        _dataStore = [self runModelWith:_dataStore];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the MidDay View
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    _midDayView = [[MidDayView alloc] initWithFrame:frame];
    [self.view addSubview:_midDayView];
    
    [self.view bringSubviewToFront:_goToPostDayButton];
}

- (void)setDataStore:(DataStore *) dataStore
{
    _dataStore = dataStore;
}

- (DataStore *)runModelWith:(DataStore *)dataStore
{
    // RUN THE MODEL FOR THE DAY AND RETURN THE MODIFIED DATASTORE
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"MidDayToPostDay"])
    {
        // Get reference to the destination view controller
        PostDayViewController *postDayViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [postDayViewController setDataStore:_dataStore];
    }
}

@end
