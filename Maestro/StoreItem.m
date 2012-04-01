//
//  StoreItem.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "StoreItem.h"

@implementation StoreItem

@synthesize name = _name;
@synthesize price = _price;

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

- (id)initWithName:(NSString *)name price:(NSInteger)price
{
    self = [super init];
    if (self) {
        self.name = name;
        self.price = price;
    }
    return self;
}

@end
