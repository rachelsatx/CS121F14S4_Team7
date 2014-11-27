//
//  PreDayAchievementsView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 11/26/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayAchievementsView.h"

@interface PreDayAchievementsView() {
    // Constants
    UIColor* backgroundColor;
    
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat borderThickness;
    CGFloat headerThickness;
    
    NSInteger numRows;
    NSInteger numColumns;
    CGFloat imageSize;
    CGFloat imageCornerRadius;
    CGFloat imageBorderWidth;
    
    CGFloat buttonBorderThickness;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    CGFloat buttonFontSize;
    UIColor* buttonFontColor;
    CGFloat buttonCornerRadius;
    CGFloat buttonBorderWidth;
    
    CGFloat fontSize;
    NSString* fontName;
}
@end

@implementation PreDayAchievementsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setConstants];
        
        self.backgroundColor = backgroundColor;
        
        [self addAchievementDescription];
        [self addAchievements];
        
        [self addBackButton];
    }
    return self;
}

- (void)setConstants
{
    backgroundColor = [UIColor whiteColor];
    
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetHeight(self.frame);
    
    borderThickness = 30;
    headerThickness = (frameHeight < frameWidth) ? (frameHeight / 6) : (frameWidth / 6);
    
    numRows = 4;
    numColumns = 4;
    imageSize = ((frameHeight / (numRows + 1)) < (frameWidth / (numColumns + 1))) ?
                (frameHeight / (numRows + 1)) : (frameWidth / (numColumns + 1));
    imageCornerRadius = 20;
    imageBorderWidth = 2;
    
    buttonBorderThickness = 20;
    buttonWidth = 200;
    buttonHeight = 50;
    buttonFontSize = 21;
    buttonFontColor = [UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1.0];
    buttonCornerRadius = 10;
    buttonBorderWidth = 2;
    
    fontSize = 30;
    fontName = @"Chalkduster";
}

- (void)addAchievementDescription
{
    NSString* descriptionText = @"ACHIEVEMENTS: \n Click on each image to see how to earn the achievement";
    
    CGRect descriptionFrame = CGRectMake(borderThickness,
                                    borderThickness,
                                    frameWidth - 2 * borderThickness,
                                    headerThickness);
    UITextView* description = [[UITextView alloc] initWithFrame:descriptionFrame];
    description.backgroundColor = [UIColor blackColor];
    [description setFont:[UIFont fontWithName:fontName size:fontSize]];
    description.textAlignment = NSTextAlignmentCenter;
    description.textColor = [UIColor whiteColor];
    description.text = descriptionText;
    [self addSubview:description];
}

