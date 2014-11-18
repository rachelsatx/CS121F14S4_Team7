//
//  NumberWithTwoDecimals.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 11/17/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "NumberWithTwoDecimals.h"

@interface NumberWithTwoDecimals () {
    int _integerPart;
    int _fractionalPart;
}
@end

@implementation NumberWithTwoDecimals

- (id) initWithIntegerPart:(int)integerPart andFractionalPart:(int)fractionalPart
{
    self = [super init];
    
    if (self) {
        _integerPart = integerPart;
        _fractionalPart = fractionalPart;
    }
    
    NSAssert((_fractionalPart >= 0) && (_fractionalPart <= 99), @"Fractional part: %d is invalid", (int) _fractionalPart);
    
    return self;
}

- (id) initWithFloat:(float)number
{
    self = [super init];
    
    if (self) {
        _integerPart = (int) number;
        float decimalPart = number - _integerPart;
        _fractionalPart = (int) decimalPart*100 + 0.5;
    }
    
     NSAssert((_fractionalPart >= 0) && (_fractionalPart <= 99), @"Fractional part: %d is invalid", (int) _fractionalPart);
    
    return self;
}

- (int) integerPart
{
    return _integerPart;
}

- (int) fractionalPart
{
    return _fractionalPart;
}

- (BOOL) isEqual:(NumberWithTwoDecimals *)other
{
    return ((_integerPart == [other integerPart]) && (_fractionalPart == [other fractionalPart]));
}

- (BOOL) isNotEqual:(NumberWithTwoDecimals *)other
{
    return ((_integerPart != [other integerPart]) || (_fractionalPart != [other fractionalPart]));
}

- (BOOL) isGreaterThan:(NumberWithTwoDecimals *)other
{
    return ((_integerPart > [other integerPart]) ||
            ((_integerPart == [other integerPart]) && (_fractionalPart > [other fractionalPart])));
}

- (BOOL) isGreaterThanOrEqual:(NumberWithTwoDecimals *)other
{
    return ((_integerPart > [other integerPart]) ||
            ((_integerPart == [other integerPart]) && (_fractionalPart >= [other fractionalPart])));
}

- (BOOL) isLessThan:(NumberWithTwoDecimals *)other
{
    return ((_integerPart < [other integerPart]) ||
            ((_integerPart == [other integerPart]) && (_fractionalPart < [other fractionalPart])));
}

- (BOOL) isLessThanOrEqual:(NumberWithTwoDecimals *)other
{
    return ((_integerPart < [other integerPart]) ||
            ((_integerPart == [other integerPart]) && (_fractionalPart <= [other fractionalPart])));
}

- (NumberWithTwoDecimals*) add:(NumberWithTwoDecimals *)other
{
    int fractionalPart = _fractionalPart + [other fractionalPart];
    int integerPart = _integerPart + [other integerPart];
    return [[NumberWithTwoDecimals alloc] initWithIntegerPart:integerPart + (fractionalPart >= 100)
                                            andFractionalPart:fractionalPart%100];
}

- (NumberWithTwoDecimals*) subtract:(NumberWithTwoDecimals *)other
{
    int fractionalPart = _fractionalPart - [other fractionalPart];
    int integerPart = _integerPart - [other integerPart];
    return [[NumberWithTwoDecimals alloc] initWithIntegerPart:integerPart - (fractionalPart < 0)
                                            andFractionalPart:fractionalPart%100];
}

- (NumberWithTwoDecimals*) scale:(int)other
{
    char fractionalPart = other * _fractionalPart;
    int integerPart = other * _fractionalPart;
    return [[NumberWithTwoDecimals alloc] initWithIntegerPart:integerPart + (fractionalPart/100)
                                            andFractionalPart:fractionalPart%100];
}

@end
