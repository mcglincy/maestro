//
//  GameManager.h
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameScene;
@class Store;
@class StoreItem;

@interface GameManager : NSObject

@property (nonatomic) NSInteger currentLevelNum;
@property (nonatomic) NSInteger tearsCollectedTotal;
@property (nonatomic) NSInteger tearsCollectedThisLevel;
@property (nonatomic) NSInteger tearsNeededThisLevel;
@property (nonatomic, retain) NSMutableArray *purchasedItems;
@property (nonatomic) NSInteger timeLeft;
@property (nonatomic) NSTimeInterval nextTimerTick;
@property (nonatomic) BOOL timerStarted;
@property (nonatomic, retain) Store *store;

+ (GameManager *)sharedInstance;

- (void)update:(ccTime)delta;
- (void)reset;
- (void)resetForGameScene:(GameScene *)scene;
- (void)playerCollectedTear;
- (BOOL)outOfTime;
- (BOOL)hasAlreadyPurchasedStoreItem:(StoreItem *)item;
- (BOOL)canAffordStoreItem:(StoreItem *)item;

@end
