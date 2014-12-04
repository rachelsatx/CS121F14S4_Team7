//
//  DataStore.h
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberWithTwoDecimals.h"

typedef NS_ENUM(int, Weather) {
    Sunny,
    Cloudy,
    Raining
};

typedef NS_ENUM(int, DayOfWeek) {
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
};

@interface DataStore : NSObject

- (NumberWithTwoDecimals*) getPrice;
- (void) setPrice:(NumberWithTwoDecimals*) newPrice;

- (Weather) getWeather;
- (void) setWeather:(Weather) newWeather;

- (DayOfWeek) getDayOfWeek;
- (void) setDayOfWeek:(DayOfWeek) newDayOfWeek;

-(NSString*) getFeedbackString;
-(void) setFeedbackString:(NSString*) newFeedbackString;

-(NSMutableDictionary*) getRecipe;
-(void) setRecipe:(NSMutableDictionary*) newRecipe;

-(NSMutableDictionary*) getInventory;
-(void) setInventory:(NSMutableDictionary*) newInventory;

-(NSMutableDictionary*) getIngredientPrices;
-(void) setIngredientPrices:(NSMutableDictionary*) newIngredientPrices;

-(NSMutableDictionary*) getBadges;
-(void) setBadges:(NSMutableDictionary*) newBadges;

-(NSMutableSet*) getFeedbackSet;
-(void) setFeedbackSet:(NSMutableSet*) newFeedbackSet;

-(NSInteger) getPopularity;
-(void) setPopularity:(NSInteger) newPopularity;

-(NumberWithTwoDecimals*) getMoney;
-(void) setMoney:(NumberWithTwoDecimals*) newMoney;

-(NumberWithTwoDecimals*) getProfit;
-(void) setProfit:(NumberWithTwoDecimals*) newProfit;

-(NSInteger) getCupsSold;
-(void) setCupsSold:(NSInteger) newCupsSold;

-(NSInteger) getDaysOfPerfectLemonade;
-(void) setDaysOfPerfectLemonade:(NSInteger) newDays;

-(NSInteger) getTotalCupsSold;
-(void) setTotalCupsSold:(NSInteger) newCups;

-(NumberWithTwoDecimals*) getTotalEarnings;
-(void) setTotalEarnings:(NumberWithTwoDecimals*) newTotal;
@end
