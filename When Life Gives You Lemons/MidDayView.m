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
        
        CGFloat fontSize = 50;
        NSString *fontName = @"Chalkduster";
        
        Weather weather = dataStore.getWeather;
        if (weather == Sunny) {
            UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sunny-background"]];
            [self addSubview:backgroundView];
            
            CGFloat sunSize = frameWidth > frameHeight ? frameHeight : frameWidth;
            UIImageView *sun =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 10, frameHeight / 10, sunSize / 7, sunSize / 7)];
            sun.image=[UIImage imageNamed:@"sun.png"];
            [self addSubview:sun];
        } else if (weather == Cloudy) {
            UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudy-background"]];
            [self addSubview:backgroundView];
        } else if (weather == Raining) {
            UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"raining-background"]];
            [self addSubview:backgroundView];
        }
        
        UIImageView *grassBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2 * frameHeight / 3, frameWidth, frameHeight / 3)];
        [grassBackground setImage:[UIImage imageNamed:@"grass-background"]];
        [self addSubview:grassBackground];
        
        UIImageView *vendor =[[UIImageView alloc] initWithFrame:CGRectMake(frameWidth / 4, frameHeight / 2, frameWidth / 4, frameHeight / 4)];
        vendor.image=[UIImage imageNamed:@"person.png"];
        [self addSubview:vendor];
        
        UIImageView *lemonadeStand =[[UIImageView alloc] initWithFrame:CGRectMake(0, frameHeight / 5, 3 * frameWidth / 4, 3 * frameHeight / 4)];
        lemonadeStand.image=[UIImage imageNamed:@"lemonade-stand.png"];
        [self addSubview:lemonadeStand];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * frameWidth / 5, 7.3 * frameHeight / 10, frameWidth / 4, frameHeight / 4)];
        CGFloat price = [dataStore.getPrice floatValue];
        NSAssert(price >= 0, @"Negative price (%0.2f)", price);
        priceLabel.text = [NSString stringWithFormat:@"$%0.2f", price];
        [priceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [self addSubview:priceLabel];
        
        UIImageView *grass = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6 * frameHeight / 7, frameWidth, frameHeight / 7)];
        [grass setImage:[UIImage imageNamed:@"grass-foreground"]];
        [self addSubview:grass];
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
