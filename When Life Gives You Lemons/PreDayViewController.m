//
//  PreDayViewController.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayViewController.h"

@interface PreDayViewController (){
    DataStore* _dataStore;
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
    // Do any additional setup after loading the view.
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %.2f", [_dataStore getPrice]];
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
    [_dataStore setPrice:[_dataStore getPrice] + .1];
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %.2f", [_dataStore getPrice]];
}

- (IBAction)decrementPrice:(id)sender
{
    [_dataStore setPrice:[_dataStore getPrice] - .1];
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %.2f", [_dataStore getPrice]];
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
