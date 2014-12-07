//
//  Badges.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 12/4/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "Badges.h"

@implementation Badges

NSString* allWater = @"Con\nArtist";
NSString* allLemons = @"Lemon\nHead";
NSString* allSugar = @"Sweet\nTooth";
NSString* allIce = @"Frozen";
NSString* runOut = @"Under-estimate";
NSString* onceDelicious = @"The\nPerfect\nCup";
NSString* weekDelicious = @"The\nPerfect\nWeek";
NSString* allFeedback = @"Scientist";
NSString* dayMoney = @"Great\nDay";
NSString* totalMoney = @"Bill\nGates";
NSString* dayPopularity = @"Rising\nStar";
NSString* totalPopularity = @"World\nFamous";
NSString* dayCups = @"Salesman";
NSString* totalCups = @"Lemon\nCorp\u2122";
NSString* differentWeatherCups = @"Jack-of-all-Trades";
NSString* allBadges = @"Perfection";

+ (NSArray*) badgeArray {
    return [NSArray arrayWithObjects:allWater, allLemons, allSugar, allIce, runOut, onceDelicious, weekDelicious, allFeedback, dayMoney, totalMoney, dayPopularity, totalPopularity, dayCups, totalCups, differentWeatherCups, allBadges, nil];
}

@end
