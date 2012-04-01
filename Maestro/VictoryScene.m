//
//  VictoryScene.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "VictoryLayer.h"
#import "VictoryScene.h"

@implementation VictoryScene

-(id)init {
    self = [super init];
    if (self != nil) {
        VictoryLayer *victoryLayer = [VictoryLayer node];
        [self addChild:victoryLayer];          
    }
    return self;
}

@end
