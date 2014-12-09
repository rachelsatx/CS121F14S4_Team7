//
//  PreDayInfoView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 11/16/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayInfoView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PreDayInfoView () {
    UILabel* _priceLabel;
    UILabel* _weatherLabel;
    UILabel* _dayLabel;
    UILabel* _makeableCupsLabel;
    UIImageView* _weatherImageView;
    
    // Constants
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat labelHeight;
    CGFloat imageSize;
    CGFloat buttonSize;
    CGFloat borderWidth;
    
    CGFloat fontSize;
    NSString* fontName;
    
    // Sounds
    SystemSoundID clickSound;
}
@end

@implementation PreDayInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        [self setBackground];
        
        [self addDayLabel];
        [self addWeather];
        [self addMakeableCupsLabel];
        [self addPrice];
        
        [self initializeSounds];
    }
    
    return self;
}

- (void)setConstants
{
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetHeight(self.frame);
    
    labelHeight = frameHeight / 9;
    imageSize = frameHeight < frameWidth ? frameHeight / 4 : frameWidth / 4;
    buttonSize = frameHeight < frameWidth ? frameHeight / 10 : frameWidth / 10;
    borderWidth = 2;
    
    fontSize = 25;
    fontName = @"Chalkduster";
}

- (void)setBackground
{
    self.layer.borderWidth = borderWidth;
    self.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:200.0/255 alpha:1.0];
}

- (void)addDayLabel
{
    CGRect dayLabelFrame = CGRectMake(0,
                                      0,
                                      frameWidth,
                                      labelHeight);
    _dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
    [self formatLabel:_dayLabel];
    [self updateDayLabel];
    [self addSubview:_dayLabel];
}

- (void)addWeather
{
    // Add weather label
    CGRect weatherLabelFrame = CGRectMake(0,
                                          labelHeight,
                                          frameWidth,
                                          labelHeight);
    _weatherLabel = [[UILabel alloc] initWithFrame:weatherLabelFrame];
    [self formatLabel:_weatherLabel];
    [self addSubview:_weatherLabel];
    
    // Add weather image
    CGRect weatherImageViewFrame = CGRectMake((frameWidth - imageSize) / 2,
                                              2 * labelHeight,
                                              imageSize,
                                              imageSize);
    _weatherImageView = [[UIImageView alloc] initWithFrame:weatherImageViewFrame];
    [self updateWeather];
    [self addSubview:_weatherImageView];
}

- (void)addMakeableCupsLabel
{
    CGRect makeableCupsLabelFrame = CGRectMake(0,
                                               (2 * labelHeight) + imageSize,
                                               frameWidth,
                                               2 * labelHeight);
    _makeableCupsLabel = [[UILabel alloc] initWithFrame:makeableCupsLabelFrame];
    [self formatLabel:_makeableCupsLabel];
    [self updateMakeableCupsLabel];
    [self addSubview:_makeableCupsLabel];
}

- (void)addPrice
{
    // Create Increment Price Button
    CGRect incrementPriceButtonFrame = CGRectMake((frameWidth - buttonSize) / 2,
                                                  (4 * labelHeight) + imageSize,
                                                  buttonSize,
                                                  buttonSize);
    UIButton* incrementPriceButton = [[UIButton alloc] initWithFrame:incrementPriceButtonFrame];
    [incrementPriceButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incrementPriceButton addTarget:self action:@selector(incrementPrice:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:incrementPriceButton];
    
    // Create Price Label
    CGRect priceLabelFrame = CGRectMake(0,
                                        (5 * labelHeight) + imageSize,
                                        frameWidth,
                                        labelHeight);
    _priceLabel = [[UILabel alloc] initWithFrame:priceLabelFrame];
    [self formatLabel:_priceLabel];
    [self updatePriceLabel];
    [self addSubview:_priceLabel];
    
    // Create Decrement Price Button
    CGRect decrementPriceButtonFrame = CGRectMake((frameWidth - buttonSize) / 2,
                                                  (6 * labelHeight) + imageSize,
                                                  buttonSize,
                                                  buttonSize);
    UIButton* decrementPriceButton = [[UIButton alloc] initWithFrame:decrementPriceButtonFrame];
    [decrementPriceButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decrementPriceButton addTarget:self action:@selector(decrementPrice:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:decrementPriceButton];
}

- (void)formatLabel:(UILabel *)label
{
    [label setFont:[UIFont fontWithName:fontName size:fontSize]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.numberOfLines = 0;
}

- (void)initializeSounds
{
    // Taken from http://soundbible.com/1705-Click2.html
    // Under creative commons attribution 3.0
    [self setUpSound:@"click" forLocation:&clickSound];
}

- (void)setUpSound:(NSString*)fileName forLocation:(SystemSoundID*)location {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, location);
}

- (void)incrementPrice:(id)sender
{
    [self.delegate incrementPrice:sender];
    [self updatePriceLabel];
    AudioServicesPlaySystemSound(clickSound);
}

- (void)decrementPrice:(id)sender
{
    [self.delegate decrementPrice:sender];
    [self updatePriceLabel];
    AudioServicesPlaySystemSound(clickSound);
}

- (void)updatePriceLabel
{
    [_priceLabel setText:[NSString stringWithFormat:@"Price: $%.2f", [[self.delegate getPrice] floatValue]]];
}

- (void)updateDayLabel
{
    DayOfWeek dayOfWeek = [self.delegate getDayOfWeek];
    if (dayOfWeek == Monday) {
        [_dayLabel setText:@"Today is Monday."];
    }
    else if (dayOfWeek == Tuesday) {
        [_dayLabel setText:@"Today is Tuesday."];
    }
    else if (dayOfWeek == Wednesday) {
        [_dayLabel setText:@"Today is Wednesday."];
    }
    else if (dayOfWeek == Thursday) {
        [_dayLabel setText:@"Today is Thursday."];
    }
    else if (dayOfWeek == Friday) {
        [_dayLabel setText:@"Today is Friday."];
    }
    else if (dayOfWeek == Saturday) {
        [_dayLabel setText:@"Today is Saturday. Expect a lot of customers!"];
    }
    else if (dayOfWeek == Sunday) {
        [_dayLabel setText:@"Today is Sunday. Expect a lot of customers!"];
    }
}

- (void)updateMakeableCupsLabel
{
    NSInteger makeableCups = [self.delegate getMakableCups];
    NSInteger digitsInMakeableCups = (makeableCups == 0) ? 1 : log10(makeableCups) + 1;
    
    NSMutableAttributedString *makeableCupsText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"With your current inventory and recipe, \n you can make a total of %ld cups of lemonade.", (long)[self.delegate getMakableCups]]];
    
    [makeableCupsText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(66, digitsInMakeableCups + 5)];
    
    [_makeableCupsLabel setAttributedText: makeableCupsText];
}

- (void)updateWeather
{
    Weather weather = [self.delegate getWeather];
    if (weather == Sunny) {
        [_weatherLabel setText:@"The weather today is sunny."];
        [_weatherImageView setImage:[UIImage imageNamed:@"sun"]];
    }
    else if (weather == Cloudy) {
        [_weatherLabel setText:@"The weather today is cloudy."];
        [_weatherImageView setImage:[UIImage imageNamed:@"cloud"]];
    }
    else if (weather == Raining) {
        [_weatherLabel setText:@"The weather today is rainy."];
        [_weatherImageView setImage:[UIImage imageNamed:@"rain"]];
    }
}

@end
