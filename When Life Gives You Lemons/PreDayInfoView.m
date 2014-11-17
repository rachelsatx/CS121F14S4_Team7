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
    UIImageView* _weatherImageView;
}
@end

@implementation PreDayInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetWidth(self.frame);
        
        // Create Decrement Price Button
        CGRect decrementPriceButtonFrame = CGRectMake(width/2 - 100, height/2 - 20, 20, 20); // magic numbers
        UIButton* decrementPriceButton = [[UIButton alloc] initWithFrame:decrementPriceButtonFrame];
        [decrementPriceButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [decrementPriceButton addTarget:self action:@selector(decrementPrice:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:decrementPriceButton];
        
        // Create Price Label
        CGRect priceLabelFrame = CGRectMake(width/2- 80, height/2 - 20, 120, 20); // magic numbers
        _priceLabel = [[UILabel alloc] initWithFrame:priceLabelFrame];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_priceLabel];
        [self updatePriceLabel];
        
        // Create Increment Price Button
        CGRect incrementPriceButtonFrame = CGRectMake(width/2 + 100, height/2 - 20, 20, 20); // magic numbers
        UIButton* incrementPriceButton = [[UIButton alloc] initWithFrame:incrementPriceButtonFrame];
        [incrementPriceButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [incrementPriceButton addTarget:self action:@selector(incrementPrice:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:incrementPriceButton];
        
        // Create Weather Label
        CGRect weatherLabelFrame = CGRectMake(width/2, height/2 + 20, 80, 20); // magic numbers
        _weatherLabel = [[UILabel alloc] initWithFrame:weatherLabelFrame];
        [_weatherLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_weatherLabel];
        
        // Create Weather Image
        CGRect weatherImageViewFrame = CGRectMake(width/2, height/2 + 40, 100, 100); // magic numbers
        _weatherImageView = [[UIImageView alloc] initWithFrame:weatherImageViewFrame];
        [self addSubview:_weatherImageView];
        [self updateWeather];

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

- (void)updateWeather
{
    Weather weather = [self.delegate getWeather];
    if (weather == Sunny) {
        [_weatherLabel setText:@"Sunny"];
        [_weatherImageView setImage:[UIImage imageNamed:@"sun"]];
    }
    else if (weather == Cloudy) {
        [_weatherLabel setText:@"Cloudy"];
        [_weatherImageView setImage:[UIImage imageNamed:@"cloud"]];
    }
    else if (weather == Raining) {
        [_weatherLabel setText:@"Rainy"];
        [_weatherImageView setImage:[UIImage imageNamed:@"rain"]];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
