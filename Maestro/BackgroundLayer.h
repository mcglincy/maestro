#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackgroundLayer : CCLayer {
    
}

+ (BackgroundLayer *)nodeWithBackground:(NSString *)background;
- (id)initWithBackground:(NSString *)background;

@end
