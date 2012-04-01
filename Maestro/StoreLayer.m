//
//  StoreLayer.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "GameManager.h"
#import "GameScene.h"
#import "Store.h"
#import "StoreItem.h"
#import "StoreLayer.h"

@interface StoreLayer()
@property (nonatomic, retain) CCMenu *storeMenu;
@property (nonatomic, retain) CCLabelTTF *tearsLabel;
@end

@implementation StoreLayer

@synthesize storeMenu;
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
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:
         CGPointMake(winSize.width/2, winSize.height/2)];
        [self addChild:backgroundImage z:0 tag:0];

        // tears remaining
        self.tearsLabel = [CCLabelTTF labelWithString:[self tearsString] fontName:@"Marker Felt" fontSize:28.0];
        self.tearsLabel.position =  ccp(winSize.width / 2 - self.tearsLabel.contentSize.width / 2, 
                                        winSize.height - self.tearsLabel.contentSize.height / 2 - 10);
        [self addChild:self.tearsLabel];

        // store menu
        [CCMenuItemFont setFontSize:28];
        self.storeMenu = [CCMenu menuWithItems:nil];
        [self updateMenu];
        [storeMenu setPosition:ccp(winSize.width / 2, winSize.height / 2 + 200)];        
        [self addChild:self.storeMenu];
        
        // done/continue button
//        CCMenuItem *doneItem = [CCMenuItemImage 
//                                    itemFromNormalImage:@"ButtonStar.png" selectedImage:@"ButtonStarSel.png" 
//                                    target:self selector:@selector(starButtonTapped:)];
        CCMenuItemFont *doneItem = [CCMenuItemFont itemWithString:@"Done" block:^(id sender) {
            [self doneStore];
        }];
        doneItem.fontSize = 60;
        CCMenu *doneMenu = [CCMenu menuWithItems:doneItem, nil];
        doneMenu.position = ccp(winSize.width - doneItem.contentSize.width, 0 + doneItem.contentSize.height / 2);
        [self addChild:doneMenu];
        

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

- (void)buyStoreItem:(StoreItem *)item 
{
    GameManager *gameManager = [GameManager sharedInstance];
    if ([gameManager canAffordStoreItem:item] &&
        ![gameManager hasAlreadyPurchasedStoreItem:item]) {
        // if we can afford it and haven't bought it already
        gameManager.tearsCollectedTotal = gameManager.tearsCollectedTotal - item.price;
        [gameManager.purchasedItems addObject:item];
        
        // TODO: play purchase sound
        [self updateMenu];
    }
}

- (void)updateMenu
{
    [self.storeMenu removeAllChildrenWithCleanup:YES];
    GameManager *gameManager = [GameManager sharedInstance];
    for (StoreItem *storeItem in gameManager.store.items) {
        BOOL canAfford = [gameManager canAffordStoreItem:storeItem];
        BOOL alreadyPurchased = [gameManager hasAlreadyPurchasedStoreItem:storeItem];
        NSString *checkmark = alreadyPurchased ? @"X ": @"  ";
        NSString *itemString = [NSString stringWithFormat:@"%@%@ - %d", checkmark, storeItem.name, storeItem.price];
        CCMenuItemFont *menuItem = [CCMenuItemFont itemWithString:itemString block:^(id sender) {
            [self buyStoreItem:storeItem];
        }];
        if (!canAfford || alreadyPurchased) {
            menuItem.isEnabled = NO;
        }
        [self.storeMenu addChild:menuItem];
    }
    [storeMenu alignItemsVerticallyWithPadding:30];
}

- (void)doneStore 
{
    GameManager *gameManager = [GameManager sharedInstance];
    NSInteger nextLevelNum = gameManager.currentLevelNum + 1;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GameScene nodeWithLevelNum:nextLevelNum]]];                        
}

@end
