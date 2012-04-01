//
//  Physics.m
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Physics.h"
#import "PhysicsSprite.h"
#import "Tear.h"

@implementation Physics

@dynamic space;

- (void)dealloc
{
	// manually Free rogue shapes
	for(int i=0; i<4; i++) {
		cpShapeFree(walls_[i]);
	}
	
	cpSpaceFree(space_);
	
	[super dealloc];
	
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initPhysics];
    }
    return self;
}

+ (Physics *)sharedInstance
{
    static Physics *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Physics alloc] init];
    });
    return sharedInstance;
}

- (cpSpace *)space
{
    return space_;
}

-(void) initPhysics
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	// init chipmunk
	cpInitChipmunk();
	
	space_ = cpSpaceNew();
	
#warning messing with gravity
//	space_->gravity = ccp(0, -100);
	space_->gravity = ccp(0, -100);
	
	//
	// rogue shapes
	// We have to free them manually
	//
	// bottom
	walls_[0] = cpSegmentShapeNew( space_->staticBody, ccp(0,0), ccp(s.width,0), 0.0f);
	
	// top
	walls_[1] = cpSegmentShapeNew( space_->staticBody, ccp(0,s.height), ccp(s.width,s.height), 0.0f);
	
	// left
	walls_[2] = cpSegmentShapeNew( space_->staticBody, ccp(0,0), ccp(0,s.height), 0.0f);
	
	// right
	walls_[3] = cpSegmentShapeNew( space_->staticBody, ccp(s.width,0), ccp(s.width,s.height), 0.0f);
	
	for( int i=0;i<4;i++) {
		walls_[i]->e = 1.0f;
		walls_[i]->u = 1.0f;
		cpSpaceAddStaticShape(space_, walls_[i] );
	}	
    
    // add collision handlers
    cpSpaceAddCollisionHandler(space_, kCollisionTypeTear, kCollisionTypeTearBin, &tearHitTearBin, NULL, NULL, NULL, NULL);
}

- (void)update:(ccTime) delta
{
	// Should use a fixed size step based on the animation interval.
	int steps = 2;
	CGFloat dt = [[CCDirector sharedDirector] animationInterval]/(CGFloat)steps;
	
	for(int i=0; i<steps; i++){
		cpSpaceStep(space_, dt);
	}
}

static int tearHitTearBin(cpArbiter *arb, cpSpace *space, void *data){
	cpShape *a, *b; 
    cpArbiterGetShapes(arb, &a, &b);
    Tear *tear = (Tear *)a->data;
    [tear hitBin];
	//MyGame *game = (MyGame*) data;
///	cpBodyApplyImpulse(a->body, cpv(1000,3000), cpv(0,0));
	return 1;
}

@end
