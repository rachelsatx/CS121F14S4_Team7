//
//  PreDayRecipeView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/22/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayRecipeView.h"

@interface PreDayRecipeView () {
    UILabel* _lemonsAmountLabel;
    UILabel* _sugarAmountLabel;
    UILabel* _iceAmountLabel;
    UILabel* _waterAmountLabel;
}
@end

@implementation PreDayRecipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor* backgroundColor = [UIColor colorWithRed:255.0/255 green:182.0/255 blue:193.0/255 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetWidth(self.frame);
        CGFloat borderThickness = (height / 8) < (width / 8) ? (height / 8) : (width / 8);
        CGFloat ingredientSize = (height / 4) < (width / 2) ? (height / 4) : (width / 2);
        CGFloat buttonSize = ingredientSize / 4;
        CGFloat fontSize = 25;
        
        // create title of view
        CGRect titleFrame = CGRectMake(0, 0, width, borderThickness);
        UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = @"Recipe:";
        [title setFont:[UIFont systemFontOfSize:(fontSize + 5)]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:title];
        
        // create lemon section
        CGRect lemonImageFrame = CGRectMake(borderThickness, borderThickness, ingredientSize, ingredientSize);
        UIImageView* lemonImage = [[UIImageView alloc] initWithFrame:lemonImageFrame];
        [lemonImage setImage:[UIImage imageNamed:@"lemon-slice"]];
        [self addSubview:lemonImage];
        
        CGRect lemonNameLabelFrame = CGRectMake(width / 2, borderThickness, width / 4, height / 4);
        UILabel* lemonNameLabel = [[UILabel alloc] initWithFrame:lemonNameLabelFrame];
        [lemonNameLabel setText:@"Lemons %"];
        [lemonNameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [lemonNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lemonNameLabel];
        
        CGRect lemonUpButtonFrame = CGRectMake(3 * width / 4, borderThickness, buttonSize, buttonSize);
        UIButton* lemonUpButton = [[UIButton alloc] initWithFrame:lemonUpButtonFrame];
        [lemonUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [lemonUpButton addTarget:self
                          action:@selector(incrementLemons:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lemonUpButton];
        
        CGRect lemonAmountLabelFrame = CGRectMake(3 * width / 4, borderThickness + buttonSize, buttonSize, buttonSize);
        _lemonsAmountLabel = [[UILabel alloc] initWithFrame:lemonAmountLabelFrame];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getLemonsPercentage] floatValue] * 100]];
        [_lemonsAmountLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [_lemonsAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_lemonsAmountLabel];
        
        CGRect lemonDownButtonFrame = CGRectMake(3 * width / 4, borderThickness + 2 * buttonSize, buttonSize, buttonSize);
        UIButton* lemonDownButton = [[UIButton alloc] initWithFrame:lemonDownButtonFrame];
        [lemonDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [lemonDownButton addTarget:self
                            action:@selector(decrementLemons:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lemonDownButton];
        
        // create sugar section
        CGRect sugarImageFrame = CGRectMake(borderThickness, borderThickness + ingredientSize, ingredientSize, ingredientSize);
        UIImageView* sugarImage = [[UIImageView alloc] initWithFrame:sugarImageFrame];
        [sugarImage setImage:[UIImage imageNamed:@"sugar"]];
        [self addSubview:sugarImage];
        
        CGRect sugarNameLabelFrame = CGRectMake(width / 2, borderThickness + ingredientSize, width / 4, height / 4);
        UILabel* sugarNameLabel = [[UILabel alloc] initWithFrame:sugarNameLabelFrame];
        [sugarNameLabel setText:@"Sugar %"];
        [sugarNameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [sugarNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:sugarNameLabel];
        
        CGRect sugarUpButtonFrame = CGRectMake(3 * width / 4, borderThickness + ingredientSize, buttonSize, buttonSize);
        UIButton* sugarUpButton = [[UIButton alloc] initWithFrame:sugarUpButtonFrame];
        [sugarUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [sugarUpButton addTarget:self
                          action:@selector(incrementSugar:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sugarUpButton];
        
        CGRect sugarAmountLabelFrame = CGRectMake(3 * width / 4, borderThickness + ingredientSize + buttonSize, buttonSize, buttonSize);
        _sugarAmountLabel = [[UILabel alloc] initWithFrame:sugarAmountLabelFrame];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getSugarPercentage] floatValue] * 100]];
        [_sugarAmountLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [_sugarAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_sugarAmountLabel];
        
        CGRect sugarDownButtonFrame = CGRectMake(3 * width / 4, borderThickness + ingredientSize + 2 * buttonSize, buttonSize, buttonSize);
        UIButton* sugarDownButton = [[UIButton alloc] initWithFrame:sugarDownButtonFrame];
        [sugarDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [sugarDownButton addTarget:self
                            action:@selector(decrementSugar:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sugarDownButton];
        
        // create ice section
        CGRect iceImageFrame = CGRectMake(borderThickness, borderThickness + 2 * ingredientSize, ingredientSize, ingredientSize);
        UIImageView* iceImage = [[UIImageView alloc] initWithFrame:iceImageFrame];
        [iceImage setImage:[UIImage imageNamed:@"ice"]];
        [self addSubview:iceImage];
        
        CGRect iceNameLabelFrame = CGRectMake(width / 2, borderThickness + 2 * ingredientSize, width / 4, height / 4);
        UILabel* iceNameLabel = [[UILabel alloc] initWithFrame:iceNameLabelFrame];
        [iceNameLabel setText:@"Ice %"];
        [iceNameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [iceNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:iceNameLabel];
        
        CGRect iceUpButtonFrame = CGRectMake(3 * width / 4, borderThickness + 2 * ingredientSize, buttonSize, buttonSize);
        UIButton* iceUpButton = [[UIButton alloc] initWithFrame:iceUpButtonFrame];
        [iceUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [iceUpButton addTarget:self
                        action:@selector(incrementIce:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iceUpButton];
        
        CGRect iceAmountLabelFrame = CGRectMake(3 * width / 4, borderThickness + 2 * ingredientSize + buttonSize, buttonSize, buttonSize);
        _iceAmountLabel = [[UILabel alloc] initWithFrame:iceAmountLabelFrame];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getIcePercentage] floatValue] * 100]];
        [_iceAmountLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [_iceAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_iceAmountLabel];
        
        CGRect iceDownButtonFrame = CGRectMake(3 * width / 4, borderThickness + 2 * ingredientSize + 2 * buttonSize, buttonSize, buttonSize);
        UIButton* iceDownButton = [[UIButton alloc] initWithFrame:iceDownButtonFrame];
        [iceDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [iceDownButton addTarget:self
                          action:@selector(decrementIce:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iceDownButton];
        
        // create water section
        CGRect waterImageFrame = CGRectMake(borderThickness, borderThickness + 3 * ingredientSize, ingredientSize, ingredientSize);
        UIImageView* waterImage = [[UIImageView alloc] initWithFrame:waterImageFrame];
        [waterImage setImage:[UIImage imageNamed:@"water"]];
        [self addSubview:waterImage];
        
        CGRect waterNameLabelFrame = CGRectMake(width / 2, borderThickness + 3 * ingredientSize, width / 4, height / 4);
        UILabel* waterNameLabel = [[UILabel alloc] initWithFrame:waterNameLabelFrame];
        [waterNameLabel setText:@"Water %"];
        [waterNameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [waterNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:waterNameLabel];
        
        CGRect waterAmountLabelFrame = CGRectMake(3 * width / 4, borderThickness + 3 * ingredientSize + buttonSize, buttonSize, buttonSize);
        _waterAmountLabel = [[UILabel alloc] initWithFrame:waterAmountLabelFrame];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%f", [[self.delegate getWaterPercentage] floatValue] * 100]];
        [_waterAmountLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [_waterAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_waterAmountLabel];
    }
    return self;
}

- (void) updatePercentageLabels
{
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getLemonsPercentage] floatValue]]];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getSugarPercentage] floatValue]]];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getIcePercentage] floatValue]]];
    [_waterAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getWaterPercentage] floatValue]]];
}

