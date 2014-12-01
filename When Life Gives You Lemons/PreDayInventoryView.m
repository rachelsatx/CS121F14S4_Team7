//
//  PreDayInventoryView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayInventoryView.h"

typedef NS_ENUM(int, InventoryIngredient) {
    Lemons,
    Sugar,
    Ice,
    Cups
};

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
    
    // Constants
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat borderThickness;
    CGFloat ingredientColumnWidth;
    CGFloat labelColumnWidth;
    CGFloat ingredientSize;
    CGFloat buttonSize;
    CGFloat labelWidth;
    CGFloat labelHeight;
    
    CGFloat multiplierWidth;
    CGFloat multiplierHeight;
    NSInteger defaultMultiplier;
    
    CGFloat fontSize;
    CGFloat titleSizeIncrease;
    NSString* fontName;
}
@end

@implementation PreDayInventoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        [self setBackground];
        [self setTitle];
        
        [self createMultipliers];
        
        [self createLemonsSection];
        [self createSugarSection];
        [self createIceSection];
        [self createCupsSection];
        
        [self createMoneyLabel];
    }
    
    return self;
}

- (void)setConstants
{
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetWidth(self.frame);
    
    borderThickness = (frameHeight < frameWidth) ? (frameHeight / 5) : (frameWidth / 5);
    ingredientColumnWidth = frameWidth / 2;
    labelColumnWidth = frameWidth / 4;
    ingredientSize = ((frameHeight - borderThickness) / 4) < (frameWidth / 2) ?
                     ((frameHeight - borderThickness) / 4) : (frameWidth / 2);
    buttonSize = ingredientSize / 3;
    labelWidth = frameWidth / 4;
    labelHeight = frameHeight / 8;
    
    multiplierWidth = frameWidth / 5;
    multiplierHeight = borderThickness / 2;
    defaultMultiplier = 1;
    
    fontSize = 30;
    titleSizeIncrease = 5;
    fontName = @"Papyrus";
}

- (void)setBackground
{
    // Set background image to a paper bag
    UIGraphicsBeginImageContext(self.frame.size);
    [[UIImage imageNamed:@"bag"] drawInRect:self.bounds];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)setTitle
{
    CGRect titleFrame = CGRectMake(0,
                                   0,
                                   frameWidth,
                                   borderThickness - multiplierHeight);
    UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
    title.text = @"Inventory:";
    [title setFont:[UIFont fontWithName:fontName size:(fontSize + titleSizeIncrease)]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:title];
}

- (void)createMultipliers
{
    // Create multiplier labels
    CGRect beforeTextFrame = CGRectMake(0,
                                        borderThickness - multiplierHeight,
                                        multiplierWidth,
                                        multiplierHeight);
    UILabel* beforeLabel = [[UILabel alloc] initWithFrame:beforeTextFrame];
    [beforeLabel setText:@"Buy"];
    [beforeLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [beforeLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:beforeLabel];
    
    CGRect afterTextFrame = CGRectMake(frameWidth - multiplierWidth,
                                       borderThickness - multiplierHeight,
                                       multiplierWidth,
                                       multiplierHeight);
    UILabel* afterLabel = [[UILabel alloc] initWithFrame:afterTextFrame];
    [afterLabel setText:@"at a time"];
    [afterLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [afterLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:afterLabel];
    
    [self createSingleMultiplier:1 atIndex:1];
    [self createSingleMultiplier:10 atIndex:2];
    [self createSingleMultiplier:100 atIndex:3];
}

- (void)createSingleMultiplier:(NSInteger)multiplier atIndex:(NSInteger)index
{
    CGRect multiplierButtonFrame = CGRectMake(index * multiplierWidth,
                                              borderThickness - multiplierHeight,
                                              multiplierWidth,
                                              multiplierHeight);
    UIButton* multiplierButton = [[UIButton alloc] initWithFrame:multiplierButtonFrame];
    [multiplierButton setTitle:[NSString stringWithFormat:@" %dx ", multiplier] forState:UIControlStateNormal];
    [[multiplierButton titleLabel] setFont:[UIFont fontWithName:fontName size:fontSize]];
    [multiplierButton setTag:multiplier];
    [multiplierButton addTarget:self action:@selector(setAmountMultiplier:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:multiplierButton];
    
    // Set default multiplier
    if (multiplier == defaultMultiplier) {
        _selectedButton = multiplierButton;
        [multiplierButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _amountMultiplier = 1;
    }
}

- (void)createLemonsSection
{
    [self addImageAndLabelWithTextFor:Lemons];
    
    [self addIncrementAndDecrementButtonsFor:Lemons];
    
    CGRect lemonPriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                             borderThickness + (2 * fontSize) + (Lemons * ingredientSize),
                                             labelWidth,
                                             labelHeight);
    _lemonsPriceLabel = [[UILabel alloc] initWithFrame:lemonPriceLabelFrame];
    [_lemonsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getLemonPrice] floatValue]]];
    [_lemonsPriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_lemonsPriceLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_lemonsPriceLabel];
    
    CGRect lemonAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                              borderThickness + buttonSize + (Lemons * ingredientSize),
                                              3 * buttonSize,
                                              buttonSize);
    _lemonsAmountLabel = [[UILabel alloc] initWithFrame:lemonAmountLabelFrame];
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getLemons] floatValue]]];
    [_lemonsAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_lemonsAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_lemonsAmountLabel];
}

