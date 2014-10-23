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
        
        UIImageView *mainView =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 8, frameHeight / 8, 6 * frameWidth / 8, 6 * frameHeight / 8)];
        mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainView];
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
