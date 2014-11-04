//
//  DataStore.h
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Weather) {
    Sunny,
    Cloudy,
    Raining
};

typedef NS_ENUM(NSInteger, DayOfWeek) {
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
};

typedef NS_ENUM(NSInteger, Ingredient) {
    Lemons,
    Sugar,
    Ice,
    Cups,
    Water
};

@interface DataStore : NSObject

- (NSNumber*) getPrice;
- (void) setPrice:(NSNumber*) newPrice;

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

-(NSNumber*) getPopularity;
-(void) setPopularity:(NSNumber*) newPopularity;

-(NSNumber*) getMoney;
-(void) setMoney:(NSNumber*) newMoney;
@end
