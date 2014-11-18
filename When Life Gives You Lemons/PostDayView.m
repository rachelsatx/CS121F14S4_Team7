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
        CGFloat textViewWidth = frameWidth - (2 * borderThickness);
        CGFloat textViewHeight = frameHeight / 4;
        CGFloat heightBetweenTextViews = borderThickness / 2;
        
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
        
        // Create popularity frame and text
        CGRect popularityFrame = CGRectMake(borderThickness,
                                            borderThickness,
                                            textViewWidth,
                                            textViewHeight);
        UITextView *popularityView = [[UITextView alloc] initWithFrame:popularityFrame];
        popularityView.backgroundColor = [UIColor whiteColor];
        popularityView.layer.borderWidth = outlineWidth;
        popularityView.layer.borderColor = [UIColor blackColor].CGColor;
        popularityView.textAlignment = NSTextAlignmentCenter;
        [popularityView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSNumber *popularity = dataStore.getPopularity;
        NSAssert(popularity >= 0, @"Negative popularity (%@)", popularity);
        popularityView.text = [NSString stringWithFormat: @"\nPopularity:\n\rYour popularity is at %@ percent.", popularity];
        popularityView.editable = NO;
        [self addSubview:popularityView];
        
        // Create feedback frame
        CGRect feedbackFrame = CGRectMake(borderThickness,
                                          borderThickness + textViewHeight + heightBetweenTextViews,
                                          textViewWidth,
                                          textViewHeight);
        UITextView *feedbackView = [[UITextView alloc] initWithFrame:feedbackFrame];
        feedbackView.backgroundColor = [UIColor whiteColor];
        feedbackView.layer.borderWidth = outlineWidth;
        feedbackView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:feedbackView];
        
        // Create feedback text - this view is less wide than the feedback frame
        // and is done so that the jug does not cover any feedback
        CGRect feedbackTextFrame = CGRectMake((3 * borderThickness / 2) + outlineWidth,
                                              borderThickness + textViewHeight + heightBetweenTextViews + outlineWidth,
                                              textViewWidth - borderThickness - (2 * outlineWidth),
                                              textViewHeight - (2 * outlineWidth));
        UITextView *feedbackTextView = [[UITextView alloc] initWithFrame:feedbackTextFrame];
        feedbackTextView.backgroundColor = [UIColor whiteColor];
        feedbackTextView.textAlignment = NSTextAlignmentCenter;
        [feedbackTextView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSString *feedback = dataStore.getFeedbackString;
        feedbackTextView.text = [NSString stringWithFormat: @"\nFeedback:\n\r%@", feedback];
        feedbackTextView.editable = NO;
        [self addSubview:feedbackTextView];
        
        // Create end-of-day summary frame and text
        CGRect summaryFrame = CGRectMake(borderThickness,
                                         borderThickness + 2 * textViewHeight + 2 * heightBetweenTextViews,
                                         textViewWidth,
                                         textViewHeight);
        UITextView *summaryView = [[UITextView alloc] initWithFrame:summaryFrame];
        summaryView.backgroundColor = [UIColor whiteColor];
        summaryView.layer.borderWidth = outlineWidth;
        summaryView.layer.borderColor = [UIColor blackColor].CGColor;
        summaryView.textAlignment = NSTextAlignmentCenter;
        [summaryView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSInteger cupsSold = dataStore.getCupsSold;
        NSAssert(cupsSold >= 0, @"Negative number of cups sold (%d)", cupsSold);
        NSString *profitFromDay = [NSString stringWithFormat:@"You sold %d cups of lemonade and made $%0.2f.", cupsSold, [profit floatValue]];
        NSNumber *money = dataStore.getMoney;
        NSAssert(money >= 0, @"Negative money (%@)", money);
        NSString *moneyOnHand = [NSString stringWithFormat:@"Total money on hand: $%0.2f", [money floatValue]];
        summaryView.text = [NSString stringWithFormat:@"\nMoney:\n\r%@\n\r%@", profitFromDay, moneyOnHand];
        summaryView.editable = NO;
        [self addSubview:summaryView];
        
        // Add customer images according to popularity - the max that will fit is 9
        NSInteger numCustomers = [popularity integerValue] / 10 < 9 ? [popularity integerValue] / 10 : 9;
        for (NSInteger i = 0; i < numCustomers; i += 1) {
            CGRect customerFrame = CGRectMake(i * (imageSize / 2),
                                              (3 * borderThickness / 2) + textViewHeight - imageSize,
                                              imageSize,
                                              imageSize);
            UIImageView *customerView = [[UIImageView alloc] initWithFrame:customerFrame];
            customerView.image = [UIImage imageNamed:@"person-navy"];
            [self addSubview:customerView];
        }
        
        // Add lemonade jug image
        CGRect jugFrame = CGRectMake(frameWidth - (borderThickness / 4) - imageSize,
                                     2 * textViewHeight,
                                     imageSize,
                                     imageSize);
        UIImageView *jugView = [[UIImageView alloc] initWithFrame:jugFrame];
        jugView.image = [UIImage imageNamed:@"jug"];
        [self addSubview:jugView];
        
        // Add coins image
        CGRect coinsFrame = CGRectMake(borderThickness / 2,
                                       (borderThickness / 2) + (3 * textViewHeight),
                                       imageSize,
                                       imageSize);
        UIImageView *coinsView = [[UIImageView alloc] initWithFrame:coinsFrame];
        coinsView.image = [UIImage imageNamed:@"coins"];
        [self addSubview:coinsView];
    }
    
    return self;
}

@end
