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

@interface DataStore : NSObject

- (CGFloat) getPrice;
- (void) setPrice:(CGFloat) newPrice;

- (Weather) getWeather;
- (void) setWeather:(Weather) newWeather;


@end
