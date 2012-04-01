//
//  GameOverScene.m
//  Daleks
//
//  Created by Matthew McGlincy on 3/25/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameOverScene.h"

@implementation GameOverScene

-(id)init {
    self = [super init];
    if (self != nil) {
        GameOverLayer *gameOverLayer = [GameOverLayer node];
        [self addChild:gameOverLayer];          
    }
    return self;
}
        
@end
