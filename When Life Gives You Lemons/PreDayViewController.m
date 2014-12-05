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
#import "PreDayInfoView.h"
#import "PreDayBadgesView.h"

@interface PreDayViewController (){
    DataStore* _dataStore;
    PreDayInventoryView* _inventoryView;
    PreDayRecipeView* _recipeView;
    PreDayInfoView* _infoView;
    PreDayBadgesView* _badgesView;
}
@end

@implementation PreDayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create frame for additional views
    CGFloat header = 90;
    CGFloat footer = 90;
    CGRect allViewsFrame = CGRectMake(0, header, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - header - footer);
    
    // Create the Info View
    _infoView = [[PreDayInfoView alloc] initWithFrame:allViewsFrame];
    [self.view addSubview:_infoView];
    [_infoView setDelegate:self];
    [_infoView updatePriceLabel];
    [_infoView updateWeather];
    [_infoView updateDayLabel];
    [_infoView updateMakeableCupsLabel];
    
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
    
    // Create the Achievements View
    _badgesView = [[PreDayBadgesView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) andBadges:[_dataStore getBadges]];
    [_badgesView setHidden:YES];
    [self.view addSubview:_badgesView];
}

- (void) setDataStore:(DataStore*) dataStore
{
    _dataStore = dataStore;
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
    [_infoView updateMakeableCupsLabel];
}

- (IBAction)displayBadges:(id)sender
{
    [_badgesView setHidden:NO];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    [self.view bringSubviewToFront:_badgesView];
}

- (IBAction)unwindToPreDay:(UIStoryboardSegue*)unwindSegue
{
    [_infoView updatePriceLabel];
    [_infoView updateWeather];
    [_infoView updateDayLabel];
    [_infoView updateMakeableCupsLabel];
    
    [_inventoryView setHidden:YES];
    [_inventoryView updateAmountLabels];
    [_inventoryView updateMoneyLabel];
    [_inventoryView updatePriceLabels];
    
    [_recipeView setHidden:YES];
    [_recipeView updatePercentageLabels];
    
    [_badgesView setHidden:YES];
    [_badgesView updateAllBadgeBackgrounds:[_dataStore getBadges]];
}

- (NumberWithTwoDecimals*) getPrice
{
    return [_dataStore getPrice];
}

- (Weather) getWeather
{
    return [_dataStore getWeather];
}

- (void) decrementPrice:(id)sender
{
    if ([[_dataStore getPrice] isGreaterThan:[[NumberWithTwoDecimals alloc] initWithFloat:0.0]]) {
        [_dataStore setPrice:[[_dataStore getPrice] subtract:[[NumberWithTwoDecimals alloc] initWithFloat:0.1]]];
    }
}

- (void) incrementPrice:(id)sender
{
    [_dataStore setPrice:[[_dataStore getPrice] add:[[NumberWithTwoDecimals alloc] initWithFloat:0.1]]];
}

- (NumberWithTwoDecimals*) getLemons
{
    return [[_dataStore getInventory] valueForKey:@"lemons"];
}

- (void) setLemons:(NumberWithTwoDecimals*) newLemons
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newLemons forKey:@"lemons"];
    [_dataStore setInventory:inventory];
}

- (NumberWithTwoDecimals*) getSugar
{
    return [[_dataStore getInventory] valueForKey:@"sugar"];
}

- (void) setSugar:(NumberWithTwoDecimals*) newSugar
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newSugar forKey:@"sugar"];
    [_dataStore setInventory:inventory];
}

- (NumberWithTwoDecimals*) getIce
{
    return [[_dataStore getInventory] valueForKey:@"ice"];
}

- (void) setIce:(NumberWithTwoDecimals*) newIce
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newIce forKey:@"ice"];
    [_dataStore setInventory:inventory];
}

- (NumberWithTwoDecimals*) getCups
{
    return [[_dataStore getInventory] valueForKey:@"cups"];
}

- (void) setCups:(NumberWithTwoDecimals*) newCups
{
    NSMutableDictionary* inventory = [_dataStore getInventory];
    [inventory setValue:newCups forKey:@"cups"];
    [_dataStore setInventory:inventory];
}

- (NumberWithTwoDecimals*) getMoney
{
    return [_dataStore getMoney];
}

- (void) setMoney:(NumberWithTwoDecimals*) newMoney
{
    [_dataStore setMoney:newMoney];
}

- (NumberWithTwoDecimals*) getLemonPrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"lemons"];
}

- (NumberWithTwoDecimals*) getSugarPrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"sugar"];
}

- (NumberWithTwoDecimals*) getIcePrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"ice"];
}

- (NumberWithTwoDecimals*) getCupsPrice
{
    return [[_dataStore getIngredientPrices] valueForKey:@"cups"];
}

- (NumberWithTwoDecimals*) getLemonsPercentage
{
    return [[_dataStore getRecipe] valueForKey:@"lemons"];
}

- (void) setLemonsPercentage:(NumberWithTwoDecimals*) newLemons
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newLemons forKey:@"lemons"];
    [_dataStore setRecipe:recipe];
}

- (NumberWithTwoDecimals*) getSugarPercentage
{
    return [[_dataStore getRecipe] valueForKey:@"sugar"];
}

- (void) setSugarPercentage:(NumberWithTwoDecimals*) newSugar
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newSugar forKey:@"sugar"];
    [_dataStore setRecipe:recipe];
}

- (NumberWithTwoDecimals*) getIcePercentage
{
    return [[_dataStore getRecipe] valueForKey:@"ice"];
}

- (void) setIcePercentage:(NumberWithTwoDecimals*) newIce
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newIce forKey:@"ice"];
    [_dataStore setRecipe:recipe];
}

- (NumberWithTwoDecimals*) getWaterPercentage
{
    return [[_dataStore getRecipe] valueForKey:@"water"];
}

- (void) setWaterPercentage:(NumberWithTwoDecimals*) newWater
{
    NSMutableDictionary* recipe = [_dataStore getRecipe];
    [recipe setValue:newWater forKey:@"water"];
    [_dataStore setRecipe:recipe];
}

- (NSInteger) getMakableCups
{
    NSDictionary* inventory = [_dataStore getInventory];
    NSDictionary* recipe = [_dataStore getRecipe];
    
    int maxCustomers = [[inventory valueForKey:@"cups"] integerPart];
    for (NSString* key in [inventory allKeys]) {
        if (![key isEqual: @"cups"] &&
            [[recipe valueForKey:key] isGreaterThan:[[NumberWithTwoDecimals alloc] initWithFloat:0.0]]) {
            int maxCupsWithThisIngredient = (int) ([[inventory valueForKey:key] floatValue]/
                                                   [[recipe valueForKey:key] floatValue]);
            if (maxCupsWithThisIngredient < maxCustomers) {
                maxCustomers = maxCupsWithThisIngredient;
            }
        }
    }
    NSAssert(maxCustomers >= 0, @"Maximum number of customers is negative (%d)", maxCustomers);
    return maxCustomers;
}

- (DayOfWeek) getDayOfWeek
{
    return [_dataStore getDayOfWeek];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PreDayToMidDay"])
    {
        // Get reference to the destination view controller
        MidDayViewController* midDayViewController = [segue destinationViewController];
        
        // Pass dataStore to the view controller
        [midDayViewController setDataStore:_dataStore];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
