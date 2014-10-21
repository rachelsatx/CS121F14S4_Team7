//
//  PreDayViewController.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayViewController.h"
#import "PreDayInventoryView.h"

@interface PreDayViewController (){
    DataStore* _dataStore;
    PreDayInventoryView* _inventoryView;
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
    NSString* weather = [_dataStore getWeather];
    if ([weather isEqualToString:@"sunny"]) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
