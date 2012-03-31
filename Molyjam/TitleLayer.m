//
//  TitleLayer.m
//  Daleks
//
//  Created by Matthew McGlincy on 3/26/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameScene.h"
#import "Note.h"
#import "TitleLayer.h"

@implementation TitleLayer

-(id)init { 
    self = [super init];                                           
    if (self != nil) {    
        self.isTouchEnabled = YES;
        CCSprite *backgroundImage = [CCSprite spriteWithFile:@"title_screen.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        [self addChild:backgroundImage z:0 tag:0];
        
        Note *note = [Note node];
        note.position = ccp(0 + note.contentSize.width / 2, 
                            0 + note.contentSize.height / 2);
        [self addChild:note z:1];
        
        CCMoveBy *moveRight = [CCMoveTo actionWithDuration:5.0 
                                                  position:ccp(screenSize.width - note.contentSize.width/2, 0 + note.contentSize.height / 2)];
        CCMoveBy *moveLeft = [CCMoveTo actionWithDuration:5.0 
                                                 position:ccp(0 + note.contentSize.width/2, 0 + note.contentSize.height / 2)];
        CCSequence *sequence = [CCSequence actions:moveRight, moveLeft, nil];
        [note runAction:[CCRepeatForever actionWithAction:sequence]]; 
    }
    return self;
}

#pragma mark - touch handlers

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GameScene node]]];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