- (void)createSugarSection
{
    [self addImageAndLabelWithTextFor:Sugar];
    
    [self addIncrementAndDecrementButtonsFor:Sugar];
    
    CGRect sugarPriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                             borderThickness + (2 * fontSize) + (Sugar * ingredientSize),
                                             labelWidth,
                                             labelHeight);
    _sugarPriceLabel = [[UILabel alloc] initWithFrame:sugarPriceLabelFrame];
    [_sugarPriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getLemonPrice] floatValue]]];
    [_sugarPriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_sugarPriceLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_sugarPriceLabel];
    
    CGRect sugarAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                              borderThickness + buttonSize + (Sugar * ingredientSize),
                                              3 * buttonSize,
                                              buttonSize);
    _sugarAmountLabel = [[UILabel alloc] initWithFrame:sugarAmountLabelFrame];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getSugar] floatValue]]];
    [_sugarAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_sugarAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_sugarAmountLabel];
}

- (void)createIceSection
{
    [self addImageAndLabelWithTextFor:Ice];
    
    [self addIncrementAndDecrementButtonsFor:Ice];
    
    CGRect icePriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                           borderThickness + (2 * fontSize) + (Ice * ingredientSize),
                                           labelWidth,
                                           labelHeight);
    _icePriceLabel = [[UILabel alloc] initWithFrame:icePriceLabelFrame];
    [_icePriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getIcePrice] floatValue]]];
    [_icePriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_icePriceLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_icePriceLabel];
    
    CGRect iceAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                            borderThickness + buttonSize + (Ice * ingredientSize),
                                            3 * buttonSize,
                                            buttonSize);
    _iceAmountLabel = [[UILabel alloc] initWithFrame:iceAmountLabelFrame];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%.2f", [[self.delegate getIce] floatValue]]];
    [_iceAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_iceAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_iceAmountLabel];
}

- (void)createCupsSection
{
    [self addImageAndLabelWithTextFor:Cups];
    
    [self addIncrementAndDecrementButtonsFor:Cups];
    
    CGRect cupsPriceLabelFrame = CGRectMake(ingredientColumnWidth,
                                            borderThickness + (2 * fontSize) + (Cups * ingredientSize),
                                            labelWidth,
                                            labelHeight);
    _cupsPriceLabel = [[UILabel alloc] initWithFrame:cupsPriceLabelFrame];
    [_cupsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", [[self.delegate getCupsPrice] floatValue]]];
    [_cupsPriceLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_cupsPriceLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_cupsPriceLabel];
    
    CGRect cupsAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize),
                                             borderThickness + buttonSize + (Cups * ingredientSize),
                                             3 * buttonSize,
                                             buttonSize);
    _cupsAmountLabel = [[UILabel alloc] initWithFrame:cupsAmountLabelFrame];
    [_cupsAmountLabel setText:[NSString stringWithFormat:@"%d", [[self.delegate getCups] intValue]]];
    [_cupsAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_cupsAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_cupsAmountLabel];
}

