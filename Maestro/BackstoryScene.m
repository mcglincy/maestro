//
//  BackstoryScene.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BackstoryLayer.h"
#import "BackstoryScene.h"

@implementation BackstoryScene

-(id)init {
    self = [super init];
    if (self != nil) {
        BackstoryLayer *backstoryLayer = [BackstoryLayer node];
        [self addChild:backstoryLayer];          
    }
    return self;
}

@end
