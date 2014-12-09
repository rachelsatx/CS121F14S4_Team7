//
//  FireworksScene.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 12/8/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "FireworksScene.h"

@implementation FireworksScene

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
    
    SKSpriteNode *node1 = [SKSpriteNode node];
    //SKNode *node2 = [SKNode node];
    
    SKEmitterNode *fireworks1 = [self fireworks];
    node1.position = CGPointMake(frameWidth/2, frameHeight/2);
    [node1 addChild:fireworks1];
    [self addChild:node1];
    
    SKEmitterNode *fireworks2 = [self fireworks];
    fireworks2.position = CGPointMake(-frameWidth, -frameHeight);
    [self addChild:fireworks2];
}

- (SKEmitterNode *)fireworks
{
    NSString *fireworksPath = [[NSBundle mainBundle] pathForResource:@"Fireworks" ofType:@"sks"];
    SKEmitterNode *fireworks = [NSKeyedUnarchiver unarchiveObjectWithFile:fireworksPath];
    
    return fireworks;
}


@end
