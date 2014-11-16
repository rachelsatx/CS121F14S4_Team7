//
//  SunnyScene.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 11/5/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "SunnyScene.h"

@implementation SunnyScene

- (void)didMoveToView: (SKView *) view
{
    [self createAnimation];
}

- (void)createAnimation
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    SKSpriteNode *sunSprite = [SKSpriteNode spriteNodeWithImageNamed:@"sun.png"];
    sunSprite.position = CGPointMake(frameWidth/8, 7*frameHeight/8);
    self.backgroundColor = [UIColor colorWithRed:140.0/255 green:211.0/255 blue:255.0/255 alpha:1.0];
    [self addChild:sunSprite];
    
    SKAction *move = [SKAction moveByX:3*frameWidth / 4 y:0 duration:5];
    [sunSprite runAction:move];
}

@end
