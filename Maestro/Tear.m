//
//  Tear.m
//  TheMaestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameClock.h"
#import "GameUtils.h"
#import "Physics.h"
#import "Tear.h"

@interface Tear()
@property (nonatomic) NSTimeInterval timeToDie;
@end

@implementation Tear

@synthesize timeToDie = _timeToDie;

- (id)init
{
    self = [super initWithFile:@"tear.png" rect:CGRectMake(0, 0, 80, 58)];
    if (self) {
        self.timeToDie = [[GameClock sharedInstance] currentTime] + [GameUtils randomTimeBetweenMin:4.0 max:10.0];
        // receive updates so we can kill ourselves
        [self scheduleUpdate];
    }
    return self;
}

- (void)addToPhysics
{
    int num = 4;
    CGPoint verts[] = {
        ccp(-1 * self.contentSize.width / 2, -1 * self.contentSize.height / 2),
        ccp(-1 * self.contentSize.width / 2, self.contentSize.height / 2),
        ccp(self.contentSize.width / 2, self.contentSize.height / 2),
        ccp(self.contentSize.width / 2, -1 * self.contentSize.height / 2),
    };
    
    cpBody *body = cpBodyNew(1.0f, cpMomentForPoly(1.0f, num, verts, CGPointZero));
    
    body->p = self.position;
    Physics *physics = [Physics sharedInstance];
    cpSpaceAddBody(physics.space, body);
    
    cpShape* shape = cpPolyShapeNew(body, num, verts, CGPointZero);
    shape->e = 0.5f; shape->u = 0.5f;
    cpSpaceAddShape(physics.space, shape);
    
    [self setPhysicsBody:body];    
}

- (void)update:(ccTime)delay
{
    if ([[GameClock sharedInstance] currentTime] > self.timeToDie) {
        // have use cleanup:NO or chipmunk will crash
        [self.parent removeChild:self cleanup:NO];
    }
}

@end
