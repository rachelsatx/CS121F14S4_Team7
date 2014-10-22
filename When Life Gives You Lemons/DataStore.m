//
//  DataStore.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "DataStore.h"

@interface DataStore () {
    CGFloat _price;
    NSString* _weather;
}
@end

@implementation DataStore

-(id)init
{
    self = [super init];
    _price = 4.20;
    _weather = @"sunny";
    
    return self;
}

// Price
-(CGFloat) getPrice
{
    return _price;
}

-(void) setPrice:(CGFloat) newPrice
{
    _price = newPrice;
}

// Weather
- (NSString*) getWeather
{
    return _weather;
}
- (void) setWeather:(NSString*) newWeather
{
    _weather = newWeather;
}


@end
