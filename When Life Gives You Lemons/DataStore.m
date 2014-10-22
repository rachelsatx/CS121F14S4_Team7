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
    Weather _weather;
    int _cups;
    CGFloat _ice;
    CGFloat _sugar;
    CGFloat _lemons;
}
@end

@implementation DataStore

-(id)init
{
    self = [super init];
    _price = 4.20;
    _weather = Sunny;
    
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
- (Weather) getWeather
{
    return _weather;
}
- (void) setWeather:(Weather) newWeather
{
    _weather = newWeather;
}

// Cups
-(CGFloat) getCups
{
    return _cups;
}

-(void) setCups: (CGFloat) newCups
{
    _cups = newCups;
}

// Ice
-(int) getIce
{
    return _ice;
}

-(void) setIce: (int) newIce
{
    _ice = newIce;
}

// Sugar
-(CGFloat) getSugar
{
    return _sugar;
}

-(void) setSugar:(CGFloat) newSugar
{
    _sugar = newSugar;
}

// Lemons
-(CGFloat) getLemons
{
    return _lemons;
}

-(void) setLemons:(CGFloat) newLemons
{
    _lemons = newLemons;
}

@end
