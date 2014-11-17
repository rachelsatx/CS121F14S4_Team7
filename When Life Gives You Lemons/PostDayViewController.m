//
//  PostDayViewController.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PostDayViewController.h"
#import "PreDayViewController.h"
#import "PostDayView.h"

@interface PostDayViewController () {
    DataStore *_dataStore;
    PostDayView *_postDayView;
}
@end

@implementation PostDayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the PostDay View
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGRect frame = CGRectMake(0, 0, width, height);
    _postDayView = [[PostDayView alloc] initWithFrame:frame andDataStore:_dataStore];
    [self.view addSubview:_postDayView];
    
    [self.view bringSubviewToFront:_goToPreDayButton];
}

- (void)setDataStore:(DataStore *) dataStore
{
    _dataStore = dataStore;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PostDayToPreDay"])
    {
        // Get reference to the destination view controller
        PreDayViewController* preDayViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [preDayViewController setDataStore:_dataStore];
    }
}

@end
