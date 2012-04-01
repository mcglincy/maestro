//
//  GameClock.m
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameClock.h"

@implementation GameClock

@synthesize currentTime = _currentTime;

- (id)init
{
    self = [super init];
    if (self) {
        [self updateTime];
    }
    return self;
}

+ (id)sharedInstance
{
    static GameClock *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GameClock alloc] init];
    });
    return sharedInstance;
}

- (void)update:(ccTime)delta
{
    [self updateTime];
}

- (void)updateTime
{
    self.currentTime = [NSDate timeIntervalSinceReferenceDate];
}

@end
