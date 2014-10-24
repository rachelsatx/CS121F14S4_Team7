//
//  PreDayInventoryView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayInventoryView.h"

@interface PreDayInventoryView () {
    UILabel* _lemonsAmountLabel;
    UILabel* _sugarAmountLabel;
    UILabel* _iceAmountLabel;
    UILabel* _cupsAmountLabel;
}
@end

@implementation PreDayInventoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor* backgroundColor = [UIColor colorWithRed:238.0/255 green:213.0/255 blue:183.0/255 alpha:1.0];
        [self setBackgroundColor:backgroundColor];
        
        // create column of ingredients
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetWidth(self.frame);
        CGFloat borderThickness = (height / 8) < (width / 8) ? (height / 8) : (width / 8);
        CGFloat ingredientSize = (height / 4) < (width / 2) ? (height / 4) : (width / 2);
        CGFloat buttonSize = ingredientSize / 3;
        CGFloat fontSize = 25;
        
        // create title of view
        CGRect titleFrame = CGRectMake(0, 0, width, borderThickness);
        UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = @"Inventory:";
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
        [lemonNameLabel setText:@"Lemons"];
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
        
        CGRect lemonAmountLabelFrame = CGRectMake(3 * width / 4 - (buttonSize / 2), borderThickness + buttonSize, 2 * buttonSize, buttonSize);
        _lemonsAmountLabel = [[UILabel alloc] initWithFrame:lemonAmountLabelFrame];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getLemons] floatValue]]];
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
        [sugarNameLabel setText:@"Sugar"];
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
        
        CGRect sugarAmountLabelFrame = CGRectMake(3 * width / 4 - (buttonSize / 2), borderThickness + ingredientSize + buttonSize, 2 * buttonSize, buttonSize);
        _sugarAmountLabel = [[UILabel alloc] initWithFrame:sugarAmountLabelFrame];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getSugar] floatValue]]];
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
        [iceNameLabel setText:@"Ice"];
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
        
        CGRect iceAmountLabelFrame = CGRectMake(3 * width / 4 - (buttonSize / 2), borderThickness + 2 * ingredientSize + buttonSize, 2 * buttonSize, buttonSize);
        _iceAmountLabel = [[UILabel alloc] initWithFrame:iceAmountLabelFrame];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getIce] floatValue]]];
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
        
        // create cup section
        CGRect cupImageFrame = CGRectMake(borderThickness, borderThickness + 3 * ingredientSize, ingredientSize, ingredientSize);
        UIImageView* cupImage = [[UIImageView alloc] initWithFrame:cupImageFrame];
        [cupImage setImage:[UIImage imageNamed:@"cup"]];
        [self addSubview:cupImage];
        
        CGRect cupNameLabelFrame = CGRectMake(width / 2, borderThickness + 3 * ingredientSize, width / 4, height / 4);
        UILabel* cupNameLabel = [[UILabel alloc] initWithFrame:cupNameLabelFrame];
        [cupNameLabel setText:@"Cups"];
        [cupNameLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [cupNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:cupNameLabel];
        
        CGRect cupUpButtonFrame = CGRectMake(3 * width / 4, borderThickness + 3 * ingredientSize, buttonSize, buttonSize);
        UIButton* cupUpButton = [[UIButton alloc] initWithFrame:cupUpButtonFrame];
        [cupUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [cupUpButton addTarget:self
                     action:@selector(incrementCups:)
                     forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cupUpButton];
        
        CGRect cupsAmountLabelFrame = CGRectMake(3 * width / 4 - (buttonSize / 2), borderThickness + 3 * ingredientSize + buttonSize, 2 * buttonSize, buttonSize);
        _cupsAmountLabel = [[UILabel alloc] initWithFrame:cupsAmountLabelFrame];
        [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [[self.delegate getCups] intValue]]];
        [_cupsAmountLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [_cupsAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_cupsAmountLabel];
        
        CGRect cupDownButtonFrame = CGRectMake(3 * width / 4, borderThickness + 3 * ingredientSize + 2 * buttonSize, buttonSize, buttonSize);
        UIButton* cupDownButton = [[UIButton alloc] initWithFrame:cupDownButtonFrame];
        [cupDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [cupDownButton addTarget:self
                       action:@selector(decrementCups:)
                       forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cupDownButton];        
    }
    return self;
}

- (void) updateAmountLabels
{
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getLemons] floatValue]]];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getSugar] floatValue]]];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getIce] floatValue]]];
    [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [[self.delegate getCups] intValue]]];
}

- (void) incrementLemons:(id)sender
{
    NSNumber* lemons = [self.delegate getLemons];
    lemons = [NSNumber numberWithFloat:[lemons floatValue] + 1.0];
    [self.delegate setLemons:lemons];
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [lemons floatValue]]];
}

- (void) decrementLemons:(id)sender
{
    NSNumber* lemons = [self.delegate getLemons];
    if ([lemons floatValue] >= 1.0){
        lemons = [NSNumber numberWithFloat:[lemons floatValue] - 1.0];
        [self.delegate setLemons:lemons];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [lemons floatValue]]];
    }
}

- (void) incrementSugar:(id)sender
{
    NSNumber* sugar = [self.delegate getSugar];
    sugar = [NSNumber numberWithFloat:[sugar floatValue] + 1.0];
    [self.delegate setSugar:sugar];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [sugar floatValue]]];}

- (void) decrementSugar:(id)sender
{
    NSNumber* sugar = [self.delegate getSugar];
    if ([sugar floatValue] >= 1.0) {
        sugar = [NSNumber numberWithFloat:[sugar floatValue] - 1.0];
        [self.delegate setSugar:sugar];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [sugar floatValue]]];
    }
}

- (void) incrementIce:(id)sender
{
    NSNumber* ice = [self.delegate getIce];
    ice = [NSNumber numberWithFloat:[ice floatValue] + 1.0];
    [self.delegate setIce:ice];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [ice floatValue]]];
}

- (void) decrementIce:(id)sender
{
    NSNumber* ice = [self.delegate getIce];
    if ([ice floatValue] >= 1.0) {
        ice = [NSNumber numberWithFloat:[ice floatValue] - 1.0];
        [self.delegate setIce:ice];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [ice floatValue]]];
    }
}

- (void) incrementCups:(id)sender
{
    NSNumber* cups = [self.delegate getCups];
    cups = [NSNumber numberWithFloat:[cups intValue] + 1];
    [self.delegate setCups:cups];
    [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [cups intValue]]];
}

- (void) decrementCups:(id)sender
{
    NSNumber* cups = [self.delegate getCups];
    if ([cups intValue] >= 1) {
        cups = [NSNumber numberWithFloat:[cups intValue] - 1];
        [self.delegate setCups:cups];
        [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [cups intValue]]];
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
