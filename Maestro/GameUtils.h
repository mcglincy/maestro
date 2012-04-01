//
//  GameUtils.h
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameUtils : NSObject

+ (ccTime)randomTimeBetweenMin:(ccTime)min max:(ccTime)max;

@end
