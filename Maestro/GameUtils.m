//
//  GameUtils.m
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameUtils.h"

@implementation GameUtils

+ (ccTime)randomTimeBetweenMin:(ccTime)min max:(ccTime)max
{
    float percent = arc4random() % 100;
    return min + (percent / 100.0) * (max - min);
}

@end
