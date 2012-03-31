//
//  GameObject.h
//  Daleks
//
//  Created by Matthew McGlincy on 3/23/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PhysicsSprite.h"

@class GameBoardCell;

@interface GameObject : CCSprite

- (id)initWithFile:(NSString *)file rect:(CGRect)rect;
    
@end
