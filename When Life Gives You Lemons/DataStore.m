//
//  DataStore.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "DataStore.h"
#import "Badges.h"

@interface DataStore () {
    NumberWithTwoDecimals* _price;
    Weather _weather;
    DayOfWeek _dayOfWeek;
    NSString* _feedbackString;
    NSMutableDictionary* _recipe;
    NSMutableDictionary* _inventory;
    NSMutableDictionary* _ingredientPrices;
    NSMutableDictionary* _badgeDictionary;
    NSMutableDictionary* _bestAmountsForWeathers;
    NSMutableSet* _feedbackSet;
    NSInteger _popularity;
    NumberWithTwoDecimals* _money;
    NumberWithTwoDecimals* _profit;
    NSInteger _cupsSold;
    // for achievementS
    NSInteger _daysOfPerfectLemonade;
    NSInteger _totalCupsSold;
    NumberWithTwoDecimals* _totalEarnings;
    bool _newBadge;
}
@end

@implementation DataStore

-(id)init
{
    self = [super init];
    _price = [[NumberWithTwoDecimals alloc] initWithFloat:.50];
    _weather = Sunny;
    _dayOfWeek = Saturday;
    _feedbackString = @"";
    [self initInventory];
    [self initRecipe];
    [self initPrices];
    [self initBadges];
    [self initBestAmountsForWeathers];
    _feedbackSet = [[NSMutableSet alloc] init];
    _popularity = 0;
    _money = [[NumberWithTwoDecimals alloc] initWithFloat:20];
    _daysOfPerfectLemonade = 0;
    _totalCupsSold = 0;
    _totalEarnings = [[NumberWithTwoDecimals alloc] initWithFloat:0];
    _newBadge = NO;
    
    return self;
}

-(void) initInventory
{
    _inventory = [[NSMutableDictionary alloc] init];
    [_inventory setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"lemons"];
    [_inventory setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"sugar"];
    [_inventory setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"ice"];
    [_inventory setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"cups"];
}

-(void) initRecipe
{
    _recipe = [[NSMutableDictionary alloc] init];
    [_recipe setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"lemons"];
    [_recipe setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"sugar"];
    [_recipe setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.00] forKey:@"ice"];
    [_recipe setValue:[[NumberWithTwoDecimals alloc] initWithFloat:1.00] forKey:@"water"];
}

-(void) initPrices
{
    _ingredientPrices = [[NSMutableDictionary alloc] init];
    [_ingredientPrices setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.50] forKey:@"lemons"];
    [_ingredientPrices setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.50] forKey:@"sugar"];
    [_ingredientPrices setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.25] forKey:@"ice"];
    [_ingredientPrices setValue:[[NumberWithTwoDecimals alloc] initWithFloat:0.05] forKey:@"cups"];
}

-(void) initBadges
{
    _badgeDictionary = [[NSMutableDictionary alloc] init];
    for (NSString* badge in [Badges badgeArray]) {
        [_badgeDictionary setValue:@0 forKey:badge];
    }
    
}

-(void) initBestAmountsForWeathers
{
    _bestAmountsForWeathers = [[NSMutableDictionary alloc] init];
    [_bestAmountsForWeathers setValue:@0 forKey:@"Sunny"];
    [_bestAmountsForWeathers setValue:@0 forKey:@"Cloudy"];
    [_bestAmountsForWeathers setValue:@0 forKey:@"Raining"];
    
}

// Price
-(NumberWithTwoDecimals*) getPrice
{
    return _price;
}

-(void) setPrice:(NumberWithTwoDecimals*) newPrice
{
    _price = newPrice;
}

// Weather
- (Weather) getWeather
{
    return _weather;
}
- (void) setWeather:(Weather) newWeather
{
    _weather = newWeather;
}

// Day of week
- (DayOfWeek) getDayOfWeek
{
    return _dayOfWeek;
}
- (void) setDayOfWeek:(DayOfWeek) newDayOfWeek
{
    _dayOfWeek = newDayOfWeek;
}

// Feedback string
-(NSString*) getFeedbackString
{
    return _feedbackString;
}

-(void) setFeedbackString:(NSString*) newFeedbackString
{
    _feedbackString = newFeedbackString;
}

// Recipe
-(NSMutableDictionary*) getRecipe
{
    return _recipe;
}

-(void) setRecipe:(NSMutableDictionary*) newRecipe
{
    _recipe = newRecipe;
}

// Inventory
-(NSMutableDictionary*) getInventory
{
    return _inventory;
}

-(void) setInventory:(NSMutableDictionary*) newInventory
{
    _inventory = newInventory;
}

// Ingredient Prices
-(NSMutableDictionary*) getIngredientPrices
{
    return _ingredientPrices;
}

-(void) setIngredientPrices:(NSMutableDictionary *)newIngredientPrices
{
    _ingredientPrices = newIngredientPrices;
}

// Achievements
-(NSMutableDictionary*) getBadges
{
    return _badgeDictionary;
}

