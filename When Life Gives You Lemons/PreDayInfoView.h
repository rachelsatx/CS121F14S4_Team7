//
//  PreDayInfoView.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 11/16/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@protocol PreDayInfoViewDelegate <NSObject>
@required
- (void) incrementPrice:(id)sender;
- (void) decrementPrice:(id)sender;
- (NSNumber*) getPrice;
- (NSNumber*) getMakableCups;
- (Weather) getWeather;
- (DayOfWeek) getDayOfWeek;
@end

@interface PreDayInfoView : UIView
{
    id <PreDayInfoViewDelegate> _delegate;
}

@property (nonatomic,strong) id delegate;
- (void)updatePriceLabel;
- (void)updateWeather;
- (void)updateDayLabel;
- (void)updateMakeableCupsLabel;

@end
