//
//  MenuInstructionsView.m
//  When Life Gives You Lemons
//
//  Created by Guest User on 11/13/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MenuInstructionsView.h"

@implementation MenuInstructionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor grayColor]];
        
        CGFloat header = 90;
        
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        CGFloat borderThickness = (height < width) ? (height / 8) : (width / 8);
        CGFloat fontSize = 30;
        NSString* fontName = @"Chalkduster";

        
        // Create Title
        UIColor* titleBackgroundColor = [UIColor colorWithRed:120.0/255 green:255.0/255 blue:0.0/255 alpha:1.0];
        CGRect titleFrame = CGRectMake(0, header, width, borderThickness);
        UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = @"How to Play";
        [title setFont:[UIFont fontWithName:fontName size:(fontSize + 5)]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setBackgroundColor:titleBackgroundColor];
        [self addSubview:title];

        NSString* instructionsText = @"You've been give 20 dollars to start up your own business. You've decided to make a lemonade stand! \n \n Use the money you have to buy ingredients and prepare for the next day. Change your recipe to try to make the tastiest lemonade possible. If your customers like your lemonade, your popularity will go up! \n \n The more popular your stand is, the more customers you will have. Good luck, and don't forget the cups!";
        
        // Create Text box with instructions
        UIColor* instructionsBackgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:100.0/255 alpha:1.0];
        CGRect instructionsFrame = CGRectMake(30, 200, width - 60, height - borderThickness - header - 30);
        UITextView* instructions = [[UITextView alloc] initWithFrame:instructionsFrame];
        [instructions setFont:[UIFont fontWithName:fontName size:fontSize]];
        [instructions setText:instructionsText];
        [instructions setBackgroundColor:[UIColor whiteColor]];
        instructions.editable = NO;
        [self addSubview:instructions];
        
        // Create back button
        CGRect backButtonFrame = CGRectMake(2 * width / 3, height - borderThickness, width / 4, borderThickness / 2);
        UIButton* backButton = [[UIButton alloc] initWithFrame:backButtonFrame];
        [backButton setBackgroundColor:[UIColor whiteColor]];
        backButton.layer.cornerRadius = 10;
        backButton.layer.borderWidth = 2;
        backButton.layer.borderColor = [UIColor blackColor].CGColor;
        [backButton addTarget:self
                       action:@selector(backButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitle:@"Back to Menu" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:backButton];
        
        // Add lemon image
        CGRect lemonImageFrame = CGRectMake(width / 8, height - height / 4, width / 4, width / 4);
        UIImageView* lemonImage = [[UIImageView alloc] initWithFrame:lemonImageFrame];
        [lemonImage setImage:[UIImage imageNamed:@"lemons"]];
        [self addSubview:lemonImage];
    }
    return self;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