-(void) setBadges:(NSMutableDictionary *)newBadges
{
    _badgeDictionary = newBadges;
}

// Best amount for each weather
-(NSMutableDictionary*) getBestAmountsForWeathers
{
    return _bestAmountsForWeathers;
}

-(void) setBestAmountsForWeathers:(NSMutableDictionary *)newBestAmounts
{
    _bestAmountsForWeathers = newBestAmounts;
}

// Feedbacks that have been gotten so far
-(NSMutableSet*) getFeedbackSet
{
    return _feedbackSet;
}

-(void) setFeedbackSet:(NSMutableSet*)newFeedbackSet
{
    _feedbackSet = newFeedbackSet;
}

// Popularity
-(NSInteger) getPopularity
{
    return _popularity;
}

-(void) setPopularity:(NSInteger) newPopularity
{
    _popularity = newPopularity;
}

// Money
-(NumberWithTwoDecimals*) getMoney
{
    return _money;
}

-(void) setMoney:(NumberWithTwoDecimals*) newMoney
{
    _money = newMoney;
}

-(NumberWithTwoDecimals*) getProfit
{
    return _profit;
}

-(void) setProfit:(NumberWithTwoDecimals*) newProfit
{
    _profit = newProfit;
}

-(NSInteger) getCupsSold
{
    return _cupsSold;
}

-(void) setCupsSold:(NSInteger) newCupsSold
{
    _cupsSold = newCupsSold;
}

-(void) initWithDictionary:(NSDictionary*) inputDictionary
{
    NumberWithTwoDecimals *newPrice = [[NumberWithTwoDecimals alloc] initWithFloat:[[inputDictionary valueForKey:@"price"] floatValue]];
    
    NSMutableDictionary *convertedRecipe = [[NSMutableDictionary alloc] init];
    for (NSString* ingredient in [_recipe allKeys]) {
        NumberWithTwoDecimals *newNumber = [[NumberWithTwoDecimals alloc]
                                           initWithFloat:[[[inputDictionary valueForKey:@"recipe"] valueForKey:ingredient] floatValue]];
        [convertedRecipe setObject:newNumber forKey:ingredient];
    }
    
    NSMutableDictionary *convertedInventory = [[NSMutableDictionary alloc] init];
    for (NSString* ingredient in [_inventory allKeys]) {
        NumberWithTwoDecimals *newNumber = [[NumberWithTwoDecimals alloc]
                                            initWithFloat:[[[inputDictionary valueForKey:@"inventory"] valueForKey:ingredient] floatValue]];
        [convertedInventory setObject:newNumber forKey:ingredient];
    }
    
    NSMutableDictionary *convertedIngredientPrices = [[NSMutableDictionary alloc] init];
    for (NSString* ingredient in [_ingredientPrices allKeys]) {
        NumberWithTwoDecimals *newNumber = [[NumberWithTwoDecimals alloc]
                                            initWithFloat:[[[inputDictionary valueForKey:@"ingredient prices"] valueForKey:ingredient] floatValue]];
        [convertedIngredientPrices setObject:newNumber forKey:ingredient];
    }
    
    NumberWithTwoDecimals *newMoney = [[NumberWithTwoDecimals alloc] initWithFloat:[[inputDictionary valueForKey:@"money"] floatValue]];
    
    NumberWithTwoDecimals *newProfit = [[NumberWithTwoDecimals alloc] initWithFloat:[[inputDictionary valueForKey:@"profit"] floatValue]];
    
    NSMutableSet *newFeedbackSet = [[NSMutableSet alloc] init];
    for (NSString* feedback in [inputDictionary valueForKey:@"feedback set"]) {
        [newFeedbackSet addObject:feedback];
    }
    
    NumberWithTwoDecimals *newTotalEarnings = [[NumberWithTwoDecimals alloc] initWithFloat:[[inputDictionary valueForKey:@"total earnings"] floatValue]];
    
    _price = newPrice;
    _weather = (Weather) [[inputDictionary valueForKey:@"weather"] intValue];
    _dayOfWeek = (DayOfWeek) [[inputDictionary valueForKey:@"day of week"] intValue];
    _feedbackString = [inputDictionary valueForKey:@"feedback String"];
    _recipe = convertedRecipe;
    _inventory = convertedInventory;
    _ingredientPrices = convertedIngredientPrices;
    _badgeDictionary = [NSMutableDictionary dictionaryWithDictionary:[inputDictionary valueForKey:@"badges"]];
    _cupsSold = [[inputDictionary valueForKey:@"cups sold"] integerValue];
    _feedbackSet = newFeedbackSet;
    _popularity = [[inputDictionary valueForKey:@"popularity"] integerValue];
    _money = newMoney;
    _profit = newProfit;
    _cupsSold = [[inputDictionary valueForKey:@"price"] integerValue];
    _daysOfPerfectLemonade = [[inputDictionary valueForKey:@"perf days"] integerValue];
    _totalCupsSold = [[inputDictionary valueForKey:@"total cups sold"] integerValue];
    _totalEarnings = newTotalEarnings;
    _bestAmountsForWeathers = [NSMutableDictionary dictionaryWithDictionary:[inputDictionary valueForKey:@"best amounts for weathers"]];
}

