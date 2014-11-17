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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Update the Info View
    [self updatePrice];
    [self updateWeather];
    
    // Create frame for additional views
    CGFloat header = 90;
    CGFloat footer = 90;
    CGRect allViewsFrame = CGRectMake(0, header, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - header - footer);
    
    // Create the Inventory View
    _inventoryView = [[PreDayInventoryView alloc] initWithFrame:allViewsFrame];
    [_inventoryView setHidden:YES];
    [self.view addSubview:_inventoryView];
    [_inventoryView setDelegate:self];
    [_inventoryView updateAmountLabels];
    [_inventoryView updateMoneyLabel];
    [_inventoryView updatePriceLabels];
    
    // Create the Recipe View
    _recipeView = [[PreDayRecipeView alloc] initWithFrame:allViewsFrame];
    [_recipeView setHidden:YES];
    [self.view addSubview:_recipeView];
    [_recipeView setDelegate:self];
    [_recipeView updatePercentageLabels];
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
    if ([[_dataStore getPrice] floatValue] <= 99.9) { // Off by .01 because of floating point errors
        [_dataStore setPrice:[NSNumber numberWithFloat:[[_dataStore getPrice] floatValue] + .1]];
        [self updatePrice];
    }
}

- (IBAction)decrementPrice:(id)sender
{
    if ([[_dataStore getPrice] floatValue] >= 0.1) { // Off by .01 because of floating point errors
        [_dataStore setPrice:[NSNumber numberWithFloat:[[_dataStore getPrice] floatValue] - .1]];
        [self updatePrice];
    }
}

- (void)updatePrice
{
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %.2f", [[_dataStore getPrice] floatValue]];
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

- (IBAction)unwindToPreDay:(UIStoryboardSegue*)unwindSegue
{
    [_inventoryView setHidden:YES];
    [_inventoryView updateAmountLabels];
    [_inventoryView updateMoneyLabel];
    [_inventoryView updatePriceLabels];
    
    [_recipeView setHidden:YES];
    [_recipeView updatePercentageLabels];
}

- (NSNumber*) getLemons
{
    return [[_dataStore getInventory] valueForKey:@"lemons"];
}

- (void) setLemons:(NSNumber*) newLemons
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newLemons forKey:@"lemons"];
    [_dataStore setInventory:inventory];
}

- (NSNumber*) getSugar
{
    return [[_dataStore getInventory] valueForKey:@"sugar"];
}
- (void) setSugar:(NSNumber*) newSugar
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newSugar forKey:@"sugar"];
    [_dataStore setInventory:inventory];
}
- (NSNumber*) getIce
{
    return [[_dataStore getInventory] valueForKey:@"ice"];
}
- (void) setIce:(NSNumber*) newIce
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newIce forKey:@"ice"];
    [_dataStore setInventory:inventory];
}
- (NSNumber*) getCups
{
    return [[_dataStore getInventory] valueForKey:@"cups"];
}
- (void) setCups:(NSNumber*) newCups
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newCups forKey:@"cups"];
    [_dataStore setInventory:inventory];
}
- (NSNumber*) getMoney
{
    return [_dataStore getMoney];
}
- (void) setMoney:(NSNumber*) newMoney
{
    [_dataStore setMoney:newMoney];
}
- (NSNumber*) getLemonPrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"lemons"];
}
- (NSNumber*) getSugarPrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"sugar"];
}
- (NSNumber*) getIcePrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"ice"];
}
- (NSNumber*) getCupsPrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"cups"];
}
- (NSNumber*) getLemonsPercentage
{
    return [[_dataStore getRecipe] valueForKey:@"lemons"];
}
- (void) setLemonsPercentage:(NSNumber*) newLemons
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newLemons forKey:@"lemons"];
    [_dataStore setRecipe:recipe];
}
- (NSNumber*) getSugarPercentage
{
    return [[_dataStore getRecipe] valueForKey:@"sugar"];
}
- (void) setSugarPercentage:(NSNumber*) newSugar
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newSugar forKey:@"sugar"];
    [_dataStore setRecipe:recipe];
}
- (NSNumber*) getIcePercentage
{
    return [[_dataStore getRecipe] valueForKey:@"ice"];
}
- (void) setIcePercentage:(NSNumber*) newIce
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newIce forKey:@"ice"];
    [_dataStore setRecipe:recipe];
}
- (NSNumber*) getWaterPercentage
{
    return [[_dataStore getRecipe] valueForKey:@"water"];
}
- (void) setWaterPercentage:(NSNumber*) newWater
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newWater forKey:@"water"];
    [_dataStore setRecipe:recipe];
}

@end
