//
//  Model.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "Model.h"
#import "Customer.h"

@implementation Model

- (DataStore*) simulateDayWithDataStore:(DataStore*)dataStore {
    
    DayOfWeek dayOfWeek = [dataStore getDayOfWeek];
    Weather weather = [dataStore getWeather];
    NSMutableDictionary* recipe = [dataStore getRecipe];
    NSNumber* price = [dataStore getPrice];
    NSNumber* popularity = [dataStore getPopularity];
    NSMutableDictionary* inventory = [dataStore getInventory];
    
    NSMutableArray *customers = [self getCustomersOnDay:dayOfWeek withWeather:weather
                                 andPopularity:popularity];
    int totalCustomers = [customers count];
    int customersWhoBought = 0;
    int customersWhoLiked = 0;
    float grossEarnings = 0;
    
    // Calculate the maximum number of cups of lemonade that we can make.
    int maxCustomers = [(NSNumber*) [inventory valueForKey:@"cups"] intValue];
    for (NSString* key in [inventory allKeys]) {
        if (![key isEqual: @"cups"]) {
            int maxCupsWithThisIngredient = (int) ([(NSNumber*) [inventory valueForKey:key] floatValue]/
                                                   [(NSNumber*) [recipe valueForKey:key] floatValue]);
            if (maxCupsWithThisIngredient < maxCustomers) {
                maxCustomers = maxCupsWithThisIngredient;
            }
        }
    }
    
    bool ranOut = NO;
    
    for (Customer *customer in customers) {
        if ([customer willBuyAtPrice:price]) {
            ++customersWhoBought;
            grossEarnings += [price floatValue];
            
            // Check if they like the recipe.
            if ([customer likesRecipe:recipe]) {
                ++customersWhoLiked;
            }
            
            // Remove ingredients.
            inventory = [self removeIngredientsOfRecipe:recipe fromInventory:inventory];
            
            if (customersWhoBought == maxCustomers) {
                ranOut = YES;
                break;
            }
        }
    }
    int newPopularity = [popularity integerValue] + customersWhoBought;
    float percentWhoBought = ((float) customersWhoBought) / ((float) totalCustomers);
    float percentWhoLiked;
    if (percentWhoBought == 0) {
        percentWhoLiked = 0;
    } else {
        percentWhoLiked = ((float)customersWhoLiked) / ((float)customersWhoBought);
    }
    
    // TODO: modify the datastore to account for day's earnings.
    // This feature will not be in the alpha.
    
    // TODO: return percents of customers who bought and liked the lemonade.
    // This probably also won't be in the alpha.
    
    
    
    NSString *feedbackString;
    
    if ([ (NSNumber*)[recipe valueForKey:@"water"] floatValue] > .65) {
        feedbackString = @"Your lemonade was too watery! Use more other ingredients.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"water"] floatValue] < .25) {
        feedbackString = @"Your lemonade was too strong! Water it down a little.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"ice"] floatValue] < .1) {
        feedbackString = @"Your lemonade was warm! Add some ice.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"ice"] floatValue] > .25) {
        feedbackString = @"Your lemonade was freezing! You don't need so much ice.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"lemons"] floatValue] > .3) {
        feedbackString = @"Your lemonade was really sour! Don't use so many lemons.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"lemons"] floatValue] < .1) {
        feedbackString = @"You need to use more lemons if you're going to sell lemonade!";
    } else if ([ (NSNumber*)[recipe valueForKey:@"sugar"] floatValue] > .3) {
        feedbackString = @"Your lemonade was too sweet! You don't need to use so much sugar.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"sugar"] floatValue] < .1) {
        feedbackString = @"Your lemonade needs to be sweeter! Try adding more sugar.";
    } else {
        feedbackString = @"Your customers loved your lemonade!";
    }
    
    if (ranOut) {
        feedbackString = [NSString stringWithFormat:
                          @"%@ You also ran out of ingredients!", feedbackString];
    }
    [dataStore setPopularity:([NSNumber numberWithInt:newPopularity])];
    [dataStore setFeedbackString:(feedbackString)];
    [dataStore setInventory:inventory];
    // TODO: return total amount of ingredients used.
    
    
    return dataStore;
    
}


