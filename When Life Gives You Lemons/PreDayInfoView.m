//
//  PreDayInfoView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 11/16/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayInfoView.h"

@interface PreDayInfoView () {
    UILabel* _priceLabel;
    UILabel* _weatherLabel;
    UILabel* _dayLabel;
    UILabel* _makeableCupsLabel;
    UIImageView* _weatherImageView;
}
@end

@implementation PreDayInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        CGFloat labelHeight = frameHeight / 9;
        CGFloat imageSize = frameHeight < frameWidth ? frameHeight / 4 : frameWidth / 4;
        CGFloat buttonSize = frameHeight < frameWidth ? frameHeight / 10 : frameWidth / 10;
        
        CGFloat fontSize = 25;
        NSString* fontName = @"Chalkduster";
        
        // Set background image to a spiral notebook
        self.backgroundColor = [UIColor whiteColor];
        UIGraphicsBeginImageContext(self.frame.size);
        [[UIImage imageNamed:@"spiral-notebook"] drawInRect:self.bounds];
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundColor = [UIColor colorWithPatternImage:image];
        
        // Create Day Label
        CGRect dayLabelFrame = CGRectMake(0,
                                          0,
                                          frameWidth,
                                          labelHeight);
        _dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
        [_dayLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_dayLabel setTextAlignment:NSTextAlignmentCenter];
        _dayLabel.numberOfLines = 0;
        [self updateDayLabel];
        [self addSubview:_dayLabel];
        
        // Create Weather Label
        CGRect weatherLabelFrame = CGRectMake(0,
                                              labelHeight,
                                              frameWidth,
                                              labelHeight);
        _weatherLabel = [[UILabel alloc] initWithFrame:weatherLabelFrame];
        [_weatherLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_weatherLabel setTextAlignment:NSTextAlignmentCenter];
        _weatherLabel.numberOfLines = 0;
        [self addSubview:_weatherLabel];
        
        // Create Weather Image
        CGRect weatherImageViewFrame = CGRectMake((frameWidth - imageSize) / 2,
                                                  2 * labelHeight,
                                                  imageSize,
                                                  imageSize);
        _weatherImageView = [[UIImageView alloc] initWithFrame:weatherImageViewFrame];
        [self updateWeather];
        [self addSubview:_weatherImageView];
        
        // Create Makable Cups Label
        CGRect makeableCupsLabelFrame = CGRectMake(0,
                                                   (2 * labelHeight) + imageSize,
                                                   frameWidth,
                                                   2 * labelHeight);
        _makeableCupsLabel = [[UILabel alloc] initWithFrame:makeableCupsLabelFrame];
        [_makeableCupsLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_makeableCupsLabel setTextAlignment:NSTextAlignmentCenter];
        _makeableCupsLabel.numberOfLines = 0;
        [self updateMakeableCupsLabel];
        [self addSubview:_makeableCupsLabel];
        
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
        [_priceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        _priceLabel.numberOfLines = 0;
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
    
    return self;
}

- (void)incrementPrice:(id)sender
{
    
    [self.delegate incrementPrice:sender];
    [self updatePriceLabel];
}

- (void)decrementPrice:(id)sender
{
    [self.delegate decrementPrice:sender];
    [self updatePriceLabel];
}

- (void)updatePriceLabel
{
    [_priceLabel setText:[NSString stringWithFormat:@"Price: $%.2f", [[self.delegate getPrice] floatValue]]];
}

- (void)updateDayLabel
{
    DayOfWeek dayOfWeek = [self.delegate getDayOfWeek];
    NSLog(@"%d", dayOfWeek);
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
    [_makeableCupsLabel setText:[NSString stringWithFormat:@"With your current inventory and recipe, \n you can make a total of %d cups of lemonade.", [self.delegate getMakableCups]]];
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
