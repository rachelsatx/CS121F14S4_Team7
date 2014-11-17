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
    UILabel* _makableCupsLabel;
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
        
        // Create Makable Cups Label
        CGRect makableCupsLabelFrame = CGRectMake(0, height/2, width, 20); // magic numbers
        _makableCupsLabel = [[UILabel alloc] initWithFrame:makableCupsLabelFrame];
        [_makableCupsLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_makableCupsLabel];
        [self updateMakableCupsLabel];
        
        // Create Day Label
        CGRect dayLabelFrame = CGRectMake(0, height/2 + 180, width, 20); // magic numbers
        _dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
        [_dayLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_dayLabel];
        [self updateDayLabel];

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

- (void)updateMakableCupsLabel
{
    [_makableCupsLabel setText:[NSString stringWithFormat:@"You can make a total of %d cups of lemonade.", [[self.delegate getMakableCups] intValue]]];
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
