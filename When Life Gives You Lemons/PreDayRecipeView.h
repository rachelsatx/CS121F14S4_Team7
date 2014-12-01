//
//  PreDayRecipeView.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/22/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberWithTwoDecimals.h"

@protocol PreDayRecipeViewDelegate <NSObject>
@required
- (NumberWithTwoDecimals*) getLemonsPercentage;
- (void) setLemonsPercentage:(NumberWithTwoDecimals*) newLemons;
- (NumberWithTwoDecimals*) getSugarPercentage;
- (void) setSugarPercentage:(NumberWithTwoDecimals*) newSugar;
- (NumberWithTwoDecimals*) getIcePercentage;
- (void) setIcePercentage:(NumberWithTwoDecimals*) newIce;
- (NumberWithTwoDecimals*) getWaterPercentage;
- (void) setWaterPercentage:(NumberWithTwoDecimals*) newWater;
@end

@interface PreDayRecipeView : UIView
{
    id <PreDayRecipeViewDelegate> _delegate;
}

- (void) updatePercentageLabels;

@property (nonatomic,strong) id delegate;

@end
