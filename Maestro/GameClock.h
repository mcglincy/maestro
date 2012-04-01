//
//  GameClock.h
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameClock : NSObject

@property (nonatomic) NSTimeInterval currentTime;

+ (id)sharedInstance;

- (void)update:(ccTime)delta;

@end
