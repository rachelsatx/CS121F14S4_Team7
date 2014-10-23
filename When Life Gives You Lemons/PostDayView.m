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
        UIColor *backgroundColor = [UIColor colorWithRed:140.0/255 green:211.0/255 blue:255.0/255 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        CGFloat borderRatio = 1.0 / 10.0;
        
        // Add label for popularity
        CGRect popularityFrame = CGRectMake(frameWidth * borderRatio, frameHeight * borderRatio, (1.0 / borderRatio - 2) * frameWidth * borderRatio, 2 * frameHeight * borderRatio);
        UITextView *popularityView =[[UITextView alloc] initWithFrame:popularityFrame];
        popularityView.backgroundColor = [UIColor whiteColor];
        popularityView.textAlignment = NSTextAlignmentCenter;
        [popularityView setFont:[UIFont systemFontOfSize:20]];
        NSNumber *popularity = dataStore.getPopularity;
        popularityView.text = [NSString stringWithFormat: @"Popularity:\n\rYour popularity is at %@ percent.", popularity];
        [self addSubview:popularityView];
        
        // Add label for customer feedback
        CGRect feedbackFrame = CGRectMake(frameWidth * borderRatio, frameHeight / 3, (1.0 / borderRatio - 2) * frameWidth * borderRatio, 2 * frameHeight * borderRatio);
        UITextView *feedbackView =[[UITextView alloc] initWithFrame:feedbackFrame];
        feedbackView.backgroundColor = [UIColor whiteColor];
        feedbackView.textAlignment = NSTextAlignmentCenter;
        [feedbackView setFont:[UIFont systemFontOfSize:20]];
        NSString *feedback = dataStore.getFeedbackString;
        feedbackView.text = [NSString stringWithFormat: @"Feedback:\n\r%@", feedback];
        [self addSubview:feedbackView];
        
        // Add label for end-of-day summary
        CGRect summaryFrame = CGRectMake(frameWidth * borderRatio, 3 * frameHeight / 5, (1.0 / borderRatio - 2) * frameWidth * borderRatio, 3 * frameHeight * borderRatio);
        UITextView *summaryView =[[UITextView alloc] initWithFrame:summaryFrame];
        summaryView.backgroundColor = [UIColor whiteColor];
        summaryView.textAlignment = NSTextAlignmentCenter;
        [summaryView setFont:[UIFont systemFontOfSize:20]];
        NSDictionary *inventory = dataStore.getInventory;
        NSNumber *numLemons = [inventory valueForKey:@"lemons"];
        NSNumber *numSugar = [inventory valueForKey:@"sugar"];
        NSNumber *numWater = [inventory valueForKey:@"water"];
        NSNumber *numIce = [inventory valueForKey:@"ice"];
        NSInteger numCups = [inventory valueForKey:@"cups"];
        NSString *lemonsRemaining = [NSString stringWithFormat:@"Lemons remaining: %@", numLemons];
        NSString *sugarRemaining = [NSString stringWithFormat:@"Sugar remaining: %@", numSugar];
        NSString *waterRemaining = [NSString stringWithFormat:@"Water remaining: %@", numWater];
        NSString *iceRemaining = [NSString stringWithFormat:@"Ice remaining: %@", numIce];
        NSString *cupsRemaining = [NSString stringWithFormat:@"Cups remaining: %d", numCups];
        summaryView.text = [NSString stringWithFormat:@"Inventory:\n\r%@\n\r%@\n\r%@\n\r%@\n\r%@", lemonsRemaining, sugarRemaining, waterRemaining, iceRemaining, cupsRemaining];
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
