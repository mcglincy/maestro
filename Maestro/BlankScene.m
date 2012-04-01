//
//  BlankScene.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BlankLayer.h"
#import "BlankScene.h"
#import "GameSoundManager.h"
#import "TitleScene.h"

@implementation BlankScene

-(id)init {
    self = [super init];
    if (self != nil) {
        BlankLayer *blankLayer = [BlankLayer node];
        [self addChild:blankLayer];          
    }
    return self;
}

- (void)onEnter
{
    [super onEnter];
    static BOOL musicStarted = NO;
    if (!musicStarted) {
        [[GameSoundManager sharedInstance].soundEngine playBackgroundMusic:@"title.wav" loop:NO];
        musicStarted = YES;
    }    
}

@end
