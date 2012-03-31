//
//  Rope.h
//  Maestro
//
//  Created by Eliot Lash on 3/31/12.
//  Copyright 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"

@interface Rope : CCNode {

    cpBody *body_;	// strong ref
}

-(void) setPhysicsBody:(cpBody*)body;

@end
