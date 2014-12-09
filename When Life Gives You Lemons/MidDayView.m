//
//  MidDayView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MidDayView.h"
#import "DataStore.h"
#import "SunnyScene.h"
#import "CloudyScene.h"
#import "RainyScene.h"

@interface MidDayView() {
    // Constants
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat fontSize;
    NSString *fontName;

    SKView *_animation;
    SKScene *_weatherScene;
}
@end

@implementation MidDayView

- (id)initWithFrame:(CGRect)frame andDataStore:(DataStore *)dataStore
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        self.backgroundColor = [UIColor clearColor];
        [self setBackgroundFromWeather:dataStore.getWeather];
        
        [self addImages:dataStore];
    }
    
    return self;
}

- (void)setConstants
{
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetHeight(self.frame);
    
    fontSize = 50;
    fontName = @"Chalkduster";
}

- (void)setBackgroundFromWeather:(Weather)weather
{
    // Set animation according to weather
    _animation = [[SKView alloc] initWithFrame:self.bounds];
    [self addSubview:_animation];
    
    if (weather == Sunny) {
        SunnyScene* sunScene = [[SunnyScene alloc]initWithSize:CGSizeMake(frameWidth, frameHeight)];
        _weatherScene = sunScene;
    } else if (weather == Cloudy) {
        CloudyScene *cloudScene = [[CloudyScene alloc]initWithSize:CGSizeMake(frameWidth, frameHeight)];
        _weatherScene = cloudScene;
    } else if (weather == Raining) {
        RainyScene *rainScene = [[RainyScene alloc]initWithSize:CGSizeMake(frameWidth, frameHeight)];
        _weatherScene = rainScene;
    }
    // Display the appropriate weather scene.
    [_animation presentScene:_weatherScene];
}

- (void)addImages:(DataStore *)dataStore
{
    // Set grass background - behind stand
    CGRect grassBackgroundFrame = CGRectMake(0,
                                             2 * frameHeight / 3,
                                             frameWidth,
                                             frameHeight / 3);
    UIImageView *grassBackground = [[UIImageView alloc] initWithFrame:grassBackgroundFrame];
    [grassBackground setImage:[UIImage imageNamed:@"grass-background"]];
    [self addSubview:grassBackground];
    
    // Add vendor image behind lemonade stand
    CGRect vendorFrame = CGRectMake(frameWidth / 4,
                                    frameHeight / 2,
                                    frameWidth / 4,
                                    frameHeight / 4);
    UIImageView *vendor = [[UIImageView alloc] initWithFrame:vendorFrame];
    [vendor setImage:[UIImage imageNamed:@"person-pink"]];
    [self addSubview:vendor];
    
    // Add lemonade stand image in bottom left
    CGRect lemonadeStandFrame = CGRectMake(0,
                                           frameHeight / 5,
                                           3 * frameWidth / 4,
                                           3 * frameHeight / 4);
    UIImageView *lemonadeStand =[[UIImageView alloc] initWithFrame:lemonadeStandFrame];
    [lemonadeStand setImage:[UIImage imageNamed:@"lemonade-stand"]];
    [self addSubview:lemonadeStand];
    
    // Add price on the lemonade stand to reflect what the user chose
    CGRect priceLabelFrame = CGRectMake(2 * frameWidth / 5,
                                        7.3 * frameHeight / 10,
                                        frameWidth / 4,
                                        frameHeight / 4);
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceLabelFrame];
    CGFloat price = [dataStore.getPrice floatValue];
    NSAssert(price >= 0, @"Negative price (%0.2f)", price);
    [priceLabel setText:[NSString stringWithFormat:@"$%0.2f", price]];
    [priceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [self addSubview:priceLabel];
    
    // Add customers next to the lemonade stand
    CGRect customer1Frame = CGRectMake(2 * frameWidth / 3,
                                       3 * frameHeight / 5,
                                       frameWidth / 4,
                                       frameHeight / 4);
    UIImageView *customer1 = [[UIImageView alloc] initWithFrame:customer1Frame];
    [customer1 setImage:[UIImage imageNamed:@"person-navy"]];
    [self addSubview:customer1];
    
    CGRect customer2Frame = CGRectMake(3 * frameWidth / 4,
                                       2 * frameHeight / 3,
                                       frameWidth / 4,
                                       frameHeight / 4);
    UIImageView *customer2 = [[UIImageView alloc] initWithFrame:customer2Frame];
    [customer2 setImage:[UIImage imageNamed:@"person-purple"]];
    [self addSubview:customer2];
    
    CGRect customer3Frame = CGRectMake(2 * frameWidth / 3,
                                       3 * frameHeight / 4,
                                       frameWidth / 4,
                                       frameHeight / 4);
    UIImageView *customer3 = [[UIImageView alloc] initWithFrame:customer3Frame];
    [customer3 setImage:[UIImage imageNamed:@"person-red"]];
    [self addSubview:customer3];
    
    // Set grass foreground - in front of stand
    CGRect grassFrame = CGRectMake(0,
                                   6 * frameHeight / 7,
                                   frameWidth,
                                   frameHeight / 7);
    UIImageView *grass = [[UIImageView alloc] initWithFrame:grassFrame];
    [grass setImage:[UIImage imageNamed:@"grass-foreground"]];
    [self addSubview:grass];
}

- (void) releaseAnimation
{
    [_weatherScene removeAllActions];
    [_weatherScene removeAllChildren];
    
    _weatherScene = nil;
    
    [((SKView* )_animation) presentScene:nil];
    
    [_animation removeFromSuperview];
    _animation = nil;   
}

@end
