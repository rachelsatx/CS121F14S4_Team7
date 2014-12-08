//
//  MenuCreditsView.m
//  When Life Gives You Lemons
//
//  Created by Rachel Gale Wilson on 12/7/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "MenuCreditsView.h"

@interface MenuCreditsView() {
    // Constants
    UIColor* backgroundColor;
    
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat topBorderThickness;
    CGFloat headerThickness;
    CGFloat instructionsBorderThickness;
    CGFloat imageSize;
    
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

@implementation MenuCreditsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        self.backgroundColor = backgroundColor;
        [self addTitle];
        [self addCredits];
        [self addBackButton];
        [self addLemonImage];
    }
    
    return self;
}

- (void)setConstants
{
    backgroundColor = [UIColor grayColor];
    
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetHeight(self.frame);
    
    topBorderThickness = 90;
    headerThickness = (frameHeight < frameWidth) ? (frameHeight / 8) : (frameWidth / 8);
    instructionsBorderThickness = 30;
    imageSize = (frameHeight < frameWidth) ? (frameHeight / 4) : (frameWidth / 4);
    
    buttonWidth = 200;
    buttonHeight = 50;
    buttonFontSize = 21;
    buttonFontColor = [UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1.0];
    buttonCornerRadius = 10;
    buttonBorderWidth = 2;
    
    fontSize = 30;
    fontName = @"Chalkduster";
}

- (void)addTitle
{
    UIColor* titleBackgroundColor = [UIColor colorWithRed:0.0/255 green:200.0/255 blue:0.0/255 alpha:1.0];
    CGRect titleFrame = CGRectMake(0,
                                   topBorderThickness,
                                   frameWidth,
                                   headerThickness);
    UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
    title.text = @"Credits";
    [title setFont:[UIFont fontWithName:fontName size:(fontSize + 5)]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setBackgroundColor:titleBackgroundColor];
    [self addSubview:title];
}

- (void)addCredits
{
    NSString* creditsText = @" We need to thank the NSF for making this game possible. \n \n Team members: \n Jonathan Finnell \n Amit Maor \n Joshua Petrack \n Megan Shao \n Rachel Gale Wilson \n \n Created for CS121 at Harvey Mudd College.";
    
    // Create Text box with instructions
    CGRect creditsFrame = CGRectMake(instructionsBorderThickness,
                                          topBorderThickness + headerThickness + instructionsBorderThickness,
                                          frameWidth - 2 * instructionsBorderThickness,
                                          frameHeight - topBorderThickness - headerThickness - 2 * instructionsBorderThickness);
    UITextView* credits = [[UITextView alloc] initWithFrame:creditsFrame];
    [credits setFont:[UIFont fontWithName:fontName size:fontSize]];
    [credits setText:creditsText];
    credits.editable = NO;
    [self addSubview:credits];
}

- (void)addBackButton
{
    CGRect backButtonFrame = CGRectMake(frameWidth - buttonWidth - 2 * instructionsBorderThickness,
                                        frameHeight - buttonHeight - 2 * instructionsBorderThickness,
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
    [backButton setTitle:@"Back to Menu" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
    [backButton setTitleColor:buttonFontColor forState:UIControlStateNormal];
    [self addSubview:backButton];
}

- (void)addLemonImage
{
    CGRect lemonImageFrame = CGRectMake(2 * instructionsBorderThickness,
                                        frameHeight - imageSize - 2 * instructionsBorderThickness,
                                        imageSize,
                                        imageSize);
    UIImageView* lemonImage = [[UIImageView alloc] initWithFrame:lemonImageFrame];
    [lemonImage setImage:[UIImage imageNamed:@"lemons"]];
    [self addSubview:lemonImage];
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