/*
 * Adds the ingredient image and appropriate label for each ingredient.
 */
- (void)addImageAndLabelWithTextFor:(InventoryIngredient)ingredient
{
    UIImage* ingredientImage;
    NSString* ingredientLabelText;
    if (ingredient == Lemons) {
        ingredientImage = [UIImage imageNamed:@"lemon-slice"];
        ingredientLabelText = @"Lemons";
    } else if (ingredient == Sugar) {
        ingredientImage = [UIImage imageNamed:@"sugar"];
        ingredientLabelText = @"Sugar";
    } else if (ingredient == Ice) {
        ingredientImage = [UIImage imageNamed:@"ice"];
        ingredientLabelText = @"Ice";
    } else if (ingredient == Cups) {
        ingredientImage = [UIImage imageNamed:@"cups"];
        ingredientLabelText = @"Cups";
    } else {
        [NSException raise:@"Invalid ingredient value" format:@"Ingredient %d is invalid", ingredient];
    }
    
    CGRect imageFrame = CGRectMake(borderThickness,
                                   borderThickness + (ingredient * ingredientSize),
                                   ingredientSize,
                                   ingredientSize);
    UIImageView* image = [[UIImageView alloc] initWithFrame:imageFrame];
    [image setImage:ingredientImage];
    [self addSubview:image];
    
    CGRect nameLabelFrame = CGRectMake(ingredientColumnWidth,
                                       borderThickness + (ingredient * ingredientSize),
                                       labelWidth,
                                       labelHeight);
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
    [nameLabel setText:ingredientLabelText];
    [nameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:nameLabel];
}

/*
 * Adds the increment and decrement buttons.
 */
- (void)addIncrementAndDecrementButtonsFor:(InventoryIngredient)ingredient
{
    CGRect upButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                      borderThickness + (ingredient * ingredientSize),
                                      buttonSize,
                                      buttonSize);
    UIButton* upButton = [[UIButton alloc] initWithFrame:upButtonFrame];
    [upButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    
    CGRect downButtonFrame = CGRectMake(ingredientColumnWidth + labelColumnWidth,
                                        borderThickness + (2 * buttonSize) + (ingredient * ingredientSize),
                                        buttonSize,
                                        buttonSize);
    UIButton* downButton = [[UIButton alloc] initWithFrame:downButtonFrame];
    [downButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    
    if (ingredient == Lemons) {
        [upButton addTarget:self
                     action:@selector(incrementLemons:)
           forControlEvents:UIControlEventTouchUpInside];
        [downButton addTarget:self
                       action:@selector(decrementLemons:)
             forControlEvents:UIControlEventTouchUpInside];
    } else if (ingredient == Sugar) {
        [upButton addTarget:self
                     action:@selector(incrementSugar:)
           forControlEvents:UIControlEventTouchUpInside];
        [downButton addTarget:self
                       action:@selector(decrementSugar:)
             forControlEvents:UIControlEventTouchUpInside];
    } else if (ingredient == Ice) {
        [upButton addTarget:self
                     action:@selector(incrementIce:)
           forControlEvents:UIControlEventTouchUpInside];
        [downButton addTarget:self
                       action:@selector(decrementIce:)
             forControlEvents:UIControlEventTouchUpInside];
    } else if (ingredient == Cups) {
        [upButton addTarget:self
                     action:@selector(incrementCups:)
           forControlEvents:UIControlEventTouchUpInside];
        [downButton addTarget:self
                       action:@selector(decrementCups:)
             forControlEvents:UIControlEventTouchUpInside];
    } else {
        [NSException raise:@"Invalid ingredient value" format:@"Ingredient %d is invalid", ingredient];
    }
    
    [self addSubview:upButton];
    [self addSubview:downButton];
}

- (void)createMoneyLabel
{
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
