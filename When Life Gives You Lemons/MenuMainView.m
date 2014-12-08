//
//  MenuMainView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 11/16/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MenuMainView.h"
#import "LemonRainScene.h"

@interface MenuMainView() {
    // Constants
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat topBorderThickness;
    CGFloat titleSize;
    
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    CGFloat buttonFontSize;
    UIColor* buttonFontColor;
    CGFloat buttonCornerRadius;
    CGFloat buttonBorderWidth;
}
@end

@implementation MenuMainView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        [self setBackground];
        [self addTitle];
        
        [self addNewGameButton];
        [self addInstructionsButton];
        [self addContinueButton];
    }
    
    return self;
}

- (void)setConstants
{
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetHeight(self.frame);
    
    topBorderThickness = frameHeight / 10;
    titleSize = (frameHeight < frameWidth) ? (frameHeight / 2) : (frameWidth / 2);
    
    buttonWidth = 200;
    buttonHeight = 50;
    buttonFontSize = 21;
    buttonFontColor = [UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1.0];
    buttonCornerRadius = 10;
    buttonBorderWidth = 2;
}

- (void)setBackground
{
    // Add animation SKView
    SKView *animation = [[SKView alloc] initWithFrame:self.bounds];
    [self addSubview:animation];
    LemonRainScene *animationScene = [[LemonRainScene alloc]initWithSize:CGSizeMake(frameWidth, frameHeight)];
    [animation presentScene:animationScene];
    
    // Add grass background
    CGRect grassBackgroundFrame = CGRectMake(0,
                                             2 * frameHeight / 3,
                                             frameWidth,
                                             frameHeight / 3);
    UIImageView *grassBackground = [[UIImageView alloc] initWithFrame:grassBackgroundFrame];
    [grassBackground setImage:[UIImage imageNamed:@"grass-background"]];
    [self addSubview:grassBackground];
    
    CGRect grassFrame = CGRectMake(0,
                                   6 * frameHeight / 7,
                                   frameWidth,
                                   frameHeight / 7);
    UIImageView *grass = [[UIImageView alloc] initWithFrame:grassFrame];
    [grass setImage:[UIImage imageNamed:@"grass-foreground"]];
    [self addSubview:grass];
}

- (void)addTitle
{
    CGRect titleFrame = CGRectMake((frameWidth - titleSize) / 2,
                                   topBorderThickness,
                                   titleSize,
                                   titleSize);
    UIImageView* titleView = [[UIImageView alloc] initWithFrame:titleFrame];
    titleView.image = [UIImage imageNamed:@"title"];
    [self addSubview:titleView];
}

- (void)addNewGameButton
{
    CGRect newGameButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2,
                                           (3 * frameHeight / 5) - (3 * buttonHeight / 2),
                                           buttonWidth,
                                           buttonHeight);
    UIButton* newGameButton = [[UIButton alloc] initWithFrame:newGameButtonFrame];
    [self formatButton:newGameButton];
    [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [newGameButton addTarget:self action:@selector(newGame:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:newGameButton];
}

- (void)addInstructionsButton
{
    CGRect instructionsButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2,
                                                3 * frameHeight / 5,
                                                buttonWidth,
                                                buttonHeight);
    UIButton* instructionsButton = [[UIButton alloc] initWithFrame:instructionsButtonFrame];
    [self formatButton:instructionsButton];
    [instructionsButton setTitle:@"How to Play" forState:UIControlStateNormal];
    [instructionsButton addTarget:self
                           action:@selector(displayInstructions:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:instructionsButton];
}

- (void)addContinueButton
{
    CGRect continueButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2,
                                            3 * frameHeight / 5 + (3 * buttonHeight / 2),
                                            buttonWidth,
                                            buttonHeight);
    UIButton* continueButton = [[UIButton alloc] initWithFrame:continueButtonFrame];
    [self formatButton:continueButton];
    [continueButton setTitle:@"Continue Game" forState:UIControlStateNormal];
    [continueButton addTarget:self
                       action:@selector(newGame:)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:continueButton];
}

- (void)formatButton:(UIButton *)button
{
    button.layer.cornerRadius = buttonCornerRadius;
    button.layer.borderWidth = buttonBorderWidth;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
    [button setTitleColor:buttonFontColor forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
}

- (void)newGame:(id)sender
{
    [self.delegate newGame:sender];
}

- (void)displayInstructions:(id)sender
{
    [self.delegate displayInstructions:sender];
}

@end
