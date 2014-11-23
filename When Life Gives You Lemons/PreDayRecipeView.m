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
    
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat borderThickness;
    CGFloat ingredientColumnWidth;
    CGFloat labelColumnWidth;
    CGFloat ingredientSize;
    CGFloat buttonSize;
    CGFloat labelWidth;
    CGFloat labelHeight;
    
    CGFloat fontSize;
    CGFloat titleSizeIncrease;
    NSString* fontName;
}
@end

@implementation PreDayRecipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        [self setBackground];
        [self setTitle];
        
        [self createLemonsSection];
        [self createSugarSection];
        [self createIceSection];
        [self createWaterSection];
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
    labelHeight = buttonSize;
    
    fontSize = 30;
    titleSizeIncrease = 5;
    fontName = @"Noteworthy-Bold";
}

- (void)setBackground
{
    // Set background image to a scroll
    self.backgroundColor = [UIColor whiteColor];
    UIGraphicsBeginImageContext(self.frame.size);
    [[UIImage imageNamed:@"recipe-scroll"] drawInRect:self.bounds];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)setTitle
{
    CGRect titleFrame = CGRectMake(0,
                                   0,
                                   frameWidth,
                                   borderThickness);
    UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
    title.text = @"Recipe:";
    [title setFont:[UIFont fontWithName:fontName size:(fontSize + titleSizeIncrease)]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:title];
}

- (void)createLemonsSection
{
    [self addImageAndLabelWithTextFor:Lemons];
    
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
    
    CGRect lemonAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize / 2),
                                              borderThickness + buttonSize,
                                              2 * buttonSize,
                                              buttonSize);
    _lemonsAmountLabel = [[UILabel alloc] initWithFrame:lemonAmountLabelFrame];
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getLemonsPercentage] floatValue] * 100]];
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
}

- (void)createSugarSection
{
    [self addImageAndLabelWithTextFor:Sugar];
    
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
    
    CGRect sugarAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize / 2),
                                              borderThickness + ingredientSize + buttonSize,
                                              2 * buttonSize,
                                              buttonSize);
    _sugarAmountLabel = [[UILabel alloc] initWithFrame:sugarAmountLabelFrame];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getSugarPercentage] floatValue] * 100]];
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
}

- (void)createIceSection
{
    [self addImageAndLabelWithTextFor:Ice];
    
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
    
    CGRect iceAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize / 2),
                                            borderThickness + (2 * ingredientSize) + buttonSize,
                                            2 * buttonSize,
                                            buttonSize);
    _iceAmountLabel = [[UILabel alloc] initWithFrame:iceAmountLabelFrame];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getIcePercentage] floatValue] * 100]];
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
}

- (void)createWaterSection
{
    [self addImageAndLabelWithTextFor:Water];
    
    CGRect waterAmountLabelFrame = CGRectMake((ingredientColumnWidth + labelColumnWidth) - (buttonSize / 2),
                                              borderThickness + (3 * ingredientSize) + buttonSize,
                                              2 * buttonSize,
                                              buttonSize);
    _waterAmountLabel = [[UILabel alloc] initWithFrame:waterAmountLabelFrame];
    [_waterAmountLabel setText:[NSString stringWithFormat:@"%f", [[self.delegate getWaterPercentage] floatValue] * 100]];
    [_waterAmountLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [_waterAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_waterAmountLabel];
}

/*
 * Adds the ingredient image and appropriate label for each ingredient.
 */
- (void)addImageAndLabelWithTextFor:(Ingredient)ingredient
{
    UIImage* ingredientImage;
    NSString* ingredientLabelText;
    if (ingredient == Lemons) {
        ingredientImage = [UIImage imageNamed:@"lemon-slice"];
        ingredientLabelText = @"Lemons %";
    } else if (ingredient == Sugar) {
        ingredientImage = [UIImage imageNamed:@"sugar"];
        ingredientLabelText = @"Sugar %";
    } else if (ingredient == Ice) {
        ingredientImage = [UIImage imageNamed:@"ice"];
        ingredientLabelText = @"Ice %";
    } else if (ingredient == Water) {
        ingredientImage = [UIImage imageNamed:@"water"];
        ingredientLabelText = @"Water %";
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
                                       borderThickness + buttonSize + (ingredient * ingredientSize),
                                       labelWidth,
                                       labelHeight);
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
    [nameLabel setText:ingredientLabelText];
    [nameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:nameLabel];
}

- (void) updatePercentageLabels
{
    [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.0f", 100 * [[self.delegate getLemonsPercentage] floatValue]]];
    [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.0f", 100 * [[self.delegate getSugarPercentage] floatValue]]];
    [_iceAmountLabel setText:[NSString stringWithFormat:@"%.0f", 100 * [[self.delegate getIcePercentage] floatValue]]];
    [_waterAmountLabel setText:[NSString stringWithFormat:@"%.0f", 100 * [[self.delegate getWaterPercentage] floatValue]]];

}

- (void) incrementLemons:(id)sender
{
    NSNumber* water = [self.delegate getWaterPercentage];
    if ([water floatValue] >= .005) {
        water = [NSNumber numberWithFloat:[water floatValue] - .01];
        if ([water floatValue] < 0) {
            water = 0;
        }
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
    if ([lemons floatValue] >= .005) {
        lemons = [NSNumber numberWithFloat:[lemons floatValue] - .01];
        if ([lemons floatValue] < 0) {
            lemons = 0;
        }
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
    if ([water floatValue] >= .005) {
        water = [NSNumber numberWithFloat:[water floatValue] - .01];
        if ([water floatValue] < 0) {
            water = 0;
        }
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
    if ([sugar floatValue] >= .005) {
        sugar = [NSNumber numberWithFloat:[sugar floatValue] - .01];
        if ([sugar floatValue] < 0) {
            sugar = 0;
        }
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
    if ([water floatValue] >= .005) {
        water = [NSNumber numberWithFloat:[water floatValue] - .01];
        if ([water floatValue] < 0) {
            water = 0;
        }
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
    if ([ice floatValue] >= .005) {
        ice = [NSNumber numberWithFloat:[ice floatValue] - .01];
        if ([ice floatValue] < 0) {
            ice = 0;
        }
        [self.delegate setIcePercentage:ice];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [ice floatValue] * 100]];
    
        NSNumber* water = [self.delegate getWaterPercentage];
        water = [NSNumber numberWithFloat:[water floatValue] + .01];
        [self.delegate setWaterPercentage:water];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%0.0f", [water floatValue] * 100]];
    }
}

@end
