//
//  VictoryLayer.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "TitleScene.h"
#import "VictoryLayer.h"

@implementation VictoryLayer

-(id) init
{
    self = [super init];
	if (self) {
        self.isTouchEnabled = YES;
        
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Victory!!!" fontName:@"Marker Felt" fontSize:28.0];
        label.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:label];        
    }
    return self;
}

#pragma mark - touch handlers

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [[GameManager sharedInstance] reset];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[TitleScene node]]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
