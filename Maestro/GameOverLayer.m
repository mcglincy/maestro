//
//  GameOverLayer.m
//  Daleks
//
//  Created by Matthew McGlincy on 3/25/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Constants.h"
#import "GameManager.h"
#import "GameOverLayer.h"
#import "TitleScene.h"
#import "GameSoundManager.h"

@implementation GameOverLayer

-(id) init
{
    self = [super init];
	if (self) {
        self.isTouchEnabled = YES;
        
		CGSize winSize = [[CCDirector sharedDirector] winSize];

        CCSprite *backgroundImage = [CCSprite spriteWithFile:@"gameover_background.png"];
        backgroundImage.position = CGPointMake(winSize.width/2, winSize.height/2);
        [self addChild:backgroundImage z:-1 tag:0];

        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over" fontName:FONT_NAME fontSize:60.0];
        label.position = ccp(winSize.width / 2, winSize.height / 2);
        label.color = ccc3(0, 0, 0);
        [self addChild:label];          
    }
    
    [[GameSoundManager sharedInstance] stopMaestro];
    [[GameSoundManager sharedInstance].soundEngine playBackgroundMusic:@"gameover_theme.mp3" loop:NO];
    return self;
}

#pragma mark - touch handlers

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [[GameManager sharedInstance] reset];
    //[[GameSoundManager sharedInstance].soundEngine playEffect:SOUND_STAB3]; //This overlaps with the splash screen music unfortunately
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[TitleScene node]]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

@end
