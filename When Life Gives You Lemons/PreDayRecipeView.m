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
        [self setBackgroundColor:[UIColor whiteColor]];
        
        // create column of ingredients
        CGFloat width = CGRectGetWidth(self.frame)/2;
        CGFloat height = CGRectGetWidth(self.frame);
        
        // create lemon section
        CGRect lemonImageFrame = CGRectMake(width, 0, width/2, 120);
        UIImageView* lemonImage = [[UIImageView alloc] initWithFrame:lemonImageFrame];
        [lemonImage setImage:[UIImage imageNamed:@"lemon-slice"]];
        [self addSubview:lemonImage];
        
        CGRect lemonNameLabelFrame = CGRectMake(width + width/2, 0, width/4, 120);
        UILabel* lemonNameLabel = [[UILabel alloc] initWithFrame:lemonNameLabelFrame];
        [lemonNameLabel setText:@"Lemons %"];
        [lemonNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lemonNameLabel];
        
        CGRect lemonUpButtonFrame = CGRectMake(width + 3*width/4, 0, width/4, 40);
        UIButton* lemonUpButton = [[UIButton alloc] initWithFrame:lemonUpButtonFrame];
        [lemonUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [lemonUpButton addTarget:self
                          action:@selector(incrementLemons:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lemonUpButton];
        
        CGRect lemonAmountLabelFrame = CGRectMake(width + 3*width/4, 40, width/4, 40);
        _lemonsAmountLabel = [[UILabel alloc] initWithFrame:lemonAmountLabelFrame];
        [_lemonsAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getLemonsPercentage] floatValue]]];
        [_lemonsAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_lemonsAmountLabel];
        
        CGRect lemonDownButtonFrame = CGRectMake(width + 3*width/4, 80, width/4, 40);
        UIButton* lemonDownButton = [[UIButton alloc] initWithFrame:lemonDownButtonFrame];
        [lemonDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [lemonDownButton addTarget:self
                            action:@selector(decrementLemons:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lemonDownButton];
        
        // create sugar section
        CGRect sugarImageFrame = CGRectMake(width, 120, width/2, 120);
        UIImageView* sugarImage = [[UIImageView alloc] initWithFrame:sugarImageFrame];
        [sugarImage setImage:[UIImage imageNamed:@"sugar"]];
        [self addSubview:sugarImage];
        
        CGRect sugarNameLabelFrame = CGRectMake(width + width/2, 120, width/4, 120);
        UILabel* sugarNameLabel = [[UILabel alloc] initWithFrame:sugarNameLabelFrame];
        [sugarNameLabel setText:@"Sugar %"];
        [sugarNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:sugarNameLabel];
        
        CGRect sugarUpButtonFrame = CGRectMake(width + 3*width/4, 120, width/4, 40);
        UIButton* sugarUpButton = [[UIButton alloc] initWithFrame:sugarUpButtonFrame];
        [sugarUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [sugarUpButton addTarget:self
                          action:@selector(incrementSugar:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sugarUpButton];
        
        CGRect sugarAmountLabelFrame = CGRectMake(width + 3*width/4, 160, width/4, 40);
        _sugarAmountLabel = [[UILabel alloc] initWithFrame:sugarAmountLabelFrame];
        [_sugarAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getSugarPercentage] floatValue]]];
        [_sugarAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_sugarAmountLabel];
        
        CGRect sugarDownButtonFrame = CGRectMake(width + 3*width/4, 200, width/4, 40);
        UIButton* sugarDownButton = [[UIButton alloc] initWithFrame:sugarDownButtonFrame];
        [sugarDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [sugarDownButton addTarget:self
                            action:@selector(decrementSugar:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sugarDownButton];
        
        // create ice section
        CGRect iceImageFrame = CGRectMake(width, 240, width/2, 120);
        UIImageView* iceImage = [[UIImageView alloc] initWithFrame:iceImageFrame];
        [iceImage setImage:[UIImage imageNamed:@"ice"]];
        [self addSubview:iceImage];
        
        CGRect iceNameLabelFrame = CGRectMake(width + width/2, 240, width/4, 120);
        UILabel* iceNameLabel = [[UILabel alloc] initWithFrame:iceNameLabelFrame];
        [iceNameLabel setText:@"Ice %"];
        [iceNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:iceNameLabel];
        
        CGRect iceUpButtonFrame = CGRectMake(width + 3*width/4, 240, width/4, 40);
        UIButton* iceUpButton = [[UIButton alloc] initWithFrame:iceUpButtonFrame];
        [iceUpButton setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
        [iceUpButton addTarget:self
                        action:@selector(incrementIce:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iceUpButton];
        
        CGRect iceAmountLabelFrame = CGRectMake(width + 3*width/4, 280, width/4, 40);
        _iceAmountLabel = [[UILabel alloc] initWithFrame:iceAmountLabelFrame];
        [_iceAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getIcePercentage] floatValue]]];
        [_iceAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_iceAmountLabel];
        
        CGRect iceDownButtonFrame = CGRectMake(width + 3*width/4, 320, width/4, 40);
        UIButton* iceDownButton = [[UIButton alloc] initWithFrame:iceDownButtonFrame];
        [iceDownButton setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
        [iceDownButton addTarget:self
                          action:@selector(decrementIce:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iceDownButton];
        
        // create water section
        CGRect waterImageFrame = CGRectMake(width, 400, width/2, 120);
        UIImageView* waterImage = [[UIImageView alloc] initWithFrame:waterImageFrame];
        [waterImage setImage:[UIImage imageNamed:@"water"]];
        [self addSubview:waterImage];
        
        CGRect waterNameLabelFrame = CGRectMake(width + width/2, 400, width/4, 120);
        UILabel* waterNameLabel = [[UILabel alloc] initWithFrame:waterNameLabelFrame];
        [waterNameLabel setText:@"Water %"];
        [waterNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:waterNameLabel];
        
        CGRect waterAmountLabelFrame = CGRectMake(width + 3*width/4, 440, width/4, 40);
        _waterAmountLabel = [[UILabel alloc] initWithFrame:waterAmountLabelFrame];
        [_waterAmountLabel setText:[NSString stringWithFormat:@"%.0f", [[self.delegate getWaterPercentage] floatValue]]];
        [_waterAmountLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_waterAmountLabel];
        
        [self updatePercentageLabels];
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
