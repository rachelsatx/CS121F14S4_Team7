//
//  PreDayBadgesView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 11/30/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayBadgesView.h"

@interface PreDayBadgesView() {
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

@implementation PreDayBadgesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setConstants];
        
        self.backgroundColor = backgroundColor;
        
        [self addHeader];
        [self addBadges];
        
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

- (void)addHeader
{
    NSString* descriptionText = @"BADGES: \n Click to see how to earn each badge";
    
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
    description.editable = NO;
    [self addSubview:description];
}

- (void)addBadges
{
    CGFloat spaceBetweenRows = (frameHeight - headerThickness - buttonHeight - 4 * borderThickness - numRows * badgeSize) / (numRows - 1);
    CGFloat spaceBetweenColumns = (frameWidth - 2 * borderThickness - numColumns * badgeSize) / (numColumns - 1);
    
    for (int row = 0; row < numRows; row++) {
        for (int col = 0; col < numColumns; col++) {
            CGRect badgeFrame = CGRectMake(borderThickness + col * (badgeSize + spaceBetweenColumns), 2 * borderThickness + headerThickness + row * (badgeSize + spaceBetweenRows), badgeSize, badgeSize);
            UIButton* badge = [[UIButton alloc] initWithFrame:badgeFrame];
            badge.backgroundColor = [UIColor whiteColor];
            badge.titleLabel.font = [UIFont fontWithName:fontName size:badgeFontSize];
            badge.titleLabel.textAlignment = NSTextAlignmentCenter;
            badge.titleLabel.numberOfLines = 0;
            [badge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [badge setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            badge.layer.cornerRadius = badgeCornerRadius;
            badge.layer.borderWidth = badgeBorderWidth;
            
            // These badges start out gray and turn green when earned
            if (row == 0 && col == 0) {
                [badge setTitle:@"Con\nArtist" forState:UIControlStateNormal];
                [badge setTitle:@"Try to sell 100% water" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            } else if (row == 0 && col == 1) {
                [badge setTitle:@"Lemon\nHead" forState:UIControlStateNormal];
                [badge setTitle:@"Try to sell 100% lemons" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            } else if (row == 0 && col == 2) {
                [badge setTitle:@"Sweet\nTooth" forState:UIControlStateNormal];
                [badge setTitle:@"Try to sell 100% sugar" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            } else if (row == 0 && col == 3) {
                [badge setTitle:@"Frozen" forState:UIControlStateNormal];
                [badge setTitle:@"Try to sell 100% ice" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            }
            
            else if (row == 1 && col == 0) {
                [badge setTitle:@"Under-estimate" forState:UIControlStateNormal];
                [badge setTitle:@"Have your lemonade sell out" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            } else if (row == 1 && col == 1) {
                [badge setTitle:@"The\nPerfect\nCup" forState:UIControlStateNormal];
                [badge setTitle:@"Make delicious lemonade" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            } else if (row == 1 && col == 2) {
                [badge setTitle:@"The\nPerfect\nWeek" forState:UIControlStateNormal];
                [badge setTitle:@"Make delicious lemonade for a week" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            } else if (row == 1 && col == 3) {
                [badge setTitle:@"Scientist" forState:UIControlStateNormal];
                [badge setTitle:@"Get every possible feedback" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor grayColor]];
            }
            
            // These badges start out white and progress through bronze, silver, and gold
            // Bronze: 150, 90, 56
            // Silver: 204, 194, 194
            // Gold: 255, 215, 0
            else if (row == 2 && col == 0) {
                [badge setTitle:@"Salesman" forState:UIControlStateNormal];
                [badge setTitle:@"Sell 100 cups in a day" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 2 && col == 1) {
                [badge setTitle:@"Lemon\nCorp\u2122" forState:UIControlStateNormal];
                [badge setTitle:@"Sell 1000 cups total" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 2 && col == 2) {
                [badge setTitle:@"Great\nDay" forState:UIControlStateNormal];
                [badge setTitle:@"Earn $100 in a day" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 2 && col == 3) {
                [badge setTitle:@"Bill\nGates" forState:UIControlStateNormal];
                [badge setTitle:@"Earn $1000 total" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            }
            
            else if (row == 3 && col == 0) {
                [badge setTitle:@"Rising\nStar" forState:UIControlStateNormal];
                [badge setTitle:@"Gain 10% popularity in a day" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 3 && col == 1) {
                [badge setTitle:@"World\nFamous" forState:UIControlStateNormal];
                [badge setTitle:@"Get over 100% popularity" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 3 && col == 2) {
                [badge setTitle:@"TBD" forState:UIControlStateNormal];
                [badge setTitle:@"" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            } else if (row == 3 && col == 3) {
                [badge setTitle:@"Perfection" forState:UIControlStateNormal];
                [badge setTitle:@"Earn all other badges" forState:UIControlStateHighlighted];
                [badge setBackgroundColor:[UIColor whiteColor]];
            }
            
            [self addSubview:badge];
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
