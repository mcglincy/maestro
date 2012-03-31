//
//  Person.m
//  TheMaestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init
{
    self = [super initWithFile:@"figure-blank-idle0.png" rect:CGRectMake(0, 0, 384, 384)];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"figure-blank-idle1.png"];
        [anim addFrameWithFilename:@"figure-blank-idle0.png"];
        
        id animationAction = [CCAnimate actionWithDuration:0.5f
                                                 animation:anim
                                      restoreOriginalFrame:YES];
        id repeatAnimation = [CCRepeatForever actionWithAction:animationAction];
        [self runAction:repeatAnimation];
    }
    return self;
}


@end
