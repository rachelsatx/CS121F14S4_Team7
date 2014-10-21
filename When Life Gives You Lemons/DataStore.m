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
}
@end

@implementation DataStore

-(id)init
{
    self = [super init];
    _price = 4.20;
    
    return self;
}

-(CGFloat) getPrice
{
    return _price;
}

-(void) setPrice:(CGFloat) newPrice
{
    _price = newPrice;
}

@end
