//  BackgroundLayer.m
//  SpaceViking
#import "BackgroundLayer.h"

@implementation BackgroundLayer

+ (BackgroundLayer *)nodeWithBackground:(NSString *)background
{
    BackgroundLayer *layer = [[[BackgroundLayer alloc] initWithBackground:background] autorelease];
    return layer;
}

- (id)initWithBackground:(NSString *)background 
{
    self = [super init];                                           
    if (self != nil) {                                             
        CCSprite *backgroundImage;
        backgroundImage = [CCSprite spriteWithFile:background];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:
         CGPointMake(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:backgroundImage z:-1 tag:0];
    }
    return self;
}

-(id)init { 
    return [self initWithBackground:@"background_city.png"];
}

@end
