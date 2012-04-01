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
    self = [super initWithFile:@"maestro-play-0.png" rect:CGRectMake(0, 0, 384, 384)];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"maestro-play-1.png"];
        [anim addFrameWithFilename:@"maestro-play-2.png"];
        [anim addFrameWithFilename:@"maestro-play-3.png"];
        [anim addFrameWithFilename:@"maestro-play-2.png"];
        [anim addFrameWithFilename:@"maestro-play-1.png"];
        [anim addFrameWithFilename:@"maestro-play-0.png"];
        
        id animationAction = [CCAnimate actionWithDuration:1.5f
                                                 animation:anim
                                      restoreOriginalFrame:YES];
        id repeatAnimation = [CCRepeatForever actionWithAction:animationAction];
        [self runAction:repeatAnimation];
    }
    return self;
}

@end
