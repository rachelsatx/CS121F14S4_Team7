//
//  LemonRainScene.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 11/17/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "LemonRainScene.h"

@implementation LemonRainScene

- (void)didMoveToView: (SKView *) view
{
    self.backgroundColor = [UIColor whiteColor];
    [self createAnimation];
}

- (void)createAnimation
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"sunny-background.png"];
    backgroundSprite.position = CGPointMake(frameWidth/2, frameHeight/2);
    SKEmitterNode *lemons = [self lemons];
    lemons.position = CGPointMake(0, frameHeight/2);
    [backgroundSprite addChild:lemons];
    [self addChild:backgroundSprite];
}

- (SKEmitterNode *)lemons
{
    NSString *lemonPath = [[NSBundle mainBundle] pathForResource:@"LemonEmitter" ofType:@"sks"];
    SKEmitterNode *lemons = [NSKeyedUnarchiver unarchiveObjectWithFile:lemonPath];
    
    return lemons;
}

@end
