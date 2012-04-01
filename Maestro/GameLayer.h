//
//  GameLayer.h
//  maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright n/a 2012. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface GameLayer : CCLayer
{
}

@property (nonatomic) NSInteger levelNum;

+ (GameLayer *)nodeWithLevelNum:(NSInteger)levelNum;
- (id)initWithLevelNum:(NSInteger)levelNum;

@end
