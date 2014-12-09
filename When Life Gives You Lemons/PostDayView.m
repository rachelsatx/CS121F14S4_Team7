//
//  PostDayView.m
//  When Life Gives You Lemons
//
//  Created by Megan Shao on 10/22/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PostDayView.h"
#import "DataStore.h"
#import "FireworksScene.h"

#import <AudioToolbox/AudioToolbox.h>

@interface PostDayView() {
    // Constants
    CGFloat frameWidth;
    CGFloat frameHeight;
    
    CGFloat borderThickness;
    CGFloat imageSize;
    CGFloat outlineWidth;
    CGFloat textViewWidth;
    CGFloat textViewHeight;
    CGFloat heightBetweenTextViews;
    
    CGFloat fontSize;
    NSString *fontName;
    
    CGFloat maxProfitForHue;
    
    UITextView *_badgeView;
    SKView *_animation;
    
    // Sounds
    SystemSoundID tadaSound;
    
}
@end

@implementation PostDayView

- (id)initWithFrame:(CGRect)frame andDataStore:(DataStore *)dataStore
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setConstants];
        
        [self setBackgroundByProfit:dataStore.getProfit];
        
        [self createPopularityView:dataStore.getPopularity];
        [self createFeedbackView:dataStore.getFeedbackString];
        [self createSummaryViewWithCupsSold:dataStore.getCupsSold profit:dataStore.getProfit money:dataStore.getMoney];
        [self createBadgeViewWithBadge:[dataStore getNewBadge]];
        
        [self addCustomersByPopularity:dataStore.getPopularity];
        [self addImages];
        
        [self initializeSounds];
        AudioServicesPlaySystemSound(tadaSound);

    }
    
    return self;
}

- (void)setConstants
{
    frameWidth = CGRectGetWidth(self.frame);
    frameHeight = CGRectGetHeight(self.frame);
    
    borderThickness = frameWidth / 10.0;
    imageSize = frameHeight < frameWidth ? (frameHeight / 5.0) : (frameWidth / 5.0);
    outlineWidth = 5;
    textViewWidth = frameWidth - (2 * borderThickness);
    textViewHeight = frameHeight / 4;
    heightBetweenTextViews = borderThickness / 2;
    
    fontSize = 20;
    fontName = @"Chalkduster";
    
    maxProfitForHue = 40.0;
}

- (void)setBackgroundByProfit:(NumberWithTwoDecimals *)profit
{
    NSAssert(profit >= 0, @"Negative amount of profit (%@)", profit);

    // Set background color depending on profit
    CGFloat hueFactor = [profit floatValue] < maxProfitForHue ? [profit floatValue] : maxProfitForHue;
    CGFloat hue = hueFactor / maxProfitForHue * 0.4;
    UIColor *backgroundColor = [UIColor colorWithHue:hue saturation:0.9 brightness:0.9 alpha:1.0];
    [self setBackgroundColor:backgroundColor];
}

- (void)createPopularityView:(NSInteger)popularity
{
    NSAssert(popularity >= 0, @"Negative popularity (%d)", popularity);

    // Create popularity frame and text
    CGRect popularityFrame = CGRectMake(borderThickness,
                                        borderThickness,
                                        textViewWidth,
                                        textViewHeight);
    UITextView *popularityView = [[UITextView alloc] initWithFrame:popularityFrame];
    [self formatTextView:popularityView];
    [popularityView setText:[NSString stringWithFormat: @"\nPopularity:\n\rYour popularity is at %d percent.", popularity]];
    popularityView.editable = NO;
    [self addSubview:popularityView];
}

- (void)createFeedbackView:(NSString *)feedback
{
    // Create feedback frame
    CGRect feedbackFrame = CGRectMake(borderThickness,
                                      borderThickness + textViewHeight + heightBetweenTextViews,
                                      textViewWidth,
                                      textViewHeight);
    UITextView *feedbackView = [[UITextView alloc] initWithFrame:feedbackFrame];
    [self formatTextView:feedbackView];
    [self addSubview:feedbackView];
    
    // Create feedback text - this view is less wide than the feedback frame
    // and is done so that the jug does not cover any feedback
    CGRect feedbackTextFrame = CGRectMake((3 * borderThickness / 2) + outlineWidth,
                                          borderThickness + textViewHeight + heightBetweenTextViews + outlineWidth,
                                          textViewWidth - borderThickness - (2 * outlineWidth),
                                          textViewHeight - (2 * outlineWidth));
    UITextView *feedbackTextView = [[UITextView alloc] initWithFrame:feedbackTextFrame];
    [feedbackTextView setBackgroundColor:[UIColor whiteColor]];
    [feedbackTextView setTextAlignment:NSTextAlignmentCenter];
    [feedbackTextView setFont:[UIFont fontWithName:fontName size:fontSize]];
    [feedbackTextView setText:[NSString stringWithFormat: @"\nFeedback:\n\r%@", feedback]];
    feedbackTextView.editable = NO;
    [self addSubview:feedbackTextView];
}

