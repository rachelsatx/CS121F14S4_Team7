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
    self.backgroundColor = [UIColor grayColor];
    [self createAnimation];
}

- (void)createAnimation
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    // Set background image
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"raining-background.png"];
    backgroundSprite.position = CGPointMake(frameWidth / 2, frameHeight / 2);
    [self addChild:backgroundSprite];
    
    // Create clouds, and add rain emitters.
    for (int i = 0; i < 4; ++i) {
        SKSpriteNode *cloudSprite = [SKSpriteNode spriteNodeWithImageNamed:@"raincloud.png"];
        cloudSprite.position = CGPointMake(frameWidth * (1 + (2 * i)) / 8, 7 * frameHeight / 8);
        SKEmitterNode *rain = [self rain];
        // Make rain start beneath the clouds.
        rain.position = CGPointMake(0, -1 * CGRectGetHeight(cloudSprite.frame) / 2);
        [cloudSprite addChild:rain];
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
