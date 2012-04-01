//
//  HUDLayer.m
//  maestro
//
//  Created by Matthew McGlincy on 3/25/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import "HUDLayer.h"
#import "GameManager.h"

#define MARGIN 20.0
#define TEARS_COLLECTED_KEY_PATH @"tearsCollected"

@interface HUDLayer()
@property (nonatomic, retain) CCLabelTTF *tearsCollectedLabel;
@end

@implementation HUDLayer

@synthesize tearsCollectedLabel = _tearsCollectedLabel;

- (void)dealloc
{
    [[GameManager sharedInstance] removeObserver:self forKeyPath:TEARS_COLLECTED_KEY_PATH];
    [_tearsCollectedLabel release];
    [super dealloc];
}

-(id) init
{
    self = [super init];
	if (self) {
		CGSize winSize = [[CCDirector sharedDirector] winSize];

        self.tearsCollectedLabel = [CCLabelTTF labelWithString:[self tearsCollectedString] fontName:@"Marker Felt" fontSize:28.0];
        self.tearsCollectedLabel.position =  ccp(winSize.width - self.tearsCollectedLabel.contentSize.width / 2 - MARGIN, 
                                         winSize.height - self.tearsCollectedLabel.contentSize.height / 2 - MARGIN);
        [self addChild:self.tearsCollectedLabel];
        
        //
        GameManager *gameManager = [GameManager sharedInstance];
        [gameManager addObserver:self
                      forKeyPath:TEARS_COLLECTED_KEY_PATH
                         options:0
                         context:nil];
	}
	return self;
}

- (NSString *)tearsCollectedString
{
    return [NSString stringWithFormat:@"%03d", [GameManager sharedInstance].tearsCollected];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
    GameManager *gameManager = [GameManager sharedInstance];
    if ([keyPath isEqualToString:TEARS_COLLECTED_KEY_PATH]) {
        self.tearsCollectedLabel.string = [self tearsCollectedString];
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

@end
