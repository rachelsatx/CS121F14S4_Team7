//
//  RainyScene.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 11/5/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "RainyScene.h"

@implementation RainyScene

- (void)didMoveToView: (SKView *) view
{
    self.backgroundColor = [UIColor colorWithRed:173.0/255 green:216.0/255 blue:230.0/255 alpha:1.0];
    [self createAnimation];
}

- (void)createAnimation
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    for (int i = 0; i < 4; ++i) {
        SKSpriteNode *cloudSprite = [SKSpriteNode spriteNodeWithImageNamed:@"cloud.png"];
        cloudSprite.position = CGPointMake(frameWidth * (1 + (2 *i))/8, 7*frameHeight/8);
        [cloudSprite addChild:[self rain]]; 
        [self addChild:cloudSprite];
    }
}

- (SKEmitterNode *)rain
{
    NSString *rainPath = [[NSBundle mainBundle] pathForResource:@"RainEmitter" ofType:@"sks"];
    SKEmitterNode *rain = [NSKeyedUnarchiver unarchiveObjectWithFile:rainPath];
    
    return rain;
}

@end
