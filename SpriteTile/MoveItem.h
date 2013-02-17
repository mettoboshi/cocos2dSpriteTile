//
//  MoveItem.h
//  SpriteTile
//
//  Created by mettoboshi on 2013/02/17.
//  Copyright 2013年 mettobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MoveItem : CCSprite {
    CGPoint velocity;
}

- (void)setVelocity:(CGFloat)x Y:(CGFloat)y;

@property CGPoint velocity;

@end
