//
//  NumberWithTwoDecimals.h
//  When Life Gives You Lemons
//
//  Created by Guest User on 11/17/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberWithTwoDecimals : NSObject

- (id) initWithIntegerPart:(int)integerPart andFractionalPart:(int)fractionalPart;
- (id) initWithFloat:(float)number;

- (int) integerPart;
- (int) fractionalPart;
- (float) floatValue;

- (BOOL) isEqual:(NumberWithTwoDecimals*)other;
- (BOOL) isNotEqual:(NumberWithTwoDecimals*)other;
- (BOOL) isGreaterThan:(NumberWithTwoDecimals*)other;
- (BOOL) isGreaterThanOrEqual:(NumberWithTwoDecimals*)other;
- (BOOL) isLessThan:(NumberWithTwoDecimals*)other;
- (BOOL) isLessThanOrEqual:(NumberWithTwoDecimals*)other;

- (NumberWithTwoDecimals*) add:(NumberWithTwoDecimals*)other;
- (NumberWithTwoDecimals*) subtract:(NumberWithTwoDecimals*)other;
- (NumberWithTwoDecimals*) scale:(int)other;

@end
