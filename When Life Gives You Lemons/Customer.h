//
//  Customer.h
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"
#import "NumberWithTwoDecimals.h"

@interface Customer : NSObject

- (void) setCustomerType:(NSInteger)type;
- (BOOL) willBuyAtPrice:(NumberWithTwoDecimals*)price withRecipe:(NSMutableDictionary*)recipe;
- (BOOL) likesRecipe:(NSMutableDictionary*)recipe forWeather:(Weather)weather;

@end
