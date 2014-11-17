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
    NSString* feedbackString = @"";
    NSNumber* money = [dataStore getMoney];
    
    // Get an array of customers.
    NSMutableArray *customers = [self getCustomersOnDay:dayOfWeek withWeather:weather
                                 andPopularity:popularity];
    int totalCustomers = (int) [customers count];
    int customersWhoBought = 0;
    int customersWhoLiked = 0;
    float grossEarnings = 0;
    
    // Calculate the maximum number of cups of lemonade that we can make.
    int maxCustomers = [self mostCupsMakableFromInventory:inventory withRecipe:recipe];
    
    bool ranOut = NO;
    
    if (maxCustomers > 0) {
    
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
    } else {
        feedbackString = @"You didn't have enough ingredients to make any lemonade!";
    }
    
    float portionWhoBought = ((float) customersWhoBought) / ((float) totalCustomers);
    float portionWhoLiked;
    // This prevents division by zero.
    if (portionWhoBought == 0) {
        portionWhoLiked = 0;
    } else {
        portionWhoLiked = ((float)customersWhoLiked) / ((float)customersWhoBought);
    }
    
    // Calculate new value for popularity.
    int newPopularity = [self calculateNewPopularityWithNumCustomers:totalCustomers
        portionBought:portionWhoBought portionLiked:portionWhoLiked fromOldPopularity:popularity];
    
    NSNumber* newMoney = [NSNumber numberWithFloat: [money floatValue] + grossEarnings];
    
    // If we haven't made the feedback string yet, make it based on what customers thought.
    // First, we check if anything is very far off, then we check if anything is slightly off.
    if ([feedbackString isEqual: @""]) {
        
        feedbackString = [self generateFeedbackFromRecipe:recipe];
        
        if (ranOut) {
            feedbackString = [NSString stringWithFormat:
               @"%@\nYou also ran out of ingredients!",
                              feedbackString];
        } else if ((float) customersWhoBought / (float) totalCustomers < .1) {
            feedbackString = [NSString stringWithFormat:
               @"%@\nUnfortunately, your lemonade was really expensive - no one bought it!",
                              feedbackString];
        } else if ((float) customersWhoBought / (float) totalCustomers < .3) {
            feedbackString = [NSString stringWithFormat:
               @"%@\nAlso, your lemonade was a bit expensive - not many customers bought it!",
                              feedbackString];
        }
    }
    [dataStore setPopularity:([NSNumber numberWithInt:newPopularity])];
    [dataStore setFeedbackString:(feedbackString)];
    [dataStore setInventory:inventory];
    [dataStore setMoney:newMoney];
    [dataStore setProfit:[NSNumber numberWithFloat:grossEarnings]];
    [dataStore setCupsSold:[NSNumber numberWithInt:customersWhoBought]];
    
    // A day passed, so change the day of the week and the weather.
    [dataStore setDayOfWeek:[self nextDayOfWeek:dayOfWeek]];
    [dataStore setWeather:[self nextWeather:weather]];
    
    // Update ingredient prices to reflect changing market conditions.
    [dataStore setIngredientPrices:[self generateRandomIngredientPrices]];
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
    float popularityMultiplier = ([popularity floatValue] / 100.0) + 1.0;
    totalCustomers = (int) (totalCustomers * popularityMultiplier);
    
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

- (int) mostCupsMakableFromInventory:(NSMutableDictionary*)inventory
              withRecipe:(NSMutableDictionary*) recipe {
    
    int maxCustomers = [(NSNumber*) [inventory valueForKey:@"cups"] intValue];
    for (NSString* key in [inventory allKeys]) {
        if (![key isEqual: @"cups"] && [[recipe valueForKey:key] floatValue] > 0.0) {
            int maxCupsWithThisIngredient = (int) ([(NSNumber*) [inventory valueForKey:key] floatValue]/
                                                   [(NSNumber*) [recipe valueForKey:key] floatValue]);
            if (maxCupsWithThisIngredient < maxCustomers) {
                maxCustomers = maxCupsWithThisIngredient;
            }
        }
    }
    return maxCustomers;
}

- (int) calculateNewPopularityWithNumCustomers:(int)totalCustomers
        portionBought:(float)portionWhoBought
        portionLiked:(float)portionWhoLiked
        fromOldPopularity:(NSNumber*)popularity {
    int newPopularity = [popularity intValue];
    // If enough people were unwilling to buy because of price, lose some popularity proportionally.
    newPopularity -= (int) ((1 - portionWhoBought) * 10);
    // If enough people didn't like it, lose some popularity proportionally.
    newPopularity -= (int) ((1 - portionWhoLiked) * 5);
    // Add some popularity for those who did like it.
    newPopularity += (int) (totalCustomers * portionWhoBought * portionWhoLiked);
    // If the resulting popularity is negative, set it to 0.
    if (newPopularity < 0) {
        newPopularity = 0;
    }
    return newPopularity;
}

- (NSMutableDictionary*) removeIngredientsOfRecipe:(NSMutableDictionary*)recipe
                         fromInventory:(NSMutableDictionary*)inventory {
    
    // Handle cups separately because they aren't part of the recipe.
    [inventory setValue: [NSNumber numberWithInt: [[inventory valueForKey:@"cups"]
                                                   intValue] - 1] forKey:@"cups"];
    
    // Loop through all other ingredients removing the appropriate amount.
    for (NSString* ingredient in [recipe allKeys]) {
        if (![ingredient isEqual: @"water"]) {
            float amountToRemove = [[recipe valueForKey:ingredient] floatValue];
            float oldAmount = [[inventory valueForKey:ingredient] floatValue];
            
            NSAssert(oldAmount >= amountToRemove,
                @"Tried to remove more ingredients than existed: %f from %f", amountToRemove, oldAmount);
            
            [inventory setValue:[NSNumber numberWithFloat:oldAmount - amountToRemove] forKey:ingredient];
        }
    }
    
    return inventory;
}

