//
//  GameLayer.h
//  maestro
//
//  Created by Matthew McGlincy on 3/31/12.
//  Copyright n/a 2012. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface GameLayer : CCLayer
{
	CCTexture2D *spriteTexture_; // weak ref
	
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
