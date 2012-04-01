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
#import "GameLayer.h"
#import "Maestro.h"
#import "Note.h"
#import "Person.h"
#import "Physics.h"
#import "PhysicsSprite.h"
#import "Tear.h"

@interface GameLayer()

@property (nonatomic, retain) NSMutableArray *touchPoints;

-(void) addTearAtPosition:(CGPoint)pos;
-(void) initPhysics;

@end


@implementation GameLayer

@synthesize touchPoints = _touchPoints;

- (void)dealloc
{
    [_touchPoints release];
	[super dealloc];
}

-(id) init
{
	if( (self=[super init])) {
		
        self.touchPoints = [NSMutableArray array];

		// enable events
		self.isTouchEnabled = YES;
		
		// init physics
		[self initPhysics];
						
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
	}
	
	return self;
}

-(void) initPhysics
{
    [Physics sharedInstance];
}

-(void)update:(ccTime) delta
{
    [[Physics sharedInstance] update:delta];
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

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchPoints removeAllObjects];
    [self addTouchPointWithTouches:touches];
}

- (void)addTouchPointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self.touchPoints addObject:[NSValue valueWithCGPoint:location]];    
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [self addTouchPointWithTouches:touches];
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
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self.touchPoints removeAllObjects];
}

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

@end
