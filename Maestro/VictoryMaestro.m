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
    self = [super initWithFile:@"end_anim_frame0.png" rect:CGRectMake(0, 0, 512, 384)];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"end_anim_frame1.png"];
        [anim addFrameWithFilename:@"end_anim_frame2.png"];
        [anim addFrameWithFilename:@"end_anim_frame3.png"];
        [anim addFrameWithFilename:@"end_anim_frame4.png"];
        [anim addFrameWithFilename:@"end_anim_frame5.png"];
        [anim addFrameWithFilename:@"end_anim_frame6.png"];
        [anim addFrameWithFilename:@"end_anim_frame7.png"];
        
        id animationAction = [CCAnimate actionWithDuration:2.5f
                                                 animation:anim
                                      restoreOriginalFrame:NO];
        [self runAction:animationAction];
    }
    return self;
}

@end
