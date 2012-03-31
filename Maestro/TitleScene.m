//
//  TitleScene.m
//  Daleks
//
//  Created by Matthew McGlincy on 3/26/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameSoundManager.h"
#import "TitleLayer.h"
#import "TitleScene.h"

@implementation TitleScene

-(id)init {
    self = [super init];
    if (self != nil) {
        TitleLayer *titleLayer = [TitleLayer node];
        [self addChild:titleLayer];          
    }
    return self;
}

@end