- (NSString*) generateFeedbackFromRecipe:(NSMutableDictionary*)recipe {
    
    NSString* feedbackString = @"";
    
    if ([ (NSNumber*)[recipe valueForKey:@"water"] floatValue] > .75) {
        feedbackString = @"Your lemonade was way too watery! Use more other ingredients.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"ice"] floatValue] > .35) {
        feedbackString = @"Your lemonade was freezing! You should use less ice.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"water"] floatValue] < .15) {
        feedbackString = @"Your lemonade was way too strong! Use some water in it.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"ice"] floatValue] < .05) {
        feedbackString = @"Your lemonade was way too warm! You need to use more ice.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"lemons"] floatValue] > .45) {
        feedbackString = @"Your lemonade was way too sour! Don't use too many lemons.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"lemons"] floatValue] < .1) {
        feedbackString = @"You need to use more lemons if you're going to sell lemonade!";
    } else if ([ (NSNumber*)[recipe valueForKey:@"sugar"] floatValue] > .35) {
        feedbackString = @"Your lemonade was way too sweet! You don't need to use so much sugar.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"sugar"] floatValue] < .05) {
        feedbackString = @"Your lemonade needs a lot more sugar!";
    }
    // At this point, we've checked for egregious errors.
    // Now we check for smaller mistakes.
    
    else if ([ (NSNumber*)[recipe valueForKey:@"water"] floatValue] > .65) {
        feedbackString = @"Your lemonade was too watery! Use more other ingredients.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"ice"] floatValue] > .2) {
        feedbackString = @"Your lemonade was a bit cold. You don't need so much ice.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"water"] floatValue] < .3) {
        feedbackString = @"Your lemonade was a little too strong. Water it down a little.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"ice"] floatValue] < .1) {
        feedbackString = @"Your lemonade was a bit warm. Add some ice.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"lemons"] floatValue] > .25) {
        feedbackString = @"Your lemonade was too sour for some of your customers. Use fewer lemons.";
    } else if ([ (NSNumber*)[recipe valueForKey:@"lemons"] floatValue] < .16) {
        feedbackString = @"Your lemonade isn't quite sour enough. Try using more lemons!";
    } else if ([ (NSNumber*)[recipe valueForKey:@"sugar"] floatValue] > .21) {
        feedbackString = @"Your lemonade was just a little too sweet. Try using less sugar!";
    } else if ([ (NSNumber*)[recipe valueForKey:@"sugar"] floatValue] < .12) {
        feedbackString = @"Your lemonade should be sweeter. Try adding some more sugar.";
    } else {
        feedbackString = @"Your lemonade was delicious!";
    }
    
    return feedbackString;
}

- (DayOfWeek) nextDayOfWeek:(DayOfWeek)currentDay {
    NSAssert(0 <= currentDay <= 6, @"Invalid day of week: %d", currentDay);
    if (currentDay < 6) {
        return currentDay + 1;
    } else {
        return 0;
    }
}

- (Weather) nextWeather:(Weather)currentWeather {
    
    // Get a random number to determne tomorrow's weather.
    float randomValue = drand48();
    
    if (currentWeather == Sunny) {
        if (randomValue < .5) {
            return Sunny;
        } else if (randomValue < .75) {
            return Cloudy;
        } else {
            return Raining;
        }
    } else if (currentWeather == Cloudy) {
        if (randomValue < .6) {
            return Sunny;
        } else if (randomValue < .8) {
            return Cloudy;
        } else {
            return Raining;
        }
    } else if (currentWeather == Raining) {
        if (randomValue < .6) {
            return Sunny;
        } else if (randomValue < .9) {
            return Cloudy;
        } else {
            return Raining;
        }
    } else {
        [NSException raise:@"Invalid weather value" format:@"Weather %d is invalid", currentWeather];
        // Return should never be reached.
        return Sunny;
    }
}

- (NSMutableDictionary*) generateRandomIngredientPrices {
    NSMutableDictionary* newPrices = [[NSMutableDictionary alloc] init];
    
    NSNumber* newLemonsPrice =
            [NSNumber numberWithFloat: .5 + .05 * [self randomNumberAtLeast:0 andAtMost:10]];
    [newPrices setValue:newLemonsPrice forKey:@"lemons"];
    
    NSNumber* newSugarPrice =
            [NSNumber numberWithFloat: .5 + .05 * [self randomNumberAtLeast:0 andAtMost:10]];
    [newPrices setValue:newSugarPrice forKey:@"sugar"];
    
    NSNumber* newIcePrice =
            [NSNumber numberWithFloat: .25 + .05 * [self randomNumberAtLeast:0 andAtMost:5]];
    [newPrices setValue:newIcePrice forKey:@"ice"];
    
    NSNumber* newCupsPrice =
            [NSNumber numberWithFloat: .05 + .01 * [self randomNumberAtLeast:0 andAtMost:10]];
    [newPrices setValue:newCupsPrice forKey:@"cups"];
    
    return newPrices;
}

@end

