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
    //UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"raining-background"]];
    //[self addSubview:backgroundView];
    //self.backgroundColor = [UIColor colorWithRed:173.0/255 green:216.0/255 blue:230.0/255 alpha:1.0];
    self.backgroundColor = [UIColor grayColor];
    [self createAnimation];
}

- (void)createAnimation
{
    self.scaleMode = SKSceneScaleModeAspectFit;
    //self.blendMode = SKBlendModeReplace;
    
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"raining-background.png"];
    backgroundSprite.position = CGPointMake(frameWidth/2,frameHeight/2);
    [self addChild:backgroundSprite];
    
    for (int i = 0; i < 4; ++i) {
        SKSpriteNode *cloudSprite = [SKSpriteNode spriteNodeWithImageNamed:@"raincloud.png"];
        cloudSprite.position = CGPointMake(frameWidth * (1 + (2 *i))/8, 7*frameHeight/8);
        SKEmitterNode *rain = [self rain];
        // Make rain start beneath the clouds.
        rain.position = CGPointMake(0,-1 * CGRectGetHeight(cloudSprite.frame) / 2);
        [cloudSprite addChild:rain];
        //cloudSprite.blendMode = SKBlendModeReplace; // Should override the background.
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
