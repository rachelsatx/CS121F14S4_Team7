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
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetWidth(self.frame);
        
        CGFloat borderThickness = (frameHeight < frameWidth) ? (frameHeight / 5) : (frameWidth / 5);
        CGFloat ingredientColumnWidth = frameWidth / 2;
        CGFloat labelColumnWidth = frameWidth / 4;
        CGFloat ingredientSize = ((frameHeight - borderThickness) / 4) < (frameWidth / 2) ?
                                 ((frameHeight - borderThickness) / 4) : (frameWidth / 2);
        CGFloat buttonSize = ingredientSize / 3;
        CGFloat labelWidth = frameWidth / 4;
        CGFloat labelHeight = frameHeight / 4;
        
        CGFloat fontSize = 30;
        CGFloat titleSizeIncrease = 5;
        NSString* fontName = @"Noteworthy-Bold";
        
        // Set background image to a scroll
        self.backgroundColor = [UIColor whiteColor];
        UIGraphicsBeginImageContext(self.frame.size);
        [[UIImage imageNamed:@"recipe-scroll"] drawInRect:self.bounds];
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundColor = [UIColor colorWithPatternImage:image];

        // Create title of view
        CGRect titleFrame = CGRectMake(0,
                                       0,
                                       frameWidth,
                                       borderThickness);
        UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = @"Recipe:";
        [title setFont:[UIFont fontWithName:fontName size:(fontSize + titleSizeIncrease)]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:title];
        
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
        [lemonNameLabel setText:@"Lemons %"];
        [lemonNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [lemonNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lemonNameLabel];
        
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
        [sugarNameLabel setText:@"Sugar %"];
        [sugarNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [sugarNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:sugarNameLabel];
        
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
        [iceNameLabel setText:@"Ice %"];
        [iceNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [iceNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:iceNameLabel];
        
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
        
        // Create water section
        CGRect waterImageFrame = CGRectMake(borderThickness,
                                            borderThickness + (3 * ingredientSize),
                                            ingredientSize,
                                            ingredientSize);
        UIImageView* waterImage = [[UIImageView alloc] initWithFrame:waterImageFrame];
        [waterImage setImage:[UIImage imageNamed:@"water"]];
        [self addSubview:waterImage];
        
        CGRect waterNameLabelFrame = CGRectMake(ingredientColumnWidth,
                                                borderThickness + (3 * ingredientSize),
                                                labelWidth,
                                                labelHeight);
        UILabel* waterNameLabel = [[UILabel alloc] initWithFrame:waterNameLabelFrame];
        [waterNameLabel setText:@"Water %"];
        [waterNameLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
        [waterNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:waterNameLabel];
        
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
    
    return self;
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
