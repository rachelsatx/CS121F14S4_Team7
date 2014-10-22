//
//  MidDayView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MidDayView.h"

@implementation MidDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *backgroundColor = [UIColor colorWithRed:140.0/255 green:211.0/255 blue:255.0/255 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        UIImageView *grass = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7 * frameHeight / 8, frameWidth, frameHeight / 8)];
        grass.backgroundColor = [UIColor colorWithRed:124.0/255 green:252.0/255 blue:0.0/255 alpha:1.0];
        [self addSubview:grass];
        
        CGFloat sunSize = frameWidth > frameHeight ? frameHeight : frameWidth;
        UIImageView *sun =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 8, frameHeight / 8, sunSize / 7, sunSize / 7)];
        sun.image=[UIImage imageNamed:@"sun.png"];
        [self addSubview:sun];
        
        UIImageView *vendor =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 2, 4 * frameHeight / 7, frameWidth / 4, frameHeight / 4)];
        vendor.image=[UIImage imageNamed:@"person.png"];
        [self addSubview:vendor];
        
        UIImageView *lemonadeStand =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 4, frameHeight / 4, 3 * frameWidth / 4, 3 * frameHeight / 4)];
        lemonadeStand.image=[UIImage imageNamed:@"lemonade-stand.png"];
        [self addSubview:lemonadeStand];
        
        CGFloat buttonWidth = 200;
        CGFloat buttonHeight = 50;
        CGFloat topBorder = 40;
        CGFloat rightBorder = 20;
        UIButton *goToPostDayView = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth - buttonWidth - rightBorder, topBorder, buttonWidth, buttonHeight)];
        [goToPostDayView setTitle:@"Go to Post-Day" forState:UIControlStateNormal];
        [goToPostDayView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:goToPostDayView];
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
