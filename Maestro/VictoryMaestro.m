//
//  VictoryMaestro.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "VictoryMaestro.h"

@implementation VictoryMaestro

- (id)init
{
    self = [super initWithFile:@"victory_maestro_0.png"];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"victory_maestro_1.png"];
        [anim addFrameWithFilename:@"victory_maestro_2.png"];
        [anim addFrameWithFilename:@"victory_maestro_3.png"];
        [anim addFrameWithFilename:@"victory_maestro_4.png"];
        [anim addFrameWithFilename:@"victory_maestro_5.png"];
        [anim addFrameWithFilename:@"victory_maestro_6.png"];
        [anim addFrameWithFilename:@"victory_maestro_7.png"];
        
        id animationAction = [CCAnimate actionWithDuration:2.5f
                                                 animation:anim
                                      restoreOriginalFrame:NO];
        [self runAction:animationAction];
    }
    return self;
}

@end
