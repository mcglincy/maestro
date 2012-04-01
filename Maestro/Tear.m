//
//  Tear.m
//  TheMaestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameClock.h"
#import "GameManager.h"
#import "GameUtils.h"
#import "Physics.h"
#import "Tear.h"

#define MIN_LIFE 4.0
#define MAX_LIFE 10.0

@interface Tear()
@property (nonatomic) NSTimeInterval timeToDie;
@property (nonatomic) BOOL isDead;
@end

@implementation Tear

@synthesize timeToDie = _timeToDie;
@synthesize isDead = _isDead;

- (id)init
{
    self = [super initWithFile:@"tear.png" rect:CGRectMake(0, 0, 80, 58)];
    if (self) {
        [[GameManager sharedInstance] playerCollectedTear];
        self.timeToDie = [[GameClock sharedInstance] currentTime] + [GameUtils randomTimeBetweenMin:MIN_LIFE max:MAX_LIFE];
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
    shape->collision_type = kCollisionTypeTear;
    shape->data = self;
    cpSpaceAddShape(physics.space, shape);
    
    [self setPhysicsBody:body];    
}

- (void)randomPush
{
    CGFloat x = -200.0 + (arc4random() % 250);
    CGFloat y = 50 + (arc4random() % 100);
    cpVect j = cpv(x, y);
    //j = cpvmult(j, 100);
    cpBodyApplyImpulse(body_, j, cpvzero);
}

- (void)update:(ccTime)delay
{
    if ([[GameClock sharedInstance] currentTime] > self.timeToDie) {
        [self die];
    }
}

- (void)die
{
    self.isDead = YES;
    // have use cleanup:NO or chipmunk will crash
    [self.parent removeChild:self cleanup:NO];    
}

- (void)hitBin
{
    if (!self.isDead) {
        GameManager *manager = [GameManager sharedInstance];
        [manager playerCollectedTear];
        [self die];
    }
}
@end
