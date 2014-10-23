//
//  Model.h
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"

@interface Model : NSObject

- (DataStore*) simulateDayWithDataStore:(DataStore*)dataStore;

@end
