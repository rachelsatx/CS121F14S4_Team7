//
//  MidDayView.h
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import <SpriteKit/SpriteKit.h>

@interface MidDayView : UIView

- (id)initWithFrame:(CGRect)frame andDataStore:(DataStore *)dataStore;
- (void) releaseAnimationForWeather:(Weather)weather;

@end
