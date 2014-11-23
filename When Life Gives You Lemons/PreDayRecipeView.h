//
//  PreDayRecipeView.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/22/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, Ingredient) {
    Lemons,
    Sugar,
    Ice,
    Water
};

@protocol PreDayRecipeViewDelegate <NSObject>
@required
- (NSNumber*) getLemonsPercentage;
- (void) setLemonsPercentage:(NSNumber*) newLemons;
- (NSNumber*) getSugarPercentage;
- (void) setSugarPercentage:(NSNumber*) newSugar;
- (NSNumber*) getIcePercentage;
- (void) setIcePercentage:(NSNumber*) newIce;
- (NSNumber*) getWaterPercentage;
- (void) setWaterPercentage:(NSNumber*) newWater;
@end

@interface PreDayRecipeView : UIView
{
    id <PreDayRecipeViewDelegate> _delegate;
}

- (void) updatePercentageLabels;

@property (nonatomic,strong) id delegate;

@end
