//
//  Badges.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 12/4/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Badges : NSObject

extern NSString* allWater;
extern NSString* allLemons;
extern NSString* allSugar;
extern NSString* allIce;
extern NSString* runOut;
extern NSString* onceDelicious;
extern NSString* weekDelicious;
extern NSString* allFeedback;
extern NSString* dayCups;
extern NSString* totalCups;
extern NSString* dayMoney;
extern NSString* totalMoney;
extern NSString* dayPopularity;
extern NSString* totalPopularity;
extern NSString* yolo;
extern NSString* allBadges;

+(NSArray*) badgeArray;

@end
