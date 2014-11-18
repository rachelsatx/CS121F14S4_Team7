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
    
    UILabel* _moneyLabel;
    
    UILabel* _lemonsPriceLabel;
    UILabel* _sugarPriceLabel;
    UILabel* _icePriceLabel;
    UILabel* _cupsPriceLabel;
    
    int _amountMultiplier;
    UIButton* _selectedButton;
}
@end

@implementation PreDayInventoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetWidth(self.frame);
        
        CGFloat borderThickness = (frameHeight < frameWidth) ? (frameHeight / 5) : (frameWidth / 5);
        CGFloat ingredientColumnWidth = frameWidth / 2;
        CGFloat labelColumnWidth = frameWidth / 4;
        CGFloat ingredientSize = ((frameHeight - borderThickness) / 4) < (frameWidth / 2) ?
                                 ((frameHeight - borderThickness) / 4) : (frameWidth / 2);
        CGFloat buttonSize = ingredientSize / 3;
        CGFloat labelWidth = frameWidth / 4;
        CGFloat labelHeight = frameHeight / 8;
        
        CGFloat fontSize = 30;
        CGFloat titleSizeIncrease = 5;
        NSString* fontName = @"Papyrus";
        
        // Set background image to a paper bag
        UIGraphicsBeginImageContext(self.frame.size);
        [[UIImage imageNamed:@"bag"] drawInRect:self.bounds];
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundColor = [UIColor colorWithPatternImage:image];
        
        // Create title of view
        CGRect titleFrame = CGRectMake(0,
                                       0,
                                       frameWidth,
                                       borderThickness / 2);
        UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = @"Inventory:";
        [title setFont:[UIFont fontWithName:fontName size:(fontSize + titleSizeIncrease)]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:title];
        
        // Create multipliers for buy amount (1x, 10x, 100x)
        CGRect oneButtonFrame = CGRectMake(0,
                                           borderThickness / 2,
                                           frameWidth / 3,
                                           borderThickness / 2);
        UIButton* oneButton = [[UIButton alloc] initWithFrame:oneButtonFrame];
        [oneButton setTitle:@"1x" forState:UIControlStateNormal];
        [[oneButton titleLabel] setFont:[UIFont fontWithName:fontName size:fontSize]];
        [oneButton setTag:1];
        [oneButton addTarget:self action:@selector(setAmountMultiplier:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:oneButton];
        _selectedButton = oneButton;
        [oneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _amountMultiplier = 1;
        
        CGRect tenButtonFrame = CGRectMake(frameWidth / 3,
                                           borderThickness / 2,
                                           frameWidth / 3,
                                           borderThickness / 2);
        UIButton* tenButton = [[UIButton alloc] initWithFrame:tenButtonFrame];
        [tenButton setTitle:@"10x" forState:UIControlStateNormal];
        [[tenButton titleLabel] setFont:[UIFont fontWithName:fontName size:fontSize]];
        [tenButton setTag:10];
        [tenButton addTarget:self action:@selector(setAmountMultiplier:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tenButton];
        
        CGRect hundredButtonFrame = CGRectMake(2 * frameWidth / 3,
                                               borderThickness / 2,
                                               frameWidth / 3,
                                               borderThickness / 2);
        UIButton* hundredButton = [[UIButton alloc] initWithFrame:hundredButtonFrame];
        [hundredButton setTitle:@"100x" forState:UIControlStateNormal];
        [[hundredButton titleLabel] setFont:[UIFont fontWithName:fontName size:fontSize]];
        [hundredButton setTag:100];
        [hundredButton addTarget:self action:@selector(setAmountMultiplier:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hundredButton];
        
        // Create lemon section
        CGRect lemonImageFrame = CGRectMake(borderThickness,
                                            borderThickness,
                                            ingredientSize,
                                            ingredientSize);
        UIImageView* lemonImage = [[UIImageView alloc] initWithFrame:lemonImageFrame];
        [lemonImage setImage:[UIImage imageNamed:@"lemon-slice"]];
        [self addSubview:lemonImage];
        
        CGRect lemonNameLabelFrame = CGRectMake(ingredientColumnWidth,
                                                borderThickness,
                                                labelWidth,
                                                labelHeight);
        UILabel* lemonNameLabel = [[UILabel alloc] initWithFrame:lemonNameLabelFrame];
        [lemonNameLabel setText:@"Lemons"];
        [lemonNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [lemonNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lemonNameLabel];
        
        CGRect lemonPriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                                 borderThickness + (2 * fontSize),
                                                 labelWidth,
                                                 labelHeight);
        _lemonsPriceLabel = [[UILabel alloc] initWithFrame:lemonPriceLabelFrame];
        [_lemonsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getLemonPrice] floatValue]]];
        [_lemonsPriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_lemonsPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_lemonsPriceLabel];
        
        CGRect lemonUpButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                               borderThickness,
                                               buttonSize,
                                               buttonSize);
        UIButton* lemonUpButton = [[UIButton alloc] initWithFrame:lemonUpButtonFrame];
        [lemonUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [lemonUpButton addTarget:self
                       action:@selector(incrementLemons:)
                       forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lemonUpButton];
        
        CGRect lemonAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                                  borderThickness + buttonSize,
                                                  3 * buttonSize,
                                                  buttonSize);
        _lemonsAmountLabel = [[UILabel alloc] initWithFrame:lemonAmountLabelFrame];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getLemons] floatValue]]];
        [_lemonsAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_lemonsAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_lemonsAmountLabel];
        
        CGRect lemonDownButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                                 borderThickness + (2 * buttonSize),
                                                 buttonSize,
                                                 buttonSize);
        UIButton* lemonDownButton = [[UIButton alloc] initWithFrame:lemonDownButtonFrame];
        [lemonDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [lemonDownButton addTarget:self
                         action:@selector(decrementLemons:)
                         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lemonDownButton];
        
        // Create sugar section
        CGRect sugarImageFrame = CGRectMake(borderThickness,
                                            borderThickness + ingredientSize,
                                            ingredientSize,
                                            ingredientSize);
        UIImageView* sugarImage = [[UIImageView alloc] initWithFrame:sugarImageFrame];
        [sugarImage setImage:[UIImage imageNamed:@"sugar"]];
        [self addSubview:sugarImage];
        
        CGRect sugarNameLabelFrame = CGRectMake(ingredientColumnWidth,
                                                borderThickness + ingredientSize,
                                                labelWidth,
                                                labelHeight);
        UILabel* sugarNameLabel = [[UILabel alloc] initWithFrame:sugarNameLabelFrame];
        [sugarNameLabel setText:@"Sugar"];
        [sugarNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [sugarNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:sugarNameLabel];
        
        CGRect sugarPriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                                 borderThickness + ingredientSize + (2 * fontSize),
                                                 labelWidth,
                                                 labelHeight);
        _sugarPriceLabel = [[UILabel alloc] initWithFrame:sugarPriceLabelFrame];
        [_sugarPriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getLemonPrice] floatValue]]];
        [_sugarPriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_sugarPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_sugarPriceLabel];
        
        CGRect sugarUpButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                               borderThickness + ingredientSize,
                                               buttonSize,
                                               buttonSize);
        UIButton* sugarUpButton = [[UIButton alloc] initWithFrame:sugarUpButtonFrame];
        [sugarUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [sugarUpButton addTarget:self
                        action:@selector(incrementSugar:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sugarUpButton];
        
        CGRect sugarAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                                  borderThickness + ingredientSize + buttonSize,
                                                  3 * buttonSize,
                                                  buttonSize);
        _sugarAmountLabel = [[UILabel alloc] initWithFrame:sugarAmountLabelFrame];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getSugar] floatValue]]];
        [_sugarAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_sugarAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_sugarAmountLabel];
        
        CGRect sugarDownButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                                 borderThickness + ingredientSize + (2 * buttonSize),
                                                 buttonSize,
                                                 buttonSize);
        UIButton* sugarDownButton = [[UIButton alloc] initWithFrame:sugarDownButtonFrame];
        [sugarDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [sugarDownButton addTarget:self
                          action:@selector(decrementSugar:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sugarDownButton];
        
        // Create ice section
        CGRect iceImageFrame = CGRectMake(borderThickness,
                                          borderThickness + (2 * ingredientSize),
                                          ingredientSize,
                                          ingredientSize);
        UIImageView* iceImage = [[UIImageView alloc] initWithFrame:iceImageFrame];
        [iceImage setImage:[UIImage imageNamed:@"ice"]];
        [self addSubview:iceImage];
        
        CGRect iceNameLabelFrame = CGRectMake(ingredientColumnWidth,
                                              borderThickness + (2 * ingredientSize),
                                              labelWidth,
                                              labelHeight);
        UILabel* iceNameLabel = [[UILabel alloc] initWithFrame:iceNameLabelFrame];
        [iceNameLabel setText:@"Ice"];
        [iceNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [iceNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:iceNameLabel];
        
        CGRect icePriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                               borderThickness + (2 * ingredientSize) + (2 * fontSize),
                                               labelWidth,
                                               labelHeight);
        _icePriceLabel = [[UILabel alloc] initWithFrame:icePriceLabelFrame];
        [_icePriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getIcePrice] floatValue]]];
        [_icePriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_icePriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_icePriceLabel];
        
        CGRect iceUpButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                             borderThickness + (2 * ingredientSize),
                                             buttonSize,
                                             buttonSize);
        UIButton* iceUpButton = [[UIButton alloc] initWithFrame:iceUpButtonFrame];
        [iceUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [iceUpButton addTarget:self
                        action:@selector(incrementIce:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iceUpButton];
        
        CGRect iceAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                                borderThickness + (2 * ingredientSize) + buttonSize,
                                                3 * buttonSize,
                                                buttonSize);
        _iceAmountLabel = [[UILabel alloc] initWithFrame:iceAmountLabelFrame];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getIce] floatValue]]];
        [_iceAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_iceAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_iceAmountLabel];
        
        CGRect iceDownButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                               borderThickness + (2 * ingredientSize) + (2 * buttonSize),
                                               buttonSize,
                                               buttonSize);
        UIButton* iceDownButton = [[UIButton alloc] initWithFrame:iceDownButtonFrame];
        [iceDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [iceDownButton addTarget:self
                          action:@selector(decrementIce:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iceDownButton];
        
        // Create cup section
        CGRect cupImageFrame = CGRectMake(borderThickness,
                                          borderThickness + (3 * ingredientSize),
                                          ingredientSize,
                                          ingredientSize);
        UIImageView* cupImage = [[UIImageView alloc] initWithFrame:cupImageFrame];
        [cupImage setImage:[UIImage imageNamed:@"cup"]];
        [self addSubview:cupImage];
        
        CGRect cupNameLabelFrame = CGRectMake(ingredientColumnWidth,
                                              borderThickness + (3 * ingredientSize),
                                              labelWidth,
                                              labelHeight);
        UILabel* cupNameLabel = [[UILabel alloc] initWithFrame:cupNameLabelFrame];
        [cupNameLabel setText:@"Cups"];
        [cupNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [cupNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:cupNameLabel];
        
        CGRect cupsPriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                                borderThickness + (3 * ingredientSize) + (2 * fontSize),
                                                labelWidth,
                                                labelHeight);
        _cupsPriceLabel = [[UILabel alloc] initWithFrame:cupsPriceLabelFrame];
        [_cupsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getCupsPrice] floatValue]]];
        [_cupsPriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_cupsPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_cupsPriceLabel];
        
        CGRect cupUpButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                             borderThickness + (3 * ingredientSize),
                                             buttonSize,
                                             buttonSize);
        UIButton* cupUpButton = [[UIButton alloc] initWithFrame:cupUpButtonFrame];
        [cupUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [cupUpButton addTarget:self
                     action:@selector(incrementCups:)
                     forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cupUpButton];
        
        CGRect cupsAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                                 borderThickness + (3 * ingredientSize) + buttonSize,
                                                 3 * buttonSize,
                                                 buttonSize);
        _cupsAmountLabel = [[UILabel alloc] initWithFrame:cupsAmountLabelFrame];
        [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [[self.delegate getCups] intValue]]];
        [_cupsAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_cupsAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_cupsAmountLabel];
        
        CGRect cupDownButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                               borderThickness + (3 * ingredientSize) + (2 * buttonSize),
                                               buttonSize,
                                               buttonSize);
        UIButton* cupDownButton = [[UIButton alloc] initWithFrame:cupDownButtonFrame];
        [cupDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [cupDownButton addTarget:self
                       action:@selector(decrementCups:)
                       forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cupDownButton];
        
        // Create money label
        CGRect moneyLabelFrame = CGRectMake(0,
                                            borderThickness + (4 * ingredientSize),
                                            frameWidth,
                                            buttonSize);
        _moneyLabel = [[UILabel alloc] initWithFrame:moneyLabelFrame];
        [_moneyLabel setText:[NSString stringWithFormat:@"Money: $%.2f", [[self.delegate getMoney] floatValue]]];
        [_moneyLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [_moneyLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_moneyLabel];
    }
    
    return self;
}

