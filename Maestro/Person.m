//
//  Person.m
//  TheMaestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameUtils.h"
#import "Person.h"
#import "Tear.h"

#define CRY_TIME_MIN 1.0
#define CRY_TIME_MAX 2.0

@interface Person()

@end

@implementation Person

- (id)init
{
    self = [super initWithFile:@"person_0.png"];
    if (self) {
        CCAnimation *anim = [CCAnimation animation];
        [anim addFrameWithFilename:@"person_1.png"];
        [anim addFrameWithFilename:@"person_0.png"];
        
        id animationAction = [CCAnimate actionWithDuration:1.5f
                                                 animation:anim
                                      restoreOriginalFrame:YES];
        id repeatAnimation = [CCRepeatForever actionWithAction:animationAction];
        [self runAction:repeatAnimation];
        
        [self scheduleOnce:@selector(scheduleTear1) delay:[self jiggledTimeInterval]];
    }
    return self;
}

- (ccTime)jiggledTimeInterval
{
    return [GameUtils randomTimeBetweenMin:CRY_TIME_MIN max:CRY_TIME_MAX];
}

- (void)shedTear
{
    // start the tear near our head
    CGPoint startPos = ccp(self.position.x, self.position.y + 80);
    
    Tear *tear = [Tear node];
    [self.parent addChild:tear];
    tear.position = startPos;
    
    [tear addToPhysics];   
    [tear randomPush];
}

- (void)scheduleTear1
{
    [self shedTear];
    [self scheduleOnce:@selector(scheduleTear2) delay:[self jiggledTimeInterval]];
}

#warning TODO: this is a lame workaround 
// calling scheduleOnce for shedTear within shedTear doesn't work
- (void)scheduleTear2
{
    [self shedTear];
    [self scheduleOnce:@selector(scheduleTear1) delay:[self jiggledTimeInterval]];    
}

@end
