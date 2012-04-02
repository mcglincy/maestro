//
//  GameLayer.m
//  maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright n/a 2012. All rights reserved.
//

#import "AppDelegate.h"


// Import the interfaces
#import "Constants.h"
#import "GameClock.h"
#import "GameLayer.h"
#import "GameManager.h"
#import "GameOverScene.h"
#import "GameScene.h"
#import "GameSoundManager.h"
#import "Floor.h"
#import "Maestro.h"
#import "Note.h"
#import "Person.h"
#import "Physics.h"
#import "PhysicsSprite.h"
#import "StoreScene.h"
#import "Tear.h"
#import "TearBin.h"
#import "VictoryScene.h"

#define MAX_LEVEL_IDX 2

@interface GameLayer()

@property (nonatomic, retain) NSMutableArray *touchPoints;
@property (nonatomic) BOOL leavingScene;

- (void)addTearAtPosition:(CGPoint)pos;

@end


@implementation GameLayer

@synthesize touchPoints = _touchPoints;
@synthesize levelNum = _levelNum;
@synthesize tapImpulsePower = _tapImpulsePower;
@synthesize leavingScene = _leavingScene;

- (void)dealloc
{
    [_touchPoints release];
	[super dealloc];
}

+ (GameLayer *)nodeWithLevelNum:(NSInteger)levelNum
{
    GameLayer *layer = [[[GameLayer alloc] initWithLevelNum:levelNum] autorelease];
    return layer;
}

- (id)initWithLevelNum:(NSInteger)levelNum
{
    self = [super init];
    if (self != nil) {

        self.levelNum = levelNum;
        
        self.tapImpulsePower = 10;
        
        self.touchPoints = [NSMutableArray array];
        
		// enable events
		self.isTouchEnabled = YES;
        
		// init physics
        [Physics sharedInstance];
        
		[self scheduleUpdate];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        Maestro *maestro = [Maestro node];
        maestro.position = ccp(maestro.contentSize.width / 2, 
                               FLOOR_HEIGHT + maestro.contentSize.height / 2);
        [self addChild:maestro z:1];                         
        
        Person *p1 = [Person node];
        p1.position = ccp(winSize.width - p1.contentSize.width / 2, 
                          FLOOR_HEIGHT + p1.contentSize.height / 2);
        [self addChild:p1 z:1];                         
        
        Person *p2 = [Person node];
        p2.position = ccp(winSize.width - p2.contentSize.width / 2 - 100, 
                          FLOOR_HEIGHT + p2.contentSize.height / 2);
        [self addChild:p2 z:1];   
        
        TearBin *tearBin = [TearBin node];
        tearBin.position = ccp(284, FLOOR_HEIGHT + tearBin.contentSize.height / 2);
        [self addChild:tearBin z:1];
        [tearBin addToPhysics];
        
        Floor *floor = [Floor node];
        floor.position = ccp(winSize.width / 2, 0 + floor.contentSize.height / 2);
        [self addChild:floor];
    }
    return self;    
}

- (id)init 
{
    return [self initWithLevelNum:1];
}

-(void)update:(ccTime) delta
{
    // update global singletons
    [[GameClock sharedInstance] update:delta];

    // check for level loss/victory
    if (!self.leavingScene) {
        
        GameManager *gameManager = [GameManager sharedInstance];
        [gameManager update:delta];
        [[Physics sharedInstance] update:delta];

        if ([gameManager outOfTime]) {
            // out of time!
            self.leavingScene = YES;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[GameOverScene node]]];
        } else if (gameManager.tearsCollectedThisLevel >= gameManager.tearsNeededThisLevel) {
            // got our requisite tears, so advance
            self.leavingScene = YES;
            NSInteger nextLevelNum = self.levelNum + 1;
            if (nextLevelNum > MAX_LEVEL_IDX) {
                [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[VictoryScene node]]];                        
            } else {
                [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[StoreScene node]]];            
            }
        }
    }
    
    //Apply impulses from touches
    if (nil != self.touchPoints) {
        for (int i = 0, len = [self.touchPoints count]; i < len; i++) {
            CGPoint point = [[self.touchPoints objectAtIndex:i] CGPointValue];
            cpVect vect = cpv(point.x, point.y);
            cpShape *shape = cpSpacePointQueryFirst([Physics sharedInstance].space, vect, CP_ALL_LAYERS, CP_NO_GROUP);
            
            if ((NULL != shape) && (NULL != shape->body)) {
                //Get a vector from the shape to the touch point and use that as the start for our physics impulse
                cpVect j = cpvsub(cpBodyGetPos(shape->body), vect);
                j = cpvmult(j, self.tapImpulsePower);
                cpBodyApplyImpulse(shape->body, j, cpvzero); 
            }
        }
    }
}

-(void)addTearAtPosition:(CGPoint)pos
{
	int posx, posy;
	
	posx = CCRANDOM_0_1() * 200.0f;
	posy = CCRANDOM_0_1() * 200.0f;
	
	posx = (posx % 4) * 85;
	posy = (posy % 3) * 121;
	
    Tear *tear = [Tear node];
    [self addChild:tear];
	tear.position = pos;
	
    [tear addToPhysics];
}

- (void)addNoteAtPosition:(CGPoint)pos
{
    Note *note = [Note node];
    note.position = ccp(260, 260);
    [self addChild:note z:2];

    CCMoveBy *moveBy = [CCMoveTo actionWithDuration:5.0 
                        position:pos];
    [note runAction:moveBy];   
}

#pragma mark - touch handling

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchPoints removeAllObjects];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        [self.touchPoints addObject:[NSValue valueWithCGPoint:location]];    
    }
}

- (void)addTouchPointWithTouches:(NSSet *)touches
{
    /*
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self.touchPoints addObject:[NSValue valueWithCGPoint:location]];    
     */
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //self.touchPoints = touches;
    //[self addTouchPointWithTouches:touches];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchPoints removeAllObjects];

    /*
	for (UITouch *touch in touches) {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
		//[self addTearAtPosition:location];
        [self addNoteAtPosition:location];
	}
     */
    
    //Assuming we roped in some tears, let's change the music on the next loop
//    if ([GameSoundManager sharedInstance].nextMaestroTrack < ([GameSoundManager sharedInstance].numMaestroTracks - 1)) {
//        [GameSoundManager sharedInstance].nextMaestroTrack++;
//        if ([GameSoundManager sharedInstance].nextMaestroTrack == [GameSoundManager sharedInstance].numMaestroTracks - 1) {
//            //This is the last track, stop looping
//            [[GameSoundManager sharedInstance] stopMaestroAfterNextLoop];
//        }
//    }
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self.touchPoints removeAllObjects];
}

/* >>>>
- (void)draw
{
    [super draw];
    CGPoint cgVertices[[self.touchPoints count]];
    
    for (int i = 0, len = [self.touchPoints count]; i < len; i++) {
        CGPoint point = [[self.touchPoints objectAtIndex:i] CGPointValue];
        cgVertices[i] = point;
    }
    ccDrawPoly(cgVertices, [self.touchPoints count], YES);
}
 <<<< */

@end