- (void) updateAmountLabels
{
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [[self.delegate getLemons] floatValue]]];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [[self.delegate getSugar] floatValue]]];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [[self.delegate getIce] floatValue]]];
    [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [[self.delegate getCups] intValue]]];
}

- (void) updatePriceLabels
{
    [_lemonsPriceLabel setText:[NSString stringWithFormat:@"$%0.2f", [[self.delegate getLemonPrice] floatValue]]];
    [_sugarPriceLabel setText:[NSString stringWithFormat:@"$%0.2f", [[self.delegate getSugarPrice] floatValue]]];
    [_icePriceLabel setText:[NSString stringWithFormat:@"$%0.2f", [[self.delegate getIcePrice] floatValue]]];
    [_cupsPriceLabel setText:[NSString stringWithFormat:@"$%0.2f", [[self.delegate getCupsPrice] floatValue]]];
}

- (void) updateMoneyLabel
{
    [_moneyLabel setText:[NSString stringWithFormat:@"Money: $%0.2f", [[self.delegate getMoney] floatValue]]];
}

- (void) setAmountMultiplier:(id)sender
{
    [_selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIButton* button = (UIButton*) sender;
    _selectedButton = button;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _amountMultiplier = (int) [button tag];
}

- (void) incrementLemons:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* money = [self.delegate getMoney];
        if ([money floatValue] >= [[self.delegate getLemonPrice] floatValue]){
            NSNumber* lemons = [self.delegate getLemons];
            lemons = [NSNumber numberWithFloat:[lemons floatValue] + 1.0];
            [self.delegate setLemons:lemons];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] - [[self.delegate getLemonPrice] floatValue]]];
            [self updateMoneyLabel];
            [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [lemons floatValue]]];
        }
    }
    NSAssert([[self.delegate getMoney] floatValue] >= 0.0, @"Money is negative");
}

