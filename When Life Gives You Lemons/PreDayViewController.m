//
//  PreDayViewController.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayViewController.h"
#import "PreDayInventoryView.h"
#import "MidDayViewController.h"
#import "PreDayRecipeView.h"

@interface PreDayViewController (){
    DataStore* _dataStore;
    PreDayInventoryView* _inventoryView;
    PreDayRecipeView* _recipeView;
}

@end

@implementation PreDayViewController

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
    
    // Update the Info View
    [self updatePrice];
    [self updateWeather];
    
    // Create the Inventory View
    CGRect allViewsFrame = CGRectMake(0, 55, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    _inventoryView = [[PreDayInventoryView alloc] initWithFrame:allViewsFrame];
    [_inventoryView setHidden:YES];
    [self.view addSubview:_inventoryView];
    
    // Create the Recipe View
    _recipeView = [[PreDayRecipeView alloc] initWithFrame:allViewsFrame];
    [_recipeView setHidden:YES];
    [self.view addSubview:_recipeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDataStore:(DataStore*) dataStore
{
    _dataStore = dataStore;
}

- (IBAction)incrementPrice:(id)sender
{
    if ([_dataStore getPrice] < 99.89) { // Off by .01 because of floating point errors
        [_dataStore setPrice:[_dataStore getPrice] + .1];
        [self updatePrice];
    }
}

- (IBAction)decrementPrice:(id)sender
{
    if ([_dataStore getPrice] > 0.01) { // Off by .01 because of floating point errors
        [_dataStore setPrice:[_dataStore getPrice] - .1];
        [self updatePrice];
    }
}

- (void)updatePrice
{
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %.2f", [_dataStore getPrice]];
}

- (void)updateWeather
{
    Weather weather = [_dataStore getWeather];
    if (weather == Sunny) {
        [self.weatherImage setImage:[UIImage imageNamed:@"sun"]];
    }
}

- (IBAction)displayInventory:(id)sender
{
    [_inventoryView setHidden:NO];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view bringSubviewToFront:_inventoryView];
}

- (IBAction)displayRecipe:(id)sender
{
    [_recipeView setHidden:NO];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view bringSubviewToFront:_recipeView];
}

- (IBAction)displayDayInfo:(id)sender
{
    [_recipeView setHidden:YES];
    [_inventoryView setHidden:YES];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view sendSubviewToBack:_recipeView];
    [self.view sendSubviewToBack:_inventoryView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PreDayToMidDay"])
    {
        // Get reference to the destination view controller
        MidDayViewController* midDayViewController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [midDayViewController setDataStore:_dataStore];
    }
}

@end
