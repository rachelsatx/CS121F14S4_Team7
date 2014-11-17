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
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetWidth(self.frame);
        
        CGRect newGameButtonFrame = CGRectMake(width/2 - 50, height/2 + 110, 100, 20); // magic numbers
        UIButton* newGameButton = [[UIButton alloc] initWithFrame:newGameButtonFrame];
        [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
        [newGameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [newGameButton addTarget:self action:@selector(newGame:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:newGameButton];

        
        CGRect instructionsButtonFrame = CGRectMake(width/2 - 50, height/2 + 150, 100, 20); // magic numbers
        UIButton* instructionsButton = [[UIButton alloc] initWithFrame:instructionsButtonFrame];
        [instructionsButton setTitle:@"How to Play" forState:UIControlStateNormal];
        [instructionsButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [instructionsButton addTarget:self
                               action:@selector(displayInstructions:)
                     forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:instructionsButton];
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
