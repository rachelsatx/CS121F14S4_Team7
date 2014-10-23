//
//  PostDayView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/22/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PostDayView.h"

@implementation PostDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *backgroundColor = [UIColor colorWithRed:140.0/255 green:211.0/255 blue:255.0/255 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        CGFloat borderRatio = 1.0 / 10.0;
        
        // Add label for ratings (stars)
        CGRect ratingsFrame = CGRectMake(frameWidth * borderRatio, frameHeight * borderRatio, (1.0 / borderRatio - 2) * frameWidth * borderRatio, frameHeight * borderRatio);
        UILabel *ratings =[[UILabel alloc] initWithFrame:ratingsFrame];
        ratings.backgroundColor = [UIColor whiteColor];
        ratings.textAlignment = NSTextAlignmentCenter;
        ratings.text = @"You earned 5 stars!";
        [self addSubview:ratings];
        
        // Add label for customer feedback
        CGRect feedbackFrame = CGRectMake(frameWidth * borderRatio, frameHeight / 2, (1.0 / borderRatio - 2) * frameWidth * borderRatio, frameHeight * borderRatio);
        UILabel *feedback =[[UILabel alloc] initWithFrame:feedbackFrame];
        feedback.backgroundColor = [UIColor whiteColor];
        feedback.textAlignment = NSTextAlignmentCenter;
        feedback.text = @"The lemonade was too sour.";
        [self addSubview:feedback];
        
        // Add label for end-of-day summary
        CGRect summaryFrame = CGRectMake(frameWidth * borderRatio, 2 * frameHeight / 3, (1.0 / borderRatio - 2) * frameWidth * borderRatio, frameHeight * borderRatio);
        UILabel *summary =[[UILabel alloc] initWithFrame:summaryFrame];
        summary.backgroundColor = [UIColor whiteColor];
        summary.textAlignment = NSTextAlignmentCenter;
        summary.text = @"You made $20.";
        [self addSubview:summary];
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
