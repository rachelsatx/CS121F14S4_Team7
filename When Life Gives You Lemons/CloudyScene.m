//
//  CloudyScene.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 11/5/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "CloudyScene.h"

@interface CloudyScene()
@property CGFloat duration;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@end

@implementation CloudyScene

- (void)didMoveToView: (SKView *) view
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.duration = 7;
    self.backgroundColor = [UIColor whiteColor];
    [self createClouds];
}

- (void)createClouds
{
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    // Set background image.
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"cloudy-background.png"];
    backgroundSprite.position = CGPointMake(frameWidth/2,frameHeight/2);
    [self addChild:backgroundSprite];
    
    for (int i = 0; i < 5; ++i) {
        SKSpriteNode *cloudSprite = [SKSpriteNode spriteNodeWithImageNamed:@"cloud.png"];
        cloudSprite.position = CGPointMake(frameWidth * (-1 + (2 *i))/8, 7*frameHeight/8);
        [self addChild:cloudSprite];
        SKAction *move = [SKAction moveByX:(5 - i)*frameWidth / 4 y:0 duration:(self.duration * (5-i)/5)];
        SKAction *done = [SKAction removeFromParent];
        SKAction *sequence = [SKAction sequence:@[move, done]];
        [cloudSprite runAction:sequence];
        
        
    }
}

- (void)newCloud
{
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    SKSpriteNode *cloudSprite = [SKSpriteNode spriteNodeWithImageNamed:@"cloud.png"];
    cloudSprite.position = CGPointMake(frameWidth * (-1)/8, 7*frameHeight/8);
    [self addChild:cloudSprite];
    
    SKAction *move = [SKAction moveByX:5*frameWidth / 4 y:0 duration:self.duration];
    SKAction *done = [SKAction removeFromParent];
    SKAction *sequence = [SKAction sequence:@[move, done]];
    [cloudSprite runAction:sequence];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > (self.duration /5)) {
        self.lastSpawnTimeInterval = 0;
        [self newCloud];
    }
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

@end
