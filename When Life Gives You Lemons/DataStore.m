//
//  DataStore.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "DataStore.h"

@interface DataStore () {
    NSNumber* _price;
    Weather _weather;
    DayOfWeek _dayOfWeek;
    NSString* _feedbackString;
    NSMutableDictionary* _recipe;
    NSMutableDictionary* _inventory;
    NSMutableDictionary* _ingredientPrices;
    NSNumber* _popularity;
    NSNumber* _money;
    NSNumber* _profit;
    NSInteger _cupsSold;
}
@end

@implementation DataStore

-(id)init
{
    self = [super init];
    _price = [NSNumber numberWithFloat:.50];
    _weather = Sunny;
    _dayOfWeek = Saturday;
    _feedbackString = @"";
    _inventory = [[NSMutableDictionary alloc] initWithObjects:@[@0.00,     @0.00,    @0.00,  @0.00]
                                                      forKeys:@[@"lemons", @"sugar", @"ice", @"cups"]];
    _recipe = [[NSMutableDictionary alloc] initWithObjects:@[@0.00,     @0.00,    @0.00,  @1.00]
                                                   forKeys:@[@"lemons", @"sugar", @"ice", @"water"]];
    _ingredientPrices = [[NSMutableDictionary alloc] initWithObjects:@[@0.50,     @0.50,    @0.25,  @0.05]
                                                    forKeys:@[@"lemons", @"sugar", @"ice", @"cups"]];
    _popularity = 0;
    _money = [NSNumber numberWithFloat:20];
    
    return self;
}

// Price
-(NSNumber*) getPrice
{
    return _price;
}

-(void) setPrice:(NSNumber*) newPrice
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

// Popularity
-(NSNumber*) getPopularity
{
    return _popularity;
}

-(void) setPopularity:(NSNumber*) newPopularity
{
    _popularity = newPopularity;
}

// Money
-(NSNumber*) getMoney
{
    return _money;
}

-(void) setMoney:(NSNumber*) newMoney
{
    _money = newMoney;
}

-(NSNumber*) getProfit
{
    return _profit;
}

-(void) setProfit:(NSNumber*) newProfit
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
