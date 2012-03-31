//
//  BlankLayer.m
//  Maestro
//
//  Created by Matthew McGlincy on 3/26/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BlankLayer.h"

@implementation BlankLayer

-(id)init { 
    self = [super init];                                           
    if (self != nil) {   
        self.isTouchEnabled = YES;
        
        CCSprite *backgroundImage = [CCSprite spriteWithFile:@"blank_screen.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        [self addChild:backgroundImage z:0 tag:0];        
    }
    return self;
}

@end
