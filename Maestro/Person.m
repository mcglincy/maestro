//
//  Person.m
//  TheMaestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init
{
    self = [super initWithFile:@"person.png" rect:CGRectMake(0, 0, 126, 320)];
    if (self) {
    }
    return self;
}

@end
