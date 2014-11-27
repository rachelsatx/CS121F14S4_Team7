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
    imageSize = (frameHeight < frameWidth) ? (frameHeight / 5) : (frameWidth / 5);
    imageCornerRadius = 10;
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
    NSString* descriptionText = @"TODO - make this update correctly according to which achievement is clicked";
    
    CGRect descriptionFrame = CGRectMake(borderThickness,
                                    borderThickness,
                                    frameWidth - 2 * borderThickness,
                                    headerThickness);
    UITextView* description = [[UITextView alloc] initWithFrame:descriptionFrame];
    description.backgroundColor = [UIColor blackColor];
    [description setFont:[UIFont fontWithName:fontName size:fontSize]];
    description.textColor = [UIColor whiteColor];
    description.text = descriptionText;
    [self addSubview:description];
}

- (void)addAchievements
{
    CGRect achievementFrame = CGRectMake(borderThickness, 2 * borderThickness + headerThickness, imageSize, imageSize);
    UIButton* achievement = [[UIButton alloc] initWithFrame:achievementFrame];
    [achievement setBackgroundImage:[UIImage imageNamed:@"lemons"] forState:UIControlStateNormal];
    [achievement setBackgroundImage:[UIImage imageNamed:@"ice"] forState:UIControlStateHighlighted];
    achievement.layer.cornerRadius = imageCornerRadius;
    achievement.layer.borderWidth = imageBorderWidth;
    [self addSubview:achievement];
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
