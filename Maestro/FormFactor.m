//
//  FormFactor.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/11/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "FormFactor.h"
#import "cocos2d.h"

@implementation FormFactor

+ (BOOL)isIPhone
{
    return ![self isIPad];
}

+ (BOOL)isIPad 
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    return winSize.width == 1024 || winSize.width == 768;
}

+ (CGFloat)floorHeight
{
    // 40 on iPad, 20 on iPhone
    if ([self isIPad]) {
        return 40.0;
    } else {
        return 20.0;
    }
}

+ (CGFloat)tearPhysicsBodyDiameter
{
    if ([self isIPad]) {
        return 100.0;
    } else {
        return 50.0;
    }    
}

+ (CGFloat)violinCasePositionX
{
    if ([self isIPad]) {
        return 284.0;
    } else {
        return 100.0;
    }    
}

@end
