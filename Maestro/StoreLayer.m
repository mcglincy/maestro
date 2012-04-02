//
//  StoreLayer.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Constants.h"
#import "Devil.h"
#import "GameManager.h"
#import "GameScene.h"
#import "Floor.h"
#import "ShopSign.h"
#import "Store.h"
#import "StoreItem.h"
#import "StoreLayer.h"
#import "GameSoundManager.h"

@interface StoreLayer()

@property (nonatomic, retain) CCMenu *storeMenu;
@property (nonatomic, retain) CCLabelTTF *tearsLabel;
@property (nonatomic, retain) Devil *devil;

@end

@implementation StoreLayer

@synthesize devil = _devil;
@synthesize storeMenu = _storeMenu;
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

    [_devil release];
    [_storeMenu release];
    [_tearsLabel release];
    [super dealloc];
}

-(id)init { 
    self = [super init];                                           
    if (self != nil) {       
        self.isTouchEnabled = YES;
        
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithFile:@"shop-background.png"];        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:
         CGPointMake(winSize.width/2, winSize.height/2)];
        [self addChild:backgroundImage z:-1 tag:0];

        // tears remaining
        self.tearsLabel = [CCLabelTTF labelWithString:[self tearsString] fontName:FONT_NAME fontSize:28.0];
        self.tearsLabel.position =  ccp(winSize.width / 2 - self.tearsLabel.contentSize.width / 2, 
                                        winSize.height - self.tearsLabel.contentSize.height / 2 - 10);
        [self addChild:self.tearsLabel];

        // store sign
        ShopSign *shopSign = [ShopSign node];
        shopSign.position = ccp(250, 620);
        [self addChild:shopSign];
        
        // store menu
        [CCMenuItemFont setFontName:FONT_NAME];
        [CCMenuItemFont setFontSize:24];
        self.storeMenu = [CCMenu menuWithItems:nil];
        [self updateMenu];
        [self.storeMenu setPosition:ccp(250, 378)];        
        [self addChild:self.storeMenu];
        
        // done/continue button
//        CCMenuItem *doneItem = [CCMenuItemImage 
//                                    itemFromNormalImage:@"ButtonStar.png" selectedImage:@"ButtonStarSel.png" 
//                                    target:self selector:@selector(starButtonTapped:)];
        CCMenuItemFont *doneItem = [CCMenuItemFont itemWithString:@"Continue" block:^(id sender) {
            [self doneStore];
        }];
        doneItem.fontSize = 60;
        [doneItem setColor:ccc3(255, 255, 255)];
        CCMenu *doneMenu = [CCMenu menuWithItems:doneItem, nil];
        doneMenu.position = ccp(250, 98);
        [self addChild:doneMenu];
        
        GameManager *gameManager = [GameManager sharedInstance];
        [gameManager addObserver:self
                      forKeyPath:@"tearsCollectedTotal"
                         options:0
                         context:nil];

        self.devil = [Devil node];
        self.devil.position = ccp(900, 40 + self.devil.contentSize.height / 2);
        [self addChild:self.devil z:1];
        
        Floor *floor = [Floor node];
        floor.position = ccp(winSize.width / 2, 0 + floor.contentSize.height / 2);
        [self addChild:floor];

        //Reset music 
        [[GameSoundManager sharedInstance] stopMaestro];
        
        [[GameSoundManager sharedInstance].soundEngine playBackgroundMusic:@"Shop_Theme.wav"];
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
        
        [self.devil animateForPurchase];
    }
}

- (void)updateMenu
{
    [self.storeMenu removeAllChildrenWithCleanup:YES];
    GameManager *gameManager = [GameManager sharedInstance];
    for (StoreItem *storeItem in gameManager.store.items) {
        BOOL canAfford = [gameManager canAffordStoreItem:storeItem];
        BOOL alreadyPurchased = [gameManager hasAlreadyPurchasedStoreItem:storeItem];
        //NSString *checkmark = alreadyPurchased ? @"X ": @"  ";
        NSString *checkmark = @"";
        NSString *itemString = [NSString stringWithFormat:@"%@ %d - %@", checkmark, storeItem.price, storeItem.name];
        CCMenuItemFont *menuItem = [CCMenuItemFont itemWithString:itemString block:^(id sender) {
            [self buyStoreItem:storeItem];
        }];
        [menuItem setColor:ccc3(255, 255, 255)];
        if (!canAfford || alreadyPurchased) {
            menuItem.isEnabled = NO;
        }
        [self.storeMenu addChild:menuItem];
    }
    [self.storeMenu alignItemsVerticallyWithPadding:30];
}

- (void)doneStore 
{
    GameManager *gameManager = [GameManager sharedInstance];
    NSInteger nextLevelNum = gameManager.currentLevelNum + 1;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GameScene nodeWithLevelNum:nextLevelNum]]];                        
}

@end
