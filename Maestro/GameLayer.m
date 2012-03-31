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
#import "Person.h"
#import "Physics.h"
#import "PhysicsSprite.h"
#import "Tear.h"

enum {
	kTagParentNode = 1,
};


@interface GameLayer()
-(void) addNewSpriteAtPosition:(CGPoint)pos;
-(void) initPhysics;
@end


@implementation GameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
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

- (void)dealloc
{
	[super dealloc];
	
}

-(void) update:(ccTime) delta
{
    [[Physics sharedInstance] update:delta];
}

-(void) addNewSpriteAtPosition:(CGPoint)pos
{
	int posx, posy;
	
	posx = CCRANDOM_0_1() * 200.0f;
	posy = CCRANDOM_0_1() * 200.0f;
	
	posx = (posx % 4) * 85;
	posy = (posy % 3) * 121;
	
//	PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(posx, posy, 85, 121)];
    PhysicsSprite *sprite = [Tear node];
	//[parent addChild: sprite];
    [self addChild:sprite];
	
	sprite.position = pos;
	
	int num = 4;
	CGPoint verts[] = {
		ccp(-24,-54),
		ccp(-24, 54),
		ccp( 24, 54),
		ccp( 24,-54),
	};
	
	cpBody *body = cpBodyNew(1.0f, cpMomentForPoly(1.0f, num, verts, CGPointZero));
	
	body->p = pos;
	cpSpaceAddBody([[Physics sharedInstance] space], body);
	
	cpShape* shape = cpPolyShapeNew(body, num, verts, CGPointZero);
	shape->e = 0.5f; shape->u = 0.5f;
	cpSpaceAddShape([[Physics sharedInstance] space], shape);
	
	[sprite setPhysicsBody:body];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		[self addNewSpriteAtPosition: location];
	}
}

@end
