//
//  PreDayInventoryView.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PreDayInvenentoryViewDelegate <NSObject>
@required
- (NSNumber*) getLemons;
- (void) setLemons:(NSNumber*) newLemons;
- (NSNumber*) getSugar;
- (void) setSugar:(NSNumber*) newSugar;
- (NSNumber*) getIce;
- (void) setIce:(NSNumber*) newIce;
- (NSNumber*) getCups;
- (void) setCups:(NSNumber*) newCups;
- (NSNumber*) getMoney;
- (void) setMoney:(NSNumber*) newMoney;
- (NSNumber*) getLemonPrice;
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
