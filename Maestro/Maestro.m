//
//  Maestro.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Maestro.h"

@implementation Maestro

- (id)init
{
    self = [super initWithFile:@"maestro_0.png"];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"maestro_1.png"];
        [anim addFrameWithFilename:@"maestro_2.png"];
        [anim addFrameWithFilename:@"maestro_3.png"];
        [anim addFrameWithFilename:@"maestro_2.png"];
        [anim addFrameWithFilename:@"maestro_1.png"];
        [anim addFrameWithFilename:@"maestro_0.png"];
        
        id animationAction = [CCAnimate actionWithDuration:1.5f
                                                 animation:anim
                                      restoreOriginalFrame:YES];
        id repeatAnimation = [CCRepeatForever actionWithAction:animationAction];
        [self runAction:repeatAnimation];
    }
    return self;
}

@end