- (void) incrementLemons:(id)sender
{
    NSNumber* water = [self.delegate getWaterPercentage];
    if ([water floatValue] >= .01) {
        water = [NSNumber numberWithFloat:[water floatValue] - .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    
        NSNumber* lemons = [self.delegate getLemonsPercentage];
        lemons = [NSNumber numberWithFloat:[lemons floatValue] + .01];
        [self.delegate setLemonsPercentage:lemons];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [lemons floatValue] * 100]];
    }
}

- (void) decrementLemons:(id)sender
{
    NSNumber* lemons = [self.delegate getLemonsPercentage];
    if ([lemons floatValue] >= .01) {
        lemons = [NSNumber numberWithFloat:[lemons floatValue] - .01];
        [self.delegate setLemonsPercentage:lemons];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [lemons floatValue] * 100]];
    
        NSNumber* water = [self.delegate getWaterPercentage];
        water = [NSNumber numberWithFloat:[water floatValue] + .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    }
}

- (void) incrementSugar:(id)sender
{
    
    NSNumber* water = [self.delegate getWaterPercentage];
    if ([water floatValue] >= .01) {
        water = [NSNumber numberWithFloat:[water floatValue] - .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    
        NSNumber* sugar = [self.delegate getSugarPercentage];
        sugar = [NSNumber numberWithFloat:[sugar floatValue] + .01];
        [self.delegate setSugarPercentage:sugar];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [sugar floatValue] * 100]];
    }
}

- (void) decrementSugar:(id)sender
{
    NSNumber* sugar = [self.delegate getSugarPercentage];
    if ([sugar floatValue] >= .01) {
        sugar = [NSNumber numberWithFloat:[sugar floatValue] - .01];
        [self.delegate setSugarPercentage:sugar];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [sugar floatValue] * 100]];
    
        NSNumber* water = [self.delegate getWaterPercentage];
        water = [NSNumber numberWithFloat:[water floatValue] + .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    }
}

- (void) incrementIce:(id)sender
{
    NSNumber* water = [self.delegate getWaterPercentage];
    if ([water floatValue] >= .01) {
        water = [NSNumber numberWithFloat:[water floatValue] - .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    
        NSNumber* ice = [self.delegate getIcePercentage];
        ice = [NSNumber numberWithFloat:[ice floatValue] + .01];
        [self.delegate setIcePercentage:ice];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [ice floatValue] * 100]];
    }
}

- (void) decrementIce:(id)sender
{
    NSNumber* ice = [self.delegate getIcePercentage];
    if ([ice floatValue] >= .01) {
        ice = [NSNumber numberWithFloat:[ice floatValue] - .01];
        [self.delegate setIcePercentage:ice];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [ice floatValue] * 100]];
    
        NSNumber* water = [self.delegate getWaterPercentage];
        water = [NSNumber numberWithFloat:[water floatValue] + .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    }
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
