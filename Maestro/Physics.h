//
//  Physics.h
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "cocos2d.h"

@interface Physics : NSObject
{
    cpSpace *space_; // strong ref	
	cpShape *walls_[4];
}

@property (nonatomic, readonly) cpSpace *space;

+ (id)sharedInstance;
- (void)update:(ccTime) delta;

@end
