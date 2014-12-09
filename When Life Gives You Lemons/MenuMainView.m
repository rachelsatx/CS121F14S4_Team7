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
    BOOL _hasSavedGame;
    
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
    
    UIButton* _continueButton;
}
@end

@implementation MenuMainView

- (id) initWithFrame:(CGRect)frame withSavedGame:(BOOL)hasSavedGame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _hasSavedGame = hasSavedGame;
        [self setConstants];
        
        [self setBackground];
        [self addTitle];
        
        [self addNewGameButton];
        [self addInstructionsButton];
        [self addContinueButton];
        [self addCreditsButton];
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
    
    CGRect grassForegroundFrame = CGRectMake(0,
                                             6 * frameHeight / 7,
                                             frameWidth,
                                             frameHeight / 7);
    UIImageView *grassForeground = [[UIImageView alloc] initWithFrame:grassForegroundFrame];
    [grassForeground setImage:[UIImage imageNamed:@"grass-foreground"]];
    [self addSubview:grassForeground];
}

- (void)addTitle
{
    CGRect titleFrame = CGRectMake((frameWidth - titleSize) / 2,
                                   topBorderThickness,
                                   titleSize,
                                   titleSize);
    UIImageView* titleView = [[UIImageView alloc] initWithFrame:titleFrame];
    [titleView setImage:[UIImage imageNamed:@"title"]];
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

- (void)addContinueButton
{
    CGRect continueButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2,
                                            3 * frameHeight / 5,
                                            buttonWidth,
                                            buttonHeight);
    UIButton* continueButton = [[UIButton alloc] initWithFrame:continueButtonFrame];
    [self formatButton:continueButton];
    [continueButton setTitle:@"Continue Game" forState:UIControlStateNormal];
    [continueButton addTarget:self
                       action:@selector(continueGame:)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:continueButton];
    if (!_hasSavedGame) {
        continueButton.hidden = YES;
    }
    _continueButton = continueButton;
}

- (void)hideContinueButton:(BOOL)shouldHideContinueButton
{
    _hasSavedGame = !shouldHideContinueButton;
    [_continueButton setHidden:shouldHideContinueButton];
}

- (void)addInstructionsButton
{
    CGRect instructionsButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2,
                                                3 * frameHeight / 5 + (3 * buttonHeight / 2),
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

- (void)addCreditsButton
{
    CGRect creditsButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2,
                                            3 * frameHeight / 5 + (2 * (3 * buttonHeight / 2)),
                                            buttonWidth,
                                            buttonHeight);
    UIButton* creditsButton = [[UIButton alloc] initWithFrame:creditsButtonFrame];
    [self formatButton:creditsButton];
    [creditsButton setTitle:@"Credits" forState:UIControlStateNormal];
    [creditsButton addTarget:self
                       action:@selector(displayCredits:)
             forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:creditsButton];
}

- (void)formatButton:(UIButton *)button
{
    button.layer.cornerRadius = buttonCornerRadius;
    button.layer.borderWidth = buttonBorderWidth;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    [button.titleLabel setFont:[UIFont systemFontOfSize:buttonFontSize]];
    [button setTitleColor:buttonFontColor forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
}

- (void)newGame:(id)sender
{
    if (_hasSavedGame) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Are you sure?"
                                  message:@"If you start a new game, your current saved game will be deleted."
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"New Game", nil];
        [alertView show];
        return;
    }
    
    [self.delegate newGame:sender];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // Cancel button - nothing to do
    } else if (buttonIndex == 1) {
        // New game
        [self.delegate newGame:self];
    }
}

- (void)continueGame:(id)sender
{
    [self.delegate continueGame:sender];
}

- (void)displayInstructions:(id)sender
{
    [self.delegate displayInstructions:sender];
}

- (void)displayCredits:(id)sender
{
    [self.delegate displayCredits:sender];
}

@end
