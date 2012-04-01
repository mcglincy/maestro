//
//  StoreLayer.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameManager.h"
#import "Store.h"
#import "StoreItem.h"
#import "StoreLayer.h"

@interface StoreLayer()
@property (nonatomic, retain) CCLabelTTF *tearsLabel;
@end

@implementation StoreLayer

@synthesize tearsLabel = _tearsLabel;

/*
 NSInteger nextLevelNum = self.levelNum + 1;
 if (nextLevelNum > MAX_LEVEL_IDX) {
 [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[VictoryScene node]]];                        
 } else {
 [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GameScene nodeWithLevelNum:nextLevelNum]]];            
 }
*/

- (void)dealloc
{
    [[GameManager sharedInstance] removeObserver:self forKeyPath:@"tearsCollectedTotal"];

    [_tearsLabel release];
    [super dealloc];
}

-(id)init { 
    self = [super init];                                           
    if (self != nil) {       
        self.isTouchEnabled = YES;
        
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithFile:@"map_screen.png"];        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:
         CGPointMake(screenSize.width/2, screenSize.height/2)];
        [self addChild:backgroundImage z:0 tag:0];

        
        [CCMenuItemFont setFontSize:28];
        CCMenu *menu = [CCMenu menuWithItems:nil];
        for (StoreItem *storeItem in [GameManager sharedInstance].store.items) {
            NSString *itemString = [self stringForStoreItem:storeItem];
            CCMenuItemFont *menuItem = [CCMenuItemFont itemWithString:itemString block:^(id sender) {
            }];
            [menu addChild:menuItem];
        }
        //[menu addChild:[CCMenuItemFont itemWithString:@"Foo" block:^(id sender) {}]];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [menu alignItemsVerticallyWithPadding:30];
        [menu setPosition:ccp(winSize.width / 2, winSize.height / 2 + 200)];        
        [self addChild:menu];
        
        
        self.tearsLabel = [CCLabelTTF labelWithString:[self tearsString] fontName:@"Marker Felt" fontSize:28.0];
        self.tearsLabel.position =  ccp(winSize.width / 2 - self.tearsLabel.contentSize.width / 2, 
                                                 winSize.height - self.tearsLabel.contentSize.height / 2 - 10);
        [self addChild:self.tearsLabel];

        GameManager *gameManager = [GameManager sharedInstance];
        [gameManager addObserver:self
                      forKeyPath:@"tearsCollectedTotal"
                         options:0
                         context:nil];

        // TODO: add quit button
    }
    return self;
}

- (NSString *)tearsString
{
    return [NSString stringWithFormat:@"Tears left: %d", [GameManager sharedInstance].tearsCollectedTotal];
}

- (NSString *)stringForStoreItem:(StoreItem *)item
{
    return [NSString stringWithFormat:@"%@ - %d", item.name, item.price];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    if ([keyPath isEqualToString:@"tearsCollectedTotal"]) {
        self.tearsLabel.string = [self tearsString];
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

@end
