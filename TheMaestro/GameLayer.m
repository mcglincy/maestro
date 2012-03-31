//
//  GameLayer.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameLayer.h"
#import "Maestro.h"
#import "Note.h"


@implementation GameLayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        Maestro *maestro = [Maestro node];
        maestro.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:maestro z:1];                         
    
        Note *note = [Note node];
        note.position = ccp(0 + note.contentSize.width / 2, 
                            0 + note.contentSize.height / 2);
        [self addChild:note z:1];
        
        CCMoveBy *moveRight = [CCMoveTo actionWithDuration:5.0 
                                                  position:ccp(winSize.width - note.contentSize.width/2, 0 + note.contentSize.height / 2)];
        CCMoveBy *moveLeft = [CCMoveTo actionWithDuration:5.0 
                                                 position:ccp(0 + note.contentSize.width/2, 0 + note.contentSize.height / 2)];
        CCSequence *sequence = [CCSequence actions:moveRight, moveLeft, nil];
        [note runAction:[CCRepeatForever actionWithAction:sequence]]; 
    }
    return self;
}

@end
