//
//  PreDayBadgesView.h
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 11/30/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreDayBadgesView : UIView

- (id)initWithFrame:(CGRect)frame andBadges:(NSMutableDictionary*)badgeDictionary;
- (void)updateAllBadgeBackgrounds:(NSMutableDictionary*)badgeDictionary;

@end
