//
//  PreDayBadgesView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 11/30/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PreDayBadgesView.h"
#import "Badges.h"

@interface PreDayBadgesView() {
    NSMutableArray* _badges;
    
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
    NSMutableDictionary* badgeDescriptions;
    
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

- (id)initWithFrame:(CGRect)frame andBadges:(NSMutableDictionary*)badgeDictionary
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        self.backgroundColor = backgroundColor;
        
        [self addHeader];
        [self addBadgesWith:badgeDictionary];
        
        [self addBackButton];
    }
    return self;
}

- (void)setConstants
{
    _badges = [[NSMutableArray alloc] init];
    
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
    badgeDescriptions = [[NSMutableDictionary alloc] init];
    NSArray* badgeArray = Badges.badgeArray;
    NSArray* descriptions = [NSArray arrayWithObjects:@"???", @"???", @"???", @"???", @"Have your lemonade sell out", @"Make delicious lemonade", @"Make delicious lemonade for a week", @"Get every possible feedback", @"Sell 100 cups in a day", @"Sell 1000 cups total", @"Earn $100 in a day", @"Earn $1000 total", @"Gain 10% popularity in a day", @"Get over 100% popularity", @"", @"Earn all other badges", nil];
    for (int i = 0; i < badgeArray.count; i++) {
        [badgeDescriptions setValue:[descriptions objectAtIndex:i] forKey:[badgeArray objectAtIndex:i]];
    }
    
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
    NSString* descriptionText = @"BADGES: \n Touch to see how to earn each badge";
    
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

- (void)addBadgesWith:(NSMutableDictionary*)badgeDictionary
{
    CGFloat spaceBetweenRows = (frameHeight - headerThickness - buttonHeight - 4 * borderThickness - numRows * badgeSize) / (numRows - 1);
    CGFloat spaceBetweenColumns = (frameWidth - 2 * borderThickness - numColumns * badgeSize) / (numColumns - 1);
    
    NSArray* badgeArray = Badges.badgeArray;
    for (int i = 0; i < badgeArray.count; i++) {
        NSInteger rowIndex = i / numColumns;
        NSInteger columnIndex = i % numColumns;
        
        CGRect badgeFrame = CGRectMake(borderThickness + columnIndex * (badgeSize + spaceBetweenColumns),
                                       2 * borderThickness + headerThickness + rowIndex * (badgeSize + spaceBetweenRows),
                                       badgeSize,
                                       badgeSize);
        UIButton* badge = [[UIButton alloc] initWithFrame:badgeFrame];
        badge.backgroundColor = [UIColor whiteColor];
        badge.titleLabel.font = [UIFont fontWithName:fontName size:badgeFontSize];
        badge.titleLabel.textAlignment = NSTextAlignmentCenter;
        badge.titleLabel.numberOfLines = 0;
        [badge setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [badge setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        badge.layer.cornerRadius = badgeCornerRadius;
        badge.layer.borderWidth = badgeBorderWidth;
        
        NSString* badgeTitle = [badgeArray objectAtIndex:i];
        [badge setTitle:badgeTitle forState:UIControlStateNormal];
        [badge setTitle:[badgeDescriptions objectForKey:badgeTitle] forState:UIControlStateHighlighted];
        [self updateBadgeBackground:badge withValue:[badgeDictionary objectForKey:badgeTitle]];
        
        [self addSubview:badge];
        [_badges addObject:badge];
    }
}

- (void)updateBadgeBackground:(UIButton*)badge withValue:(NSNumber*)value
{
    if ([value isEqualToNumber:@0]) {
        [badge setBackgroundColor:[UIColor whiteColor]];
    } else {
        [badge setBackgroundColor:[UIColor greenColor]];
    }
}

- (void)updateAllBadgeBackgrounds:(NSMutableDictionary*)badgeDictionary
{
    NSArray* badgeArray = Badges.badgeArray;
    for (int i = 0; i < badgeArray.count; i++) {
        NSString* badgeTitle = [badgeArray objectAtIndex:i];
        NSNumber* value = [badgeDictionary objectForKey:badgeTitle];
        [self updateBadgeBackground:[_badges objectAtIndex:i] withValue:value];
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
