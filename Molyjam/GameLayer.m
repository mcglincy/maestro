//
//  GameLayer.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameLayer.h"
#import "Maestro.h"

@implementation GameLayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        Maestro *maestro = [Maestro node];
        maestro.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:maestro z:1];                         
    
    }
    return self;
}

@end
