//
//  Store.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Store.h"
#import "StoreItem.h"

@implementation Store

@synthesize items = _items;

- (void)dealloc
{
    [_items release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [NSArray arrayWithObjects:
                      [StoreItem itemWithName:@"Poison rosen" price:10],
                      [StoreItem itemWithName:@"Flaming bow" price:20],
                      [StoreItem itemWithName:@"Strativarius" price:30],                      
                      nil];
    }
    return self;
}

@end