- (void) decrementLemons:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* lemons = [self.delegate getLemons];
        if ([lemons floatValue] >= 1.0){
            NSNumber* money = [self.delegate getMoney];
            lemons = [NSNumber numberWithFloat:[lemons floatValue] - 1.0];
            [self.delegate setLemons:lemons];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] + [[self.delegate getLemonPrice] floatValue]]];
            [self updateMoneyLabel];
            [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [lemons floatValue]]];
        }
    }
    NSAssert([[self.delegate getLemons] floatValue] >= 0.0, @"Lemons are negative");
}

- (void) incrementSugar:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* money = [self.delegate getMoney];
        if ([money floatValue] >= [[self.delegate getSugarPrice] floatValue]){
            NSNumber* sugar = [self.delegate getSugar];
            sugar = [NSNumber numberWithFloat:[sugar floatValue] + 1.0];
            [self.delegate setSugar:sugar];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] - [[self.delegate getSugarPrice] floatValue]]];
            [self updateMoneyLabel];
            [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [sugar floatValue]]];
        }
    }
    NSAssert([[self.delegate getMoney] floatValue] >= 0.0, @"Money is negative");
}

- (void) decrementSugar:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* sugar = [self.delegate getSugar];
        if ([sugar floatValue] >= 1.0) {
            NSNumber* money = [self.delegate getMoney];
            sugar = [NSNumber numberWithFloat:[sugar floatValue] - 1.0];
            [self.delegate setSugar:sugar];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] + [[self.delegate getSugarPrice] floatValue]]];
            [self updateMoneyLabel];
            [_sugarAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [sugar floatValue]]];
        }
    }
    NSAssert([[self.delegate getSugar] floatValue] >= 0.0, @"Sugar is negative");
}

