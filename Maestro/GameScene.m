//
//  GameScene.m
//  Molyjam
//
//  Created by Matthew McGlincy on 3/30/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "BackgroundLayer.h"
#import "GameLayer.h"
#import "GameManager.h"
#import "GameScene.h"
#import "GameSoundManager.h"
#import "HUDLayer.h"

@interface GameScene()
@property (nonatomic, retain) NSString *background;
@property (nonatomic, retain) NSString *music;
@end

@implementation GameScene

@synthesize levelNum = _levelNum;
@synthesize background = _background;
@synthesize music = _music;
@synthesize maxTime = _maxTime;
@synthesize tearsNeeded = _tearsNeeded;

- (void)dealloc
{
    [_background release];
    [_music release];
    [super dealloc];
}

+ (GameScene *)nodeWithLevelNum:(NSInteger)levelNum
{
    NSLog(@"starting GameScene level num %d", levelNum);
    GameScene *scene = [[[GameScene alloc] initWithLevelNum:levelNum] autorelease];
    return scene;
}

- (id)initWithLevelNum:(NSInteger)levelNum
{
    self = [super init];
    if (self != nil) {
        self.levelNum = levelNum;
        [self configureForLevelNum];
        
        BackgroundLayer *backgroundLayer = [BackgroundLayer nodeWithBackground:self.background];
        [self addChild:backgroundLayer z:0];  
        
        HUDLayer *hudLayer = [HUDLayer node];       
        [self addChild:hudLayer z:1];                         
        
        GameLayer *gameLayer = [GameLayer nodeWithLevelNum:levelNum];
        [self addChild:gameLayer z:0];                         
    }
    return self;    
}

- (id)init {
    return [self initWithLevelNum:1];
}

- (void)configureForLevelNum
{
    switch (self.levelNum) {
        case 0:
            self.background = @"background_rome.png";
            self.music = @"maestro_0.wav";
            self.maxTime = 20;
            self.tearsNeeded = 10;
            break;
        case 1:
            self.background = @"background_berlin.png";
            self.music = @"maestro_1.wav";
            self.maxTime = 20;
            self.tearsNeeded = 10;
            break;
        case 2:
            self.background = @"background_city.png";
            self.music = @"maestro_2.wav";
            self.maxTime = 20;
            self.tearsNeeded = 10;
            break;            
        default:
            break;
    }
}

- (void)onEnter
{
    [super onEnter];
    
#warning Make this a smooth audio fade
    [[GameSoundManager sharedInstance].soundEngine stopBackgroundMusic];
    //[[GameSoundManager sharedInstance] fadeOutMusic];
    //[[GameSoundManager sharedInstance] playMaestro];
    [[GameSoundManager sharedInstance].soundEngine playBackgroundMusic:self.music];
    
    // set up the GameManager for this level
    GameManager *gameManager = [GameManager sharedInstance];
    [gameManager resetForGameScene:self];
}

@end
