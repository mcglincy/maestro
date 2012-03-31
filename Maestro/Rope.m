//
//  Rope.m
//  Maestro
//
//  Created by Eliot Lash on 3/31/12.
//  Copyright 2012 n/a. All rights reserved.
//

#import "Rope.h"

// callback to remove Shapes from the Space
void removeRopeShape( cpBody *body, cpShape *shape, void *data )
{
	cpShapeFree( shape );
}

@implementation Rope

-(void) setPhysicsBody:(cpBody *)body
{
	body_ = body;
}

// this method will only get called if the sprite is batched.
// return YES if the physic's values (angles, position ) changed.
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	CGFloat x = body_->p.x;
	CGFloat y = body_->p.y;
	
	if ( !isRelativeAnchorPoint_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	// Make matrix
	CGFloat c = body_->rot.x;
	CGFloat s = body_->rot.y;
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Translate, Rot, anchor Matrix
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );
	
	return transform_;
}

-(void) dealloc
{
	cpBodyEachShape(body_, removeRopeShape, NULL);
	cpBodyFree( body_ );
	
	[super dealloc];
}


@end