- (void) incrementIce:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* money = [self.delegate getMoney];
        if ([money floatValue] >= [[self.delegate getIcePrice] floatValue]){
            NSNumber* ice = [self.delegate getIce];
            ice = [NSNumber numberWithFloat:[ice floatValue] + 1.0];
            [self.delegate setIce:ice];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] - [[self.delegate getIcePrice] floatValue]]];
            [self updateMoneyLabel];
            [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [ice floatValue]]];
        }
    }
    NSAssert([[self.delegate getMoney] floatValue] >= 0.0, @"Money is negative");
}

- (void) decrementIce:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* ice = [self.delegate getIce];
        if ([ice floatValue] >= 1.0) {
            NSNumber* money = [self.delegate getMoney];
            ice = [NSNumber numberWithFloat:[ice floatValue] - 1.0];
            [self.delegate setIce:ice];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] + [[self.delegate getIcePrice] floatValue]]];
            [self updateMoneyLabel];
            [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.2f", [ice floatValue]]];
        }
    }
    NSAssert([[self.delegate getSugar] floatValue] >= 0.0, @"Ice is negative");
}

- (void) incrementCups:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* money = [self.delegate getMoney];
        if ([money floatValue] >= [[self.delegate getCupsPrice] floatValue]){
            NSNumber* cups = [self.delegate getCups];
            cups = [NSNumber numberWithFloat:[cups floatValue] + 1.0];
            [self.delegate setCups:cups];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] - [[self.delegate getCupsPrice] floatValue]]];
            [self updateMoneyLabel];
            [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [cups intValue]]];
        }
    }
    NSAssert([[self.delegate getMoney] floatValue] >= 0.0, @"Money is negative");
}

- (void) decrementCups:(id)sender
{
    for (int i = 0; i < _amountMultiplier; ++i) {
        NSNumber* cups = [self.delegate getCups];
        if ([cups floatValue] >= 1.0) {
            NSNumber* money = [self.delegate getMoney];
            cups = [NSNumber numberWithFloat:[cups floatValue] - 1.0];
            [self.delegate setCups:cups];
            [self.delegate setMoney:[NSNumber numberWithFloat:[money floatValue] + [[self.delegate getCupsPrice] floatValue]]];
            [self updateMoneyLabel];
            [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [cups intValue]]];
        }
    }
    NSAssert([[self.delegate getCups] floatValue] >= 0.0, @"Cups are negative");
}

@end
