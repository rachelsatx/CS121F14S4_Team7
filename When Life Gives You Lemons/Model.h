//
//  Model.h
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

- (NSDictionary*) simulateDayOnDay:(NSString*)dayOfWeek withWeather:(NSString*)weather forRecipe:(NSDictionary*)recipe andPrice:(NSNumber*)price andPopularity:(NSNumber*)popularity;

@end
