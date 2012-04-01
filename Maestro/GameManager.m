//
//  GameManager.m
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

@synthesize tearsCollected = _tearsCollected;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (id)sharedInstance
{
    static GameManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GameManager alloc] init];
    });
    return sharedInstance;
}


@end
