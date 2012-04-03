//
//  GameManager.m
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameClock.h"
#import "GameManager.h"
#import "GameScene.h"
#import "Store.h"
#import "StoreItem.h"

#define TICK_INTERVAL 1.0

@interface GameManager()
//@property (nonatomic) NSTimeInterval nextTimerTick;
@end

@implementation GameManager

@synthesize currentLevelNum = _currentLevelNum;
@synthesize tearsCollectedTotal = _tearsCollectedTotal;
@synthesize tearsCollectedThisLevel = _tearsCollectedThisLevel;
@synthesize tearsNeededThisLevel = _tearsNeededThisLevel;
@synthesize purchasedItems = _purchasedItems;
@synthesize timeLeft = _timeLeft;
@synthesize nextTimerTick = _nextTimerTick;
@synthesize timerStarted = _timerStarted;
@synthesize store = _store;

- (void)dealloc
{
    [_purchasedItems release];
    [_store release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.purchasedItems = [NSMutableArray array];
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

- (void)update:(ccTime)delta
{
    if (self.timerStarted) {
        NSTimeInterval now = [GameClock sharedInstance].currentTime;
        if ([GameClock sharedInstance].currentTime > self.nextTimerTick) {
            self.timeLeft = MAX(0, self.timeLeft - 1);
            self.nextTimerTick = now + TICK_INTERVAL;
            self.store = [[Store alloc] init];
        }
    }
}

- (void)reset
{
    self.currentLevelNum = 0;
    self.tearsCollectedTotal = 0;
    self.tearsCollectedThisLevel = 0;
    self.timerStarted = NO;
    [self.purchasedItems removeAllObjects];
}

- (void)resetForGameScene:(GameScene *)scene
{
    self.currentLevelNum = scene.levelNum;
    self.tearsCollectedThisLevel = 0;
    // per level number?
    self.timeLeft = scene.maxTime;
    self.tearsNeededThisLevel = scene.tearsNeeded;
    self.timerStarted = YES;
    self.nextTimerTick = [GameClock sharedInstance].currentTime + TICK_INTERVAL;
}

- (void)playerCollectedTear
{
    self.tearsCollectedTotal = self.tearsCollectedTotal + 1;
    self.tearsCollectedThisLevel = self.tearsCollectedThisLevel + 1;
}

- (BOOL)outOfTime
{
    return self.timerStarted && (self.timeLeft <= 0);
}

- (BOOL)hasAlreadyPurchasedStoreItem:(StoreItem *)item
{
    // check for the same name in our purchased items
    // Avoid checking [purchasedItems containsObject], 
    // in case it's a different item instance.
    for (StoreItem *purchasedItem in self.purchasedItems) {
        if ([purchasedItem.name isEqualToString:item.name]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)canAffordStoreItem:(StoreItem *)item
{
    return self.tearsCollectedTotal >= item.price;
}

@end
