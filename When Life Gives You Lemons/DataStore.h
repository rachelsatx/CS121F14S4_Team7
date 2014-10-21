//
//  DataStore.h
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

- (CGFloat) getPrice;
- (void) setPrice:(CGFloat) newPrice;

- (NSString*) getWeather;
- (void) setWeather:(NSString*) newWeather;


@end
