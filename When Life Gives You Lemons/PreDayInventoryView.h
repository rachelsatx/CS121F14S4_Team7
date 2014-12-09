//
//  PreDayInventoryView.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberWithTwoDecimals.h"

@protocol PreDayInvenentoryViewDelegate <NSObject>
@required
- (NumberWithTwoDecimals*) getLemons;
- (void) setLemons:(NumberWithTwoDecimals*) newLemons;
- (NumberWithTwoDecimals*) getSugar;
- (void) setSugar:(NumberWithTwoDecimals*) newSugar;
- (NumberWithTwoDecimals*) getIce;
- (void) setIce:(NumberWithTwoDecimals*) newIce;
- (NumberWithTwoDecimals*) getCups;
- (void) setCups:(NumberWithTwoDecimals*) newCups;
- (NumberWithTwoDecimals*) getMoney;
- (void) setMoney:(NumberWithTwoDecimals*) newMoney;
- (NumberWithTwoDecimals*) getLemonPrice;
- (NumberWithTwoDecimals*) getSugarPrice;
- (NumberWithTwoDecimals*) getIcePrice;
- (NumberWithTwoDecimals*) getCupsPrice;
@end

@interface PreDayInventoryView : UIView
{
    id <PreDayInvenentoryViewDelegate> _delegate;
}

- (void) updateAmountLabels;
- (void) updateMoneyLabel;
- (void) updatePriceLabels;

@property (nonatomic,strong) id delegate;

@end