- (void)createSummaryViewWithCupsSold:(NSInteger)cupsSold profit:(NumberWithTwoDecimals *)profit money:(NumberWithTwoDecimals *)money
{
    NumberWithTwoDecimals *zero = [[NumberWithTwoDecimals alloc] initWithFloat:0.0];
    NSAssert(cupsSold >= 0, @"Negative number of cups sold (%d)", cupsSold);
    NSAssert([profit isGreaterThanOrEqual:zero], @"Negative amount of profit (%0.2f)", [profit floatValue]);
    NSAssert([money isGreaterThanOrEqual:zero], @"Negative money (%0.2f)", [money floatValue]);
    
    // Create end-of-day summary frame and text
    CGRect summaryFrame = CGRectMake(borderThickness,
                                     borderThickness + 2 * textViewHeight + 2 * heightBetweenTextViews,
                                     textViewWidth,
                                     textViewHeight);
    UITextView *summaryView = [[UITextView alloc] initWithFrame:summaryFrame];
    [self formatTextView:summaryView];
    NSString *profitFromDay = [NSString stringWithFormat:@"You sold %d cups of lemonade and made $%0.2f.", cupsSold, [profit floatValue]];
    NSString *moneyOnHand = [NSString stringWithFormat:@"Total money on hand: $%0.2f", [money floatValue]];
    [summaryView setText:[NSString stringWithFormat:@"\nMoney:\n\r%@\n\r%@", profitFromDay, moneyOnHand]];
    summaryView.editable = NO;
    [self addSubview:summaryView];
}

- (void)createBadgeViewWithBadge:(BOOL)existsNewBadge
{
    if (existsNewBadge) {
        CGRect badgeFrame = CGRectMake(borderThickness,
                                       borderThickness,
                                       frameWidth - 2*borderThickness,
                                       frameHeight - 2*borderThickness);
        
        _animation = [[SKView alloc] initWithFrame:badgeFrame];
        SKScene *fireworks = [[FireworksScene alloc]initWithSize:CGSizeMake(frameWidth - 2*borderThickness, frameHeight - 2*borderThickness)];
        [self addSubview:_animation];
        [_animation presentScene:fireworks];
        
        _badgeView = [[UITextView alloc] initWithFrame:badgeFrame];
        [self formatTextView:_badgeView];
        [_badgeView setBackgroundColor:[UIColor clearColor]];
        [_badgeView setText:@"\n\nCongratulations!\n\nYou earned a new badge!"];
        _badgeView.editable = NO;
        [self addSubview:_badgeView];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(hideBadgeView) userInfo:nil repeats:NO];
    }
}

- (void)hideBadgeView
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.layer addAnimation:transition forKey:nil];
    [_badgeView setHidden:YES];
    [_animation setHidden:YES];
    
}

- (void)formatTextView:(UITextView *)view
{
    [view setBackgroundColor:[UIColor whiteColor]];
    view.layer.borderWidth = outlineWidth;
    view.layer.borderColor = [UIColor blackColor].CGColor;
    [view setTextAlignment:NSTextAlignmentCenter];
    [view setFont:[UIFont fontWithName:fontName size:fontSize]];
}

- (void)addCustomersByPopularity:(NSInteger)popularity
{
    NSAssert(popularity >= 0, @"Negative popularity (%d)", popularity);

    // Add customer images according to popularity - the max that will fit is 9
    NSInteger numCustomers = popularity / 10 < 9 ? popularity / 10 : 9;
    for (NSInteger i = 0; i < numCustomers; i += 1) {
        CGRect customerFrame = CGRectMake(i * (imageSize / 2),
                                          (3 * borderThickness / 2) + textViewHeight - imageSize,
                                          imageSize,
                                          imageSize);
        UIImageView *customerView = [[UIImageView alloc] initWithFrame:customerFrame];
        [customerView setImage:[UIImage imageNamed:@"person-navy"]];
        [self addSubview:customerView];
    }
}

- (void)addImages
{
    // Add lemonade jug image
    CGRect jugFrame = CGRectMake(frameWidth - (borderThickness / 4) - imageSize,
                                 2 * textViewHeight,
                                 imageSize,
                                 imageSize);
    UIImageView *jugView = [[UIImageView alloc] initWithFrame:jugFrame];
    [jugView setImage:[UIImage imageNamed:@"jug"]];
    [self addSubview:jugView];
    
    // Add coins image
    CGRect coinsFrame = CGRectMake(borderThickness / 2,
                                   (borderThickness / 2) + (3 * textViewHeight),
                                   imageSize,
                                   imageSize);
    UIImageView *coinsView = [[UIImageView alloc] initWithFrame:coinsFrame];
    [coinsView setImage:[UIImage imageNamed:@"coins"]];
    [self addSubview:coinsView];
}

- (void)initializeSounds
{
    // Taken from http://soundbible.com/1003-Ta-Da.html
    // Under creative commons attribution 3.0
    [self setUpSound:@"tada" forLocation:&tadaSound];
}

- (void)setUpSound:(NSString*)fileName forLocation:(SystemSoundID*)location {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, location);
}


@end
