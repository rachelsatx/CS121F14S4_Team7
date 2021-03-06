//
//  Model.h
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"
#import "NumberWithTwoDecimals.h"

@interface Model : NSObject

- (DataStore*) simulateDayWithDataStore:(DataStore*)dataStore;

// The following are public for unit testing.

- (int) randomNumberAtLeast:(int)lowerBound andAtMost:(int)upperBound;
- (int) customersFromWeather:(Weather)weather;
- (int) customersFromWeekday:(DayOfWeek)dayOfWeek;
- (int) mostCupsMakableFromInventory:(NSMutableDictionary*)inventory
                          withRecipe:(NSMutableDictionary*) recipe;
- (NSInteger) calculateNewPopularityWithNumCustomers:(int)totalCustomers
                                 portionBought:(float)portionWhoBought
                                  portionLiked:(float)portionWhoLiked
                             fromOldPopularity:(NSInteger)popularity;
- (NSMutableDictionary*) removeIngredientsOfRecipe:(NSMutableDictionary*)recipe
                                     fromInventory:(NSMutableDictionary*)inventory;
- (DayOfWeek) nextDayOfWeek:(DayOfWeek)currentDay;

@end
