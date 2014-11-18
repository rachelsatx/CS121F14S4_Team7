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
    self.backgroundColor = [UIColor whiteColor]; // Because the background image is partially transparent.
    [self createAnimation];
}

- (void)createAnimation
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    // Set background image.
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"sunny-background.png"];
    backgroundSprite.position = CGPointMake(frameWidth/2,frameHeight/2);
    [self addChild:backgroundSprite];
    
    // Create sun sprite
    SKSpriteNode *sunSprite = [SKSpriteNode spriteNodeWithImageNamed:@"sun.png"];
    sunSprite.position = CGPointMake(frameWidth/8, 7*frameHeight/8);
    [self addChild:sunSprite];
    
    // Group actions so the sun rotates while moving across the screen.
    SKAction *move = [SKAction moveByX:3*frameWidth / 4 y:0 duration:5];
    SKAction *spin = [SKAction rotateByAngle:M_PI*2 duration:2];
    SKAction *spinForever = [SKAction repeatActionForever:spin];
    SKAction *group = [SKAction group:@[move,spinForever]];
    [sunSprite runAction:group];
}

@end
