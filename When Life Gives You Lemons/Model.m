//
//  Model.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "Model.h"

@implementation Model

- (NSMutableDictionary*) simulateDayOnDay:(NSString*)dayOfWeek withWeather:(NSString*)weather forRecipe:(NSDictionary*)recipe andPrice:(NSNumber*)price andPopularity:(NSNumber*)popularity {
    
    NSAssert([weather isEqual:@"hot"] ||
             [weather isEqual:@"cloudy"] ||
             [weather isEqual:@"cold"], @"Invalid weather type");
    
    NSAssert([dayOfWeek isEqual:@"monday"] ||
             [dayOfWeek isEqual:@"tuesday"] ||
             [dayOfWeek isEqual:@"wednesday"] ||
             [dayOfWeek isEqual:@"thursday"] ||
             [dayOfWeek isEqual:@"friday"] ||
             [dayOfWeek isEqual:@"saturday"] ||
             [dayOfWeek isEqual:@"sunday"] , @"Invalid day of week");
    
    
    NSMutableArray *customers = [self getCustomersOnDay:dayOfWeek withWeather:weather
                                 andPopularity:popularity];
    int totalCustomers = [customers count];
    int customersWhoBought = 0;
    int customersWhoLiked = 0;
    float grossEarnings = 0;
    
    for (Customer *customer in customers) {
        if ([customer willBuyAtPrice:price]) {
            ++customersWhoBought;
            grossEarnings += [price floatValue];
            
            if ([customer likesRecipe:recipe]) {
                ++customersWhoLiked;
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
    
    NSMutableDictionary *returnDictionary = [[NSMutableDictionary alloc] init];
    [returnDictionary setObject:[NSNumber numberWithFloat:grossEarnings] forKey:@"earnings"];
    [returnDictionary setObject:[NSNumber numberWithInt:newPopularity] forKey:@"popularity"];
    [returnDictionary setObject:[NSNumber numberWithFloat:percentWhoBought] forKey:@"percentBought"];
    [returnDictionary setObject:[NSNumber numberWithFloat:percentWhoLiked] forKey:@"percentLiked"];
    
    
    // TODO: return customer feedback based on which customer types didn't like the lemonade.
    // TODO: return total amount of ingredients used.
    
    
    return returnDictionary;
    
}


- (int) randomNumberAtLeast:(int)lowerBound andAtMost:(int)upperBound {
    NSAssert(upperBound >= lowerBound, @"Invalid bounds in randomNumberAtLeast:andAtMost:");
    
    return lowerBound + (arc4random() % (1 + upperBound - lowerBound));
}

- (NSMutableArray*) getCustomersOnDay:(NSString*)dayOfWeek withWeather:(NSString*)weather
                    andPopularity:(NSNumber*)popularity {
    
    int baseCustomers = [self randomNumberAtLeast:20 andAtMost:25];
    int customersFromWeather = [self customersFromWeather:weather];
    int customersFromWeekday = [self customersFromWeather:dayOfWeek];
    
    int totalCustomers = baseCustomers + customersFromWeather + customersFromWeekday;
    int popularityMultiplier = ([popularity floatValue] / 100.0) + 1;
    totalCustomers = (int) totalCustomers * popularityMultiplier;
    
    NSMutableArray *customers = [[NSMutableArray alloc] initWithCapacity:totalCustomers];
    
    for (int i = 0; i < totalCustomers; ++i) {
        Customer *nextCustomer = getOneCustomerForWeather:weather;
        [customers addObject:nextCustomer];
    }
    
    return customers;
}

- (int) customersFromWeather:(NSString*)weather {
    
    if ([weather isEqual: @"hot"]) {
        return [self randomNumberAtLeast:10 andAtMost:20];
    } else if ([weather isEqual: @"cloudy"]) {
        return [self randomNumberAtLeast:5 andAtMost:10];
    } else if ([weather isEqual: @"cold"]) {
        return 0;
    } else {
        [NSException raise:@"Invalid weather" format:@"Weather %@ is invalid", weather];
        return 0;
    }
}

- (int) customersFromWeekday:(NSString*)dayOfWeek {
    
    if ([dayOfWeek isEqual:@"saturday"] || [dayOfWeek isEqual:@"sunday"]) {
        return [self randomNumberAtLeast:15 andAtMost:20];
    } else if ([dayOfWeek isEqual:@"monday"] ||
               [dayOfWeek isEqual:@"tuesday"] ||
               [dayOfWeek isEqual:@"wednesday"] ||
               [dayOfWeek isEqual:@"thursday"] ||
               [dayOfWeek isEqual:@"friday"]) {
        return [self randomNumberAtLeast:0 andAtMost:5];
    } else {
        [NSException raise:@"Invalid day of week" format:@"day of week %@ is invalid", dayOfWeek];
        return 0;
    }
}



@end