-(NSInteger) getDaysOfPerfectLemonade
{
    return _daysOfPerfectLemonade;
}
    
-(void) setDaysOfPerfectLemonade:(NSInteger) newDays
{
    _daysOfPerfectLemonade = newDays;
}

-(NSDictionary*) convertToDictionary
{
    NSMutableDictionary *returnDictionary = [[NSMutableDictionary alloc] init];
    
    float convertedPriceFloat = [_price floatValue];
    NSNumber *convertedPriceNumber = [NSNumber numberWithFloat:convertedPriceFloat];
    
    float convertedMoneyFloat = [_money floatValue];
    NSNumber *convertedMoneyNumber = [NSNumber numberWithFloat:convertedMoneyFloat];
    
    float convertedProfitFloat = [_profit floatValue];
    NSNumber *convertedProfitNumber = [NSNumber numberWithFloat:convertedProfitFloat];
    
    float convertedEarningsFloat = [_profit floatValue];
    NSNumber *convertedEarningsNumber = [NSNumber numberWithFloat:convertedEarningsFloat];
    
    NSMutableDictionary *convertedRecipe = [[NSMutableDictionary alloc] init];
    for (NSString* ingredient in [_recipe allKeys]) {
        [convertedRecipe setObject:[NSNumber numberWithFloat:[[_recipe valueForKey:ingredient] floatValue]] forKey:ingredient];
    }
    
    NSMutableDictionary *convertedInventory = [[NSMutableDictionary alloc] init];
    for (NSString* ingredient in [_inventory allKeys]) {
        [convertedInventory setObject:[NSNumber numberWithFloat:[[_inventory valueForKey:ingredient] floatValue]] forKey:ingredient];
    }
    
    NSMutableDictionary *convertedIngredientPrices = [[NSMutableDictionary alloc] init];
    for (NSString* ingredient in [_ingredientPrices allKeys]) {
        [convertedIngredientPrices setObject:[NSNumber numberWithFloat:[[_ingredientPrices valueForKey:ingredient] floatValue]] forKey:ingredient];
    }
    
    NSMutableArray *feedbackArray = [[NSMutableArray alloc] init];
    for (NSString* feedback in _feedbackSet) {
        [feedbackArray addObject:feedback];
    }
    
    [returnDictionary setObject:convertedPriceNumber forKey:@"price"];
    [returnDictionary setObject:[NSNumber numberWithInt:_weather] forKey:@"weather"];
    [returnDictionary setObject:[NSNumber numberWithInt:_dayOfWeek] forKey:@"day of week"];
    [returnDictionary setObject:_feedbackString forKey:@"feedback string"];
    [returnDictionary setObject:convertedRecipe forKey:@"recipe"];
    [returnDictionary setObject:convertedInventory forKey:@"inventory"];
    [returnDictionary setObject:convertedIngredientPrices forKey:@"ingredient prices"];
    [returnDictionary setObject:_badgeDictionary forKey:@"badges"];
    [returnDictionary setObject:feedbackArray forKey:@"feedback set"];
    [returnDictionary setObject:[NSNumber numberWithInteger:_popularity] forKey:@"popularity"];
    [returnDictionary setObject:[NSNumber numberWithInteger:_cupsSold] forKey:@"cups sold"];
    [returnDictionary setObject:[NSNumber numberWithInteger:_daysOfPerfectLemonade] forKey:@"perf days"];
    [returnDictionary setObject:[NSNumber numberWithInteger:_totalCupsSold] forKey:@"total cups sold"];
    [returnDictionary setObject:convertedMoneyNumber forKey:@"money"];
    [returnDictionary setObject:convertedProfitNumber forKey:@"profit"];
    [returnDictionary setObject:[NSNumber numberWithInteger:_cupsSold] forKey:@"cups sold"];
    [returnDictionary setObject:convertedEarningsNumber forKey:@"total earnings"];
    [returnDictionary setObject:_bestAmountsForWeathers forKey:@"best amounts for weathers"];
    
    return [NSDictionary dictionaryWithDictionary:returnDictionary];
}

-(NSInteger) getTotalCupsSold
{
    return _totalCupsSold;
}

-(void) setTotalCupsSold:(NSInteger) newCups
{
    _totalCupsSold = newCups;
}

-(NumberWithTwoDecimals*) getTotalEarnings
{
    return _totalEarnings;
}

-(void) setTotalEarnings:(NumberWithTwoDecimals *)newTotal
{
    _totalEarnings = newTotal;
}

-(bool) getNewBadge
{
    return _newBadge;
}

-(void) setNewBadge:(bool)newBadge
{
    _newBadge = newBadge;
}

@end
