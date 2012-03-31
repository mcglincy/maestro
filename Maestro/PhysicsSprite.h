//
//  PhysicsSprite.h
//  ChipTest
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright n/a 2012. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface PhysicsSprite : CCSprite
{
	cpBody *body_;	// strong ref
}

-(void) setPhysicsBody:(cpBody*)body;

@end