- (int) randomNumberAtLeast:(int)lowerBound andAtMost:(int)upperBound {
    NSAssert(upperBound >= lowerBound, @"Invalid bounds in randomNumberAtLeast:andAtMost:");
    
    return lowerBound + (arc4random() % (1 + upperBound - lowerBound));
}

- (NSMutableArray*) getCustomersOnDay:(DayOfWeek)dayOfWeek withWeather:(Weather)weather
                    andPopularity:(NSNumber*)popularity {
    
    int baseCustomers = [self randomNumberAtLeast:20 andAtMost:25];
    int customersFromWeather = [self customersFromWeather:weather];
    int customersFromWeekday = [self customersFromWeekday:dayOfWeek];
    
    int totalCustomers = baseCustomers + customersFromWeather + customersFromWeekday;
    int popularityMultiplier = ([popularity floatValue] / 100.0) + 1;
    totalCustomers = (int) totalCustomers * popularityMultiplier;
    
    NSMutableArray *customers = [[NSMutableArray alloc] initWithCapacity:totalCustomers];
    
    for (int i = 0; i < totalCustomers; ++i) {
        Customer* nextCustomer = [self getOneCustomerForWeather:weather];
        [customers addObject:nextCustomer];
    }
    
    return customers;
}

- (int) customersFromWeather:(Weather)weather {
    
    if (weather == Sunny) {
        return [self randomNumberAtLeast:10 andAtMost:20];
    } else if (weather == Cloudy) {
        return [self randomNumberAtLeast:5 andAtMost:10];
    } else if (weather == Raining) {
        return 0;
    } else {
        [NSException raise:@"Invalid weather" format:@"Weather %d is invalid", weather];
        return 0;
    }
}

- (int) customersFromWeekday:(DayOfWeek)dayOfWeek {
    
    if (dayOfWeek == Saturday || dayOfWeek == Sunday) {
        return [self randomNumberAtLeast:15 andAtMost:20];
    } else if (dayOfWeek == Monday ||
               dayOfWeek == Tuesday ||
               dayOfWeek == Wednesday ||
               dayOfWeek == Thursday ||
               dayOfWeek == Friday) {
        return [self randomNumberAtLeast:0 andAtMost:5];
    } else {
        [NSException raise:@"Invalid day of week" format:@"day of week %d is invalid", dayOfWeek];
        return 0;
    }
}

- (Customer*) getOneCustomerForWeather:(Weather)weather {
    // For now, does not actually base this on the weather.
    int randomValue = arc4random() % 6;
    Customer* customer = [[Customer alloc] init];
    [customer setCustomerType:randomValue];
    return customer;
}

- (NSMutableDictionary*) removeIngredientsOfRecipe:(NSMutableDictionary*)recipe
                        fromInventory:(NSMutableDictionary*)inventory {
    
    // Handle cups separately because they aren't part of the recipe.
    [inventory setValue: [NSNumber numberWithInt: [[inventory valueForKey:@"cups"]
                                                   integerValue] - 1] forKey:@"cups"];
    
    // Loop through all other ingredients removing the appropriate amount.
    for (NSString* ingredient in [recipe allKeys]) {
        if (![ingredient isEqual: @"Water"]) {
            float amountToRemove = [[recipe valueForKey:ingredient] floatValue];
            float oldAmount = [[inventory valueForKey:ingredient] floatValue];
            
            NSAssert(oldAmount > amountToRemove, @"Tried to remove more ingredients than existed.");
            
            [inventory setValue:[NSNumber numberWithFloat:oldAmount - amountToRemove] forKey:ingredient];
        }
    }
    
    return inventory;
}

@end

