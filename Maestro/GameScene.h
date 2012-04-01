//
//  GameScene.h
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScene : CCScene

@property (nonatomic) NSInteger levelNum;
@property (nonatomic) NSInteger maxTime;
@property (nonatomic) NSInteger tearsNeeded;

+ (GameScene *)nodeWithLevelNum:(NSInteger)levelNum;
- (id)initWithLevelNum:(NSInteger)levelNum;

@end