- (void)addAchievements
{
    CGFloat spaceBetweenRows = (frameHeight - headerThickness - buttonHeight - 4 * borderThickness - numRows * imageSize) / (numRows - 1);
    CGFloat spaceBetweenColumns = (frameWidth - 2 * borderThickness - numColumns * imageSize) / (numColumns - 1);

    for (int row = 0; row < numRows; row++) {
        for (int col = 0; col < numColumns; col++) {
            CGRect achievementFrame = CGRectMake(borderThickness + col * (imageSize + spaceBetweenColumns), 2 * borderThickness + headerThickness + row * (imageSize + spaceBetweenRows), imageSize, imageSize);
            UIButton* achievement = [[UIButton alloc] initWithFrame:achievementFrame];
            achievement.backgroundColor = [UIColor whiteColor];
            achievement.titleLabel.textAlignment = NSTextAlignmentCenter;
            achievement.titleLabel.numberOfLines = 0;
            [achievement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [achievement setTitle:@"Get every possible feedback" forState:UIControlStateHighlighted];
            [achievement setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            achievement.layer.cornerRadius = imageCornerRadius;
            achievement.layer.borderWidth = imageBorderWidth;
            
            if (row == 0 && col == 0) {
                [achievement setTitle:@"Con Artist" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% water" forState:UIControlStateHighlighted];
            } else if (row == 0 && col == 1) {
                [achievement setTitle:@"Lemonhead" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% lemons" forState:UIControlStateHighlighted];
            } else if (row == 0 && col == 2) {
                [achievement setTitle:@"Sweet Tooth" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% sugar" forState:UIControlStateHighlighted];
            } else if (row == 0 && col == 3) {
                [achievement setTitle:@"Do you want to sell some ice?" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% ice" forState:UIControlStateHighlighted];
            }
            
            else if (row == 1 && col == 0) {
                [achievement setTitle:@"Salesman" forState:UIControlStateNormal];
                [achievement setTitle:@"Sell 100 cups of lemonade in a day" forState:UIControlStateHighlighted];
            } else if (row == 1 && col == 1) {
                [achievement setTitle:@"Lemon Corp TM" forState:UIControlStateNormal];
                [achievement setTitle:@"Sell 1000 cups of lemonade total" forState:UIControlStateHighlighted];
            } else if (row == 1 && col == 2) {
                [achievement setTitle:@"Great Day" forState:UIControlStateNormal];
                [achievement setTitle:@"Earn $100 in a single day" forState:UIControlStateHighlighted];
            } else if (row == 1 && col == 3) {
                [achievement setTitle:@"Bill Gates" forState:UIControlStateNormal];
                [achievement setTitle:@"Earn $1000 total" forState:UIControlStateHighlighted];
            }
            
            else if (row == 2 && col == 0) {
                [achievement setTitle:@"The Perfect Cup" forState:UIControlStateNormal];
                [achievement setTitle:@"Make delicious lemonade" forState:UIControlStateHighlighted];
            } else if (row == 2 && col == 1) {
                [achievement setTitle:@"The Perfect Week" forState:UIControlStateNormal];
                [achievement setTitle:@"Make delicious lemonade for a consecutive week" forState:UIControlStateHighlighted];
            } else if (row == 2 && col == 2) {
                [achievement setTitle:@"TBD" forState:UIControlStateNormal];
                [achievement setTitle:@"TBD" forState:UIControlStateHighlighted];
            } else if (row == 2 && col == 3) {
                [achievement setTitle:@"TBD" forState:UIControlStateNormal];
                [achievement setTitle:@"TBD" forState:UIControlStateHighlighted];
            }
            
            else if (row == 3 && col == 0) {
                [achievement setTitle:@"More Famous than World Famous" forState:UIControlStateNormal];
                [achievement setTitle:@"Get your popularity over 100%" forState:UIControlStateHighlighted];
            } else if (row == 3 && col == 1) {
                [achievement setTitle:@"Underestimation" forState:UIControlStateNormal];
                [achievement setTitle:@"Have your lemonade sell out" forState:UIControlStateHighlighted];
            } else if (row == 3 && col == 2) {
                [achievement setTitle:@"Experimentalist" forState:UIControlStateNormal];
                [achievement setTitle:@"Get every possible feedback" forState:UIControlStateHighlighted];
            } else if (row == 3 && col == 3) {
                [achievement setTitle:@"Perfectionist" forState:UIControlStateNormal];
                [achievement setTitle:@"Earn all achievements" forState:UIControlStateHighlighted];
            }
            
            else {
                [achievement setTitle:@"TBD" forState:UIControlStateNormal];
                [achievement setTitle:@"TBD" forState:UIControlStateHighlighted];
            }

            [self addSubview:achievement];
        }
    }
}

- (void)addBackButton
{
    CGRect backButtonFrame = CGRectMake(frameWidth - buttonWidth - buttonBorderThickness,
                                        frameHeight - buttonHeight - buttonBorderThickness,
                                        buttonWidth,
                                        buttonHeight);
    UIButton* backButton = [[UIButton alloc] initWithFrame:backButtonFrame];
    [backButton setBackgroundColor:[UIColor whiteColor]];
    backButton.layer.cornerRadius = buttonCornerRadius;
    backButton.layer.borderWidth = buttonBorderWidth;
    backButton.layer.borderColor = [UIColor blackColor].CGColor;
    [backButton addTarget:self
                   action:@selector(backButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
    [backButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
    [self addSubview:backButton];
}

- (void)backButtonPressed:(id)sender
{
    [self setHidden:YES];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.layer addAnimation:transition forKey:nil];
    [self sendSubviewToBack:self];
}

@end
