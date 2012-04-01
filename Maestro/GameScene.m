//
//  GameScene.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BackgroundLayer.h"
#import "GameLayer.h"
#import "GameScene.h"
#import "HUDLayer.h"

@implementation GameScene

+ (GameScene *)nodeWithLevelNum:(NSInteger)levelNum
{
    GameScene *scene = [[[GameScene alloc] initWithLevelNum:levelNum] autorelease];
    return scene;
}

- (id)initWithLevelNum:(NSInteger)levelNum
{
    self = [super init];
    if (self != nil) {
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];  
        
        HUDLayer *hudLayer = [HUDLayer node];       
        [self addChild:hudLayer z:1];                         
        
        GameLayer *gameLayer = [GameLayer nodeWithLevelNum:levelNum];
        [self addChild:gameLayer z:0];                         
    }
    return self;    
}

- (id)init {
    return [self initWithLevelNum:1];
}

@end
