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
    CGFloat badgeSize;
    CGFloat badgeCornerRadius;
    CGFloat badgeBorderWidth;
    
    CGFloat buttonBorderThickness;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    CGFloat buttonFontSize;
    UIColor* buttonFontColor;
    CGFloat buttonCornerRadius;
    CGFloat buttonBorderWidth;
    
    CGFloat headerFontSize;
    CGFloat badgeFontSize;
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
    badgeSize = ((frameHeight / (numRows + 1)) < (frameWidth / (numColumns + 1))) ?
                (frameHeight / (numRows + 1)) : (frameWidth / (numColumns + 1));
    badgeCornerRadius = 20;
    badgeBorderWidth = 2;
    
    buttonBorderThickness = 20;
    buttonWidth = 200;
    buttonHeight = 50;
    buttonFontSize = 21;
    buttonFontColor = [UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1.0];
    buttonCornerRadius = 10;
    buttonBorderWidth = 2;
    
    headerFontSize = 30;
    badgeFontSize = 25;
    fontName = @"Chalkduster";
}

- (void)addAchievementDescription
{
    NSString* descriptionText = @"BADGES: \n Click on each image to see how to earn the badge";
    
    CGRect descriptionFrame = CGRectMake(borderThickness,
                                         borderThickness,
                                         frameWidth - 2 * borderThickness,
                                         headerThickness);
    UITextView* description = [[UITextView alloc] initWithFrame:descriptionFrame];
    description.backgroundColor = [UIColor blackColor];
    [description setFont:[UIFont fontWithName:fontName size:headerFontSize]];
    description.textAlignment = NSTextAlignmentCenter;
    description.textColor = [UIColor whiteColor];
    description.text = descriptionText;
    [self addSubview:description];
}

- (void)addAchievements
{
    CGFloat spaceBetweenRows = (frameHeight - headerThickness - buttonHeight - 4 * borderThickness - numRows * badgeSize) / (numRows - 1);
    CGFloat spaceBetweenColumns = (frameWidth - 2 * borderThickness - numColumns * badgeSize) / (numColumns - 1);

    for (int row = 0; row < numRows; row++) {
        for (int col = 0; col < numColumns; col++) {
            CGRect achievementFrame = CGRectMake(borderThickness + col * (badgeSize + spaceBetweenColumns), 2 * borderThickness + headerThickness + row * (badgeSize + spaceBetweenRows), badgeSize, badgeSize);
            UIButton* achievement = [[UIButton alloc] initWithFrame:achievementFrame];
            achievement.backgroundColor = [UIColor whiteColor];
            achievement.titleLabel.font = [UIFont fontWithName:fontName size:badgeFontSize];
            achievement.titleLabel.textAlignment = NSTextAlignmentCenter;
            achievement.titleLabel.numberOfLines = 0;
//            achievement.titleLabel.adjustsFontSizeToFitWidth = TRUE;
//            achievement.titleLabel.lineBreakMode = NSLineBreakByClipping;
            [achievement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [achievement setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            achievement.layer.cornerRadius = badgeCornerRadius;
            achievement.layer.borderWidth = badgeBorderWidth;
            
            // These badges start out gray and turn green when earned
            if (row == 0 && col == 0) {
                [achievement setTitle:@"Con\nArtist" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% water" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            } else if (row == 0 && col == 1) {
                [achievement setTitle:@"Lemon\nHead" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% lemons" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            } else if (row == 0 && col == 2) {
                [achievement setTitle:@"Sweet\nTooth" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% sugar" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            } else if (row == 0 && col == 3) {
                [achievement setTitle:@"Frozen" forState:UIControlStateNormal];
                [achievement setTitle:@"Try to sell 100% ice" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            }
            
            else if (row == 1 && col == 0) {
                [achievement setTitle:@"Under-estimate" forState:UIControlStateNormal];
                [achievement setTitle:@"Have your lemonade sell out" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            } else if (row == 1 && col == 1) {
                [achievement setTitle:@"The\nPerfect\nCup" forState:UIControlStateNormal];
                [achievement setTitle:@"Make delicious lemonade" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            } else if (row == 1 && col == 2) {
                [achievement setTitle:@"The\nPerfect\nWeek" forState:UIControlStateNormal];
                [achievement setTitle:@"Make delicious lemonade for a week" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            } else if (row == 1 && col == 3) {
                [achievement setTitle:@"Scientist" forState:UIControlStateNormal];
                [achievement setTitle:@"Get every possible feedback" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor grayColor]];
            }
            
            // These badges start out white and progress through bronze, silver, and gold
            // Bronze: 150, 90, 56
            // Silver: 204, 194, 194
            // Gold: 255, 215, 0
            else if (row == 2 && col == 0) {
                [achievement setTitle:@"Salesman" forState:UIControlStateNormal];
                [achievement setTitle:@"Sell 100 cups in a day" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 2 && col == 1) {
                [achievement setTitle:@"Lemon\nCorp TM" forState:UIControlStateNormal];
                [achievement setTitle:@"Sell 1000 cups total" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 2 && col == 2) {
                [achievement setTitle:@"Great\nDay" forState:UIControlStateNormal];
                [achievement setTitle:@"Earn $100 in a day" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 2 && col == 3) {
                [achievement setTitle:@"Bill\nGates" forState:UIControlStateNormal];
                [achievement setTitle:@"Earn $1000 total" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            }
            
            else if (row == 3 && col == 0) {
                [achievement setTitle:@"Rising\nStar" forState:UIControlStateNormal];
                [achievement setTitle:@"Gain 10% popularity in a day" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 3 && col == 1) {
                [achievement setTitle:@"World\nFamous" forState:UIControlStateNormal];
                [achievement setTitle:@"Get over 100% popularity" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 3 && col == 2) {
                [achievement setTitle:@"TBD" forState:UIControlStateNormal];
                [achievement setTitle:@"" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 3 && col == 3) {
                [achievement setTitle:@"Perfection" forState:UIControlStateNormal];
                [achievement setTitle:@"Earn all other badges" forState:UIControlStateHighlighted];
                [achievement setBackgroundColor:[UIColor whiteColor]];
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
