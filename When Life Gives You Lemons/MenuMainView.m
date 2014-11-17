//
//  MenuMainView.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 11/16/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MenuMainView.h"

@implementation MenuMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat frameWidth = CGRectGetWidth(self.frame);
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        
        CGFloat buttonWidth = 200;
        CGFloat buttonHeight = 50;
        CGFloat buttonFontSize = 21;
        UIColor* buttonFontColor = [UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1.0];
        
        // Add background
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sunny-background"]];
        [self addSubview:backgroundView];
        
        // Add title image
        CGRect titleFrame = CGRectMake(frameWidth / 4, frameHeight / 8, frameWidth / 2, frameWidth / 2);
        UIImageView* titleView = [[UIImageView alloc] initWithFrame:titleFrame];
        titleView.image = [UIImage imageNamed:@"title"];
        [self addSubview:titleView];
        
        // Add new game button
        CGRect newGameButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2, (3 * frameHeight / 5) - (3 * buttonHeight / 2), buttonWidth, buttonHeight);
        UIButton* newGameButton = [[UIButton alloc] initWithFrame:newGameButtonFrame];
        newGameButton.layer.cornerRadius = 10;
        newGameButton.layer.borderWidth = 2;
        newGameButton.layer.borderColor = [UIColor blackColor].CGColor;
        [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
        newGameButton.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
        [newGameButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
        [newGameButton setBackgroundColor:[UIColor whiteColor]];
        [newGameButton addTarget:self action:@selector(newGame:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:newGameButton];

        // Add instructions button
        CGRect instructionsButtonFrame = CGRectMake((frameWidth - buttonWidth) / 2, 3 * frameHeight / 5, buttonWidth, buttonHeight);
        UIButton* instructionsButton = [[UIButton alloc] initWithFrame:instructionsButtonFrame];
        instructionsButton.layer.cornerRadius = 10;
        instructionsButton.layer.borderWidth = 2;
        instructionsButton.layer.borderColor = [UIColor blackColor].CGColor;
        [instructionsButton setTitle:@"How to Play" forState:UIControlStateNormal];
        instructionsButton.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
        [instructionsButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
        [instructionsButton setBackgroundColor:[UIColor whiteColor]];
        [instructionsButton addTarget:self
                               action:@selector(displayInstructions:)
                     forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:instructionsButton];
        
        // Add grass background
        UIImageView *grassBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2 * frameHeight / 3, frameWidth, frameHeight / 3)];
        [grassBackground setImage:[UIImage imageNamed:@"grass-background"]];
        [self addSubview:grassBackground];
        
        UIImageView *grass = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6 * frameHeight / 7, frameWidth, frameHeight / 7)];
        [grass setImage:[UIImage imageNamed:@"grass-foreground"]];
        [self addSubview:grass];
    }
    
    return self;
}

- (void)displayInstructions:(id)sender
{
    [self.delegate displayInstructions:sender];
}

- (void)newGame:(id)sender
{
    [self.delegate newGame:sender];
}

@end
