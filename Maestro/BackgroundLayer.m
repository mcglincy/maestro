//  BackgroundLayer.m
//  SpaceViking
#import "BackgroundLayer.h"

@implementation BackgroundLayer

-(id)init { 
    self = [super init];                                           
    if (self != nil) {                                             
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithFile:@"background.png"];

        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:
         CGPointMake(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:backgroundImage z:0 tag:0];
    }
    return self;
}

@end
