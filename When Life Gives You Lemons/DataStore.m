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
    NSMutableSet* _feedbackSet;
    NSInteger _popularity;
    NumberWithTwoDecimals* _money;
    NumberWithTwoDecimals* _profit;
    NSInteger _cupsSold;
    // for achievementS
    NSInteger _daysOfPerfectLemonade;
    NSInteger _totalCupsSold;
    NumberWithTwoDecimals* _totalEarnings;
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
    _feedbackSet = [[NSMutableSet alloc] init];
    _popularity = 0;
    _money = [[NumberWithTwoDecimals alloc] initWithFloat:20];
    _daysOfPerfectLemonade = 0;
    _totalCupsSold = 0;
    _totalEarnings = [[NumberWithTwoDecimals alloc] initWithFloat:0];
    
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
    _price = [inputDictionary valueForKey:@"price"];
    _weather = (Weather) [[inputDictionary valueForKey:@"weather"] intValue];
    _dayOfWeek = (DayOfWeek) [[inputDictionary valueForKey:@"day of week"] intValue];
    _feedbackString = [inputDictionary valueForKey:@"feedback String"];
    _recipe = [inputDictionary valueForKey:@"recipe"];
    _inventory = [inputDictionary valueForKey:@"inventory"];
    _ingredientPrices = [inputDictionary valueForKey:@"ingredient prices"];
    _popularity = [inputDictionary valueForKey:@"popularity"];
    _money = [inputDictionary valueForKey:@"money"];
    _profit = [inputDictionary valueForKey:@"profit"];
    _cupsSold = [[inputDictionary valueForKey:@"price"] integerValue];

}

-(NSDictionary*) convertToDictionary
{
    NSMutableDictionary *returnDictionary = [[NSMutableDictionary alloc] init];
    
    [returnDictionary setObject:_price forKey:@"price"];
    [returnDictionary setObject:[NSNumber numberWithInt:_weather] forKey:@"weather"];
    [returnDictionary setObject:[NSNumber numberWithInt:_dayOfWeek] forKey:@"day of week"];
    [returnDictionary setObject:_feedbackString forKey:@"feedback string"];
    [returnDictionary setObject:_recipe forKey:@"recipe"];
    [returnDictionary setObject:_inventory forKey:@"inventory"];
    [returnDictionary setObject:_ingredientPrices forKey:@"ingredient prices"];
    [returnDictionary setObject:_popularity forKey:@"popularity"];
    [returnDictionary setObject:_money forKey:@"money"];
    [returnDictionary setObject:_profit forKey:@"profit"];
    [returnDictionary setObject:[NSNumber numberWithInteger:_cupsSold] forKey:@"cups sold"];
    
    return [NSDictionary dictionaryWithDictionary:returnDictionary];
}

@end
