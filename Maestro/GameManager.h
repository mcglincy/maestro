//
//  GameManager.h
//  Maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

@property (nonatomic) NSInteger tearsCollected;

+ (GameManager *)sharedInstance;

@end
