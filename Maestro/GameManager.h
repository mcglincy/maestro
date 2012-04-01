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

@interface GameManager : NSObject

@property (nonatomic) NSInteger tearsCollectedTotal;
@property (nonatomic) NSInteger tearsCollectedThisLevel;
@property (nonatomic) NSInteger tearsNeededThisLevel;
@property (nonatomic, retain) NSMutableArray *purchasedItems;
@property (nonatomic) NSInteger timeLeft;
@property (nonatomic) NSTimeInterval nextTimerTick;

+ (GameManager *)sharedInstance;

- (void)update:(ccTime)delta;
- (void)resetForGameScene:(GameScene *)scene;
- (void)playerCollectedTear;

@end
