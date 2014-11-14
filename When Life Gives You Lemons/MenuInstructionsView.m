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
        NSString* fontName = @"Noteworthy-Bold";

        
        // Create Title
        CGRect titleFrame = CGRectMake(0, header, width, borderThickness);
        UILabel* title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = @"How to Play";
        [title setFont:[UIFont fontWithName:fontName size:(fontSize + 5)]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setBackgroundColor:[UIColor greenColor]];
        [self addSubview:title];
        
        // Create Text box with instructions
        CGRect instructionsFrame = CGRectMake(30, 200, width-60, height - borderThickness - header - 30);
        UITextView* instructions = [[UITextView alloc] initWithFrame:instructionsFrame];
        [instructions setBackgroundColor:[UIColor yellowColor]];
        [instructions setFont:[UIFont fontWithName:fontName size:fontSize]];
        [instructions setText:@"This is the sample text. Do shit iwth other things also hi jon and blah blah blahabdfkabsdfkajsdfhaksdjhf kasdjh fkajsdh fkajshdf kjasdh f"];
        instructions.editable = NO;
        [self addSubview:instructions];
    }
    return self;
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
