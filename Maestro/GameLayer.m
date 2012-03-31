//
//  GameLayer.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Constants.h"
#import "GameLayer.h"
#import "Maestro.h"
#import "Note.h"
#import "Person.h"
#import "Physics.h"
#import "Tear.h"


@implementation GameLayer

- (id)init
{
    self = [super init];
    if (self) {
        // poke the physics singleton, init physics
		[Physics sharedInstance];

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        Maestro *maestro = [Maestro node];
        maestro.position = ccp(maestro.contentSize.width / 2, 
                               FLOOR_HEIGHT + maestro.contentSize.height / 2);
        [self addChild:maestro z:1];                         

        Person *p1 = [Person node];
        p1.position = ccp(winSize.width - p1.contentSize.width / 2, 
                               FLOOR_HEIGHT + p1.contentSize.height / 2);
        [self addChild:p1 z:1];                         

        Person *p2 = [Person node];
        p2.position = ccp(winSize.width - p2.contentSize.width / 2 - 100, 
                          FLOOR_HEIGHT + p2.contentSize.height / 2);
        [self addChild:p2 z:1];                         
        
        Note *note = [Note node];
        note.position = ccp(0 + note.contentSize.width / 2, 
                            0 + note.contentSize.height / 2);
        [self addChild:note z:1];
        //[self animateNode:note];

        Tear *tear = [Tear node];
        tear.position = ccp(0 + note.contentSize.width / 2, 
                            winSize.height - 100);
        [self addChild:tear z:1];
        //[self animateNode:tear];
    }
    return self;
}

- (void)animateNode:(CCNode *)node
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    CCMoveBy *moveRight = [CCMoveTo actionWithDuration:5.0 
                                              position:ccp(winSize.width - node.contentSize.width/2, 
                                                           node.position.y)];
    CCMoveBy *moveLeft = [CCMoveTo actionWithDuration:5.0 
                                             position:ccp(0 + node.contentSize.width/2, 
                                                          node.position.y)];
    CCSequence *sequence = [CCSequence actions:moveRight, moveLeft, nil];
    [node runAction:[CCRepeatForever actionWithAction:sequence]];   
}

@end
