//
//  MapLayer.m
//  Maestro
//
//  Created by Matthew McGlincy on 4/1/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "Constants.h"
#import "GameScene.h"
#import "MapLayer.h"

@interface MapLayer()

@property (nonatomic, retain) CCMenuItemFont *level1Item;
@property (nonatomic, retain) CCMenuItemFont *level2Item;
@property (nonatomic, retain) CCMenuItemFont *level3Item;
@property (nonatomic, retain) CCMenuItemFont *level4Item;

@end

@implementation MapLayer

@synthesize level1Item = _level1Item;
@synthesize level2Item = _level2Item;
@synthesize level3Item = _level3Item;
@synthesize level4Item = _level4Item;

- (void)dealloc
{
    [_level1Item release];
    [_level2Item release];
    [_level3Item release];
    [_level4Item release];
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
        self.level1Item = [CCMenuItemFont itemWithString:@"Level 1" block:^(id sender) {
            [self startLevel:1];
        }];
        self.level2Item = [CCMenuItemFont itemWithString:@"Level 2" block:^(id sender) {
            [self startLevel:2];
        }];
        self.level3Item = [CCMenuItemFont itemWithString:@"Level 3" block:^(id sender) {
            [self startLevel:3];
        }];
        self.level4Item = [CCMenuItemFont itemWithString:@"Level 4" block:^(id sender) {
            [self startLevel:4];
        }];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCMenu *menu = [CCMenu menuWithItems:self.level1Item, self.level2Item, self.level3Item, self.level4Item, nil];
        [menu alignItemsVerticallyWithPadding:30];
        [menu setPosition:ccp(winSize.width / 2, winSize.height / 2 + 200)];
        
        // Add the menu to the layer
        [self addChild:menu];
    }
    return self;
}

- (void)startLevel:(NSInteger)levelNum
{
    GameScene *gameScene = [GameScene nodeWithLevelNum:levelNum];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:SCENE_TRANSITION_TIME scene:gameScene]];
}

#pragma mark - touch handlers
/* >>>>
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GameScene node]]];
    //[[GameSoundManager sharedInstance] fadeOutMusic]; //Not sure how to get the audio back properly after the fade
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
<<<< */
@end
