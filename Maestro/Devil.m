//
//  Devil.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Devil.h"

@implementation Devil

- (id)init
{
    self = [super initWithFile:@"devil_1.png" rect:CGRectMake(0, 0, 384, 384)];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"devil_2.png"];
        [anim addFrameWithFilename:@"devil_1.png"];
        
        id animationAction = [CCAnimate actionWithDuration:1.5f
                                                 animation:anim
                                      restoreOriginalFrame:YES];
        id repeatAnimation = [CCRepeatForever actionWithAction:animationAction];
        [self runAction:repeatAnimation];
    }
    return self;
}

- (void)animateForPurchase
{
    CCAnimation *anim = [CCAnimation animation];
    [anim addFrameWithFilename:@"devil_0.png"];
    
    id animationAction = [CCAnimate actionWithDuration:1.5f
                                             animation:anim
                                  restoreOriginalFrame:YES];
    //id repeatAnimation = [CCRepeatForever actionWithAction:animationAction];
    [self runAction:animationAction];
}

@end
