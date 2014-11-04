//
//  MidDayView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MidDayView.h"
#import "DataStore.h"

@implementation MidDayView

- (id)initWithFrame:(CGRect)frame andDataStore:(DataStore *)dataStore
{
    self = [self initWithFrame:frame];
    if (self) {
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        CGFloat fontSize = 20;
        NSString *fontName = @"Chalkduster";
        
        Weather weather = dataStore.getWeather;
        UIColor *backgroundColor;
        if (weather == Sunny) {
            backgroundColor = [UIColor colorWithRed:140.0/255 green:211.0/255 blue:255.0/255 alpha:1.0];
            
            CGFloat sunSize = frameWidth > frameHeight ? frameHeight : frameWidth;
            UIImageView *sun =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 8, frameHeight / 8, sunSize / 7, sunSize / 7)];
            sun.image=[UIImage imageNamed:@"sun.png"];
            [self addSubview:sun];
        } else if (weather == Cloudy) {
            backgroundColor = [UIColor colorWithRed:176.0/255 green:196.0/255 blue:222.0/255 alpha:1.0];
        } else if (weather == Raining) {
            backgroundColor = [UIColor colorWithRed:173.0/255 green:216.0/255 blue:230.0/255 alpha:1.0];
        }
        [self setBackgroundColor:backgroundColor];
        
        UIImageView *grass = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7 * frameHeight / 8, frameWidth, frameHeight / 8)];
        grass.backgroundColor = [UIColor colorWithRed:124.0/255 green:252.0/255 blue:0.0/255 alpha:1.0];
        [self addSubview:grass];
        
        UIImageView *vendor =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 2, 4 * frameHeight / 7, frameWidth / 4, frameHeight / 4)];
        vendor.image=[UIImage imageNamed:@"person.png"];
        [self addSubview:vendor];
        
        UIImageView *lemonadeStand =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 4, frameHeight / 4, 3 * frameWidth / 4, 3 * frameHeight / 4)];
        lemonadeStand.image=[UIImage imageNamed:@"lemonade-stand.png"];
        [self addSubview:lemonadeStand];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(4 * frameWidth / 5, 4 * frameHeight / 5, frameWidth / 4, frameHeight / 4)];
        CGFloat price = [dataStore.getPrice floatValue];
        NSAssert(price >= 0, @"Negative price (%0.2f)", price);
        priceLabel.text = [NSString stringWithFormat:@"$%0.2f", price];
        [priceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [self addSubview:priceLabel];
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
