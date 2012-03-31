//
//  GameScene.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BackgroundLayer.h"
#import "GameLayer.h"
#import "HelloWorldLayer.h"
#import "GameScene.h"

@implementation GameScene

-(id)init {
    self = [super init];
    if (self != nil) {
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];  
//        
//        HUDLayer *hudLayer = [HUDLayer node];       
//        [self addChild:hudLayer z:1];                         
        
//        GameLayer *gameLayer = [GameLayer node];
//        [self addChild:gameLayer z:0];
        
        HelloWorldLayer *helloWorldLayer = [HelloWorldLayer node];
        [self addChild:helloWorldLayer z:0];
        
    }
    return self;
}

@end
