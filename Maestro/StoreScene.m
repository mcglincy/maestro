//
//  StoreScene.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "StoreLayer.h"
#import "StoreScene.h"

@implementation StoreScene

-(id)init {
    self = [super init];
    if (self != nil) {
        StoreLayer *storeLayer = [StoreLayer node];
        [self addChild:storeLayer];          
    }
    return self;
}

@end
