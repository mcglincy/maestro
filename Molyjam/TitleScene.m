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

- (void)onEnter {
    
    [super onEnter];
    static BOOL musicStarted = NO;
    if (!musicStarted) {
        [[GameSoundManager sharedInstance].soundEngine playBackgroundMusic:@"intro.mp3"];
        musicStarted = YES;
    }
}

@end
