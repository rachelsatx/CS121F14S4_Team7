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
        // Set background color depending on popularity
        NSNumber *popularity = dataStore.getPopularity;
        NSAssert(popularity >= 0, @"Negative popularity (%@)", popularity);
        CGFloat hue = [popularity floatValue] / 100.0 * 0.4;
        UIColor *backgroundColor = [UIColor colorWithHue:hue saturation:0.9 brightness:0.9 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        CGFloat borderRatio = 1.0 / 10.0;
        CGFloat outlineWidth = 5;
        
        CGFloat fontSize = 20;
        NSString *fontName = @"Chalkduster";
        
        // Add label for popularity
        CGRect popularityFrame = CGRectMake(frameWidth * borderRatio, frameHeight * borderRatio, (1.0 / borderRatio - 2) * frameWidth * borderRatio, 3 * frameHeight * borderRatio / 2);
        UITextView *popularityView =[[UITextView alloc] initWithFrame:popularityFrame];
        popularityView.backgroundColor = [UIColor whiteColor];
        popularityView.layer.borderWidth = outlineWidth;
        popularityView.layer.borderColor = [UIColor blackColor].CGColor;
        popularityView.textAlignment = NSTextAlignmentCenter;
        [popularityView setFont:[UIFont fontWithName:fontName size:fontSize]];
        popularityView.text = [NSString stringWithFormat: @"Popularity:\n\rYour popularity is at %@ percent.", popularity];
        [self addSubview:popularityView];
        
        // Add label for customer feedback
        CGRect feedbackFrame = CGRectMake(frameWidth * borderRatio, 3 * frameHeight / 10, (1.0 / borderRatio - 2) * frameWidth * borderRatio, 2 * frameHeight * borderRatio);
        UITextView *feedbackView =[[UITextView alloc] initWithFrame:feedbackFrame];
        feedbackView.backgroundColor = [UIColor whiteColor];
        feedbackView.layer.borderWidth = outlineWidth;
        feedbackView.layer.borderColor = [UIColor blackColor].CGColor;
        feedbackView.textAlignment = NSTextAlignmentCenter;
        [feedbackView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSString *feedback = dataStore.getFeedbackString;
        feedbackView.text = [NSString stringWithFormat: @"Feedback:\n\r%@", feedback];
        [self addSubview:feedbackView];
        
        // Add label for end-of-day summary
        CGRect summaryFrame = CGRectMake(frameWidth * borderRatio, 5 * frameHeight / 9, (1.0 / borderRatio - 2) * frameWidth * borderRatio, 7 * frameHeight * borderRatio / 2);
        UITextView *summaryView =[[UITextView alloc] initWithFrame:summaryFrame];
        summaryView.backgroundColor = [UIColor whiteColor];
        summaryView.layer.borderWidth = outlineWidth;
        summaryView.layer.borderColor = [UIColor blackColor].CGColor;
        summaryView.textAlignment = NSTextAlignmentCenter;
        [summaryView setFont:[UIFont fontWithName:fontName size:fontSize]];
        NSNumber *money = dataStore.getMoney;
        NSDictionary *inventory = dataStore.getInventory;
        NSNumber *numLemons = [inventory valueForKey:@"lemons"];
        NSNumber *numSugar = [inventory valueForKey:@"sugar"];
        NSNumber *numIce = [inventory valueForKey:@"ice"];
        NSNumber *numCups = [inventory valueForKey:@"cups"];
        
        NSAssert(money >= 0, @"Negative amount of money (%@)", money);
        NSAssert(numLemons >= 0, @"Negative amount of lemons (%@)", numLemons);
        NSAssert(numSugar >= 0, @"Negative amount of sugar (%@)", numSugar);
        NSAssert(numIce >= 0, @"Negative amount of ice (%@)", numIce);
        NSAssert(numCups >= 0, @"Negative amount of cups (%@)", numCups);
        
        NSString *moneyOnHand = [NSString stringWithFormat:@"Total money on hand: $%0.2f", [money floatValue]];
        NSString *lemonsRemaining = [NSString stringWithFormat:@"Lemons remaining: %0.2f", [numLemons floatValue]];
        NSString *sugarRemaining = [NSString stringWithFormat:@"Sugar remaining: %0.2f", [numSugar floatValue]];
        NSString *iceRemaining = [NSString stringWithFormat:@"Ice remaining: %0.2f", [numIce floatValue]];
        NSString *cupsRemaining = [NSString stringWithFormat:@"Cups remaining: %d", [numCups integerValue]];
        summaryView.text = [NSString stringWithFormat:@"%@\n\rInventory:\n\r%@\n\r%@\n\r%@\n\r%@", moneyOnHand,lemonsRemaining, sugarRemaining,  iceRemaining, cupsRemaining];
        [self addSubview:summaryView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
