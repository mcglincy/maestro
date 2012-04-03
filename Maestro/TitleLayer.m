//
//  TitleLayer.m
//  Daleks
//
//  Created by Matthew McGlincy on 3/26/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BackstoryScene.h"
#import "GameManager.h"
#import "GameSoundManager.h"
#import "GameScene.h"
#import "TitleLayer.h"

@implementation TitleLayer

-(id)init { 
    self = [super init];                                           
    if (self != nil) {    
        self.isTouchEnabled = YES;
        CCSprite *backgroundImage = [CCSprite spriteWithFile:@"title_background.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        [self addChild:backgroundImage z:-1 tag:0];
        
    }
    
    [[GameSoundManager sharedInstance].soundEngine playBackgroundMusic:@"title_theme.mp3" loop:NO];
    
    return self;
}

#pragma mark - touch handlers

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[[GameSoundManager sharedInstance].soundEngine playEffect:SOUND_STAB1]; //This conflicts with the intro music if it's playing
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[BackstoryScene node]]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
