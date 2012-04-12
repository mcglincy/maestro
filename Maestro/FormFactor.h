//
//  FormFactor.h
//  Maestro
//
//  Created by Matthew McGlincy on 4/11/12.
//  Copyright (c) 2012 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormFactor : NSObject

+ (BOOL)isIPhone;
+ (BOOL)isIPad;
+ (CGFloat)floorHeight;
+ (CGFloat)tearPhysicsBodyDiameter;
+ (CGFloat)violinCasePositionX;

@end
