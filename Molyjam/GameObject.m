//
//  GameObject.m
//  Daleks
//
//  Created by Matthew McGlincy on 3/23/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithFile:(NSString *)file rect:(CGRect)rect
{
    self = [super initWithFile:file rect:rect];
    if (self) {
        
    }
    return self;
}

@end
