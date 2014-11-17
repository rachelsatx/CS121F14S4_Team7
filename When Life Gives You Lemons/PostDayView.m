//
//  PostDayView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/22/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PostDayView.h"
#import "DataStore.h"

@implementation PostDayView

- (id)initWithFrame:(CGRect)frame andDataStore:(DataStore *)dataStore
{
    self = [self initWithFrame:frame];
    
    if (self) {
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        CGFloat borderThickness = frameWidth / 10.0;
        CGFloat imageSize = frameHeight < frameWidth ? (frameHeight / 5.0) : (frameWidth / 5.0);
        CGFloat outlineWidth = 5;
        
        CGFloat fontSize = 20;
        NSString *fontName = @"Chalkduster";
        
        // Set background color depending on money
        CGFloat maxProfitForHue = 30.0;
        NSNumber *profit = dataStore.getProfit;
        NSAssert(profit >= 0, @"Negative amount of profit (%@)", profit);
        CGFloat hueFactor = [profit floatValue] < maxProfitForHue ? [profit floatValue] : maxProfitForHue;
        CGFloat hue = hueFactor / maxProfitForHue * 0.4;
        UIColor *backgroundColor = [UIColor colorWithHue:hue saturation:0.9 brightness:0.9 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        
        // Add text for popularity
        CGRect popularityFrame = CGRectMake(borderThickness, borderThickness, frameWidth - (2 * borderThickness), frameHeight / 4);
        UITextView *popularityView = [[UITextView alloc] initWithFrame:popularityFrame];
        popularityView.backgroundColor = [UIColor whiteColor];
        popularityView.layer.borderWidth = outlineWidth;
        popularityView.layer.borderColor = [UIColor blackColor].CGColor;
        popularityView.textAlignment = NSTextAlignmentCenter;
        [popularityView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSNumber *popularity = dataStore.getPopularity;
        NSAssert(popularity >= 0, @"Negative popularity (%@)", popularity);
        popularityView.text = [NSString stringWithFormat: @"\nPopularity:\n\rYour popularity is at %@ percent.", popularity];
        [self addSubview:popularityView];
        
        // Add text for customer feedback
        CGRect feedbackFrame = CGRectMake(borderThickness, borderThickness + (frameHeight / 4) + (borderThickness / 2), frameWidth - (2 * borderThickness), frameHeight / 4);
        UITextView *feedbackView = [[UITextView alloc] initWithFrame:feedbackFrame];
        feedbackView.backgroundColor = [UIColor whiteColor];
        feedbackView.layer.borderWidth = outlineWidth;
        feedbackView.layer.borderColor = [UIColor blackColor].CGColor;
        feedbackView.textAlignment = NSTextAlignmentCenter;
        [feedbackView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSString *feedback = dataStore.getFeedbackString;
        feedbackView.text = [NSString stringWithFormat: @"\nFeedback:\n\r%@", feedback];
        [self addSubview:feedbackView];
        
        // Add text for end-of-day summary
        CGRect summaryFrame = CGRectMake(borderThickness, borderThickness + (frameHeight / 2) + 2 * (borderThickness / 2), frameWidth - (2 * borderThickness), frameHeight / 4);
        UITextView *summaryView = [[UITextView alloc] initWithFrame:summaryFrame];
        summaryView.backgroundColor = [UIColor whiteColor];
        summaryView.layer.borderWidth = outlineWidth;
        summaryView.layer.borderColor = [UIColor blackColor].CGColor;
        summaryView.textAlignment = NSTextAlignmentCenter;
        [summaryView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSString *profitFromDay = [NSString stringWithFormat:@"Profit from the day: $%0.2f", [profit floatValue]];
        NSNumber *money = dataStore.getMoney;
        NSAssert(money >= 0, @"Negative money (%@)", money);
        NSString *moneyOnHand = [NSString stringWithFormat:@"Total money on hand: $%0.2f", [money floatValue]];
        summaryView.text = [NSString stringWithFormat:@"\nMoney:\n\r%@\n\r%@", profitFromDay, moneyOnHand];
        [self addSubview:summaryView];
        
        // Add customer images according to popularity
        NSInteger numCustomers = [popularity integerValue] / 10 < 9 ? [popularity integerValue] / 10 : 9;
        for (NSInteger i = 0; i < numCustomers; i += 1) {
            CGRect customerFrame = CGRectMake(i * (imageSize / 2), (3 * borderThickness / 2) + frameHeight / 4 - imageSize, imageSize, imageSize);
            UIImageView *customerView = [[UIImageView alloc] initWithFrame:customerFrame];
            customerView.image = [UIImage imageNamed:@"person-navy"];
            [self addSubview:customerView];
        }
        
        // Add lemonade jug image
        CGRect jugFrame = CGRectMake(frameWidth - (borderThickness / 2) - imageSize, frameHeight / 2, imageSize, imageSize);
        UIImageView *jugView = [[UIImageView alloc] initWithFrame:jugFrame];
        jugView.image = [UIImage imageNamed:@"jug"];
        [self addSubview:jugView];
        
        // Add coins image
        CGRect coinsFrame = CGRectMake(borderThickness / 2, (borderThickness / 2) + (3 * frameHeight / 4), imageSize, imageSize);
        UIImageView *coinsView = [[UIImageView alloc] initWithFrame:coinsFrame];
        coinsView.image = [UIImage imageNamed:@"coins"];
        [self addSubview:coinsView];
    }
    
    return self;
}

@end
