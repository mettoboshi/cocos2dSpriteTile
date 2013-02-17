//
//  MoveItem.m
//  SpriteTile
//
//  Created by mettoboshi on 2013/02/17.
//  Copyright 2013年 mettobo. All rights reserved.
//

#import "MoveItem.h"

@implementation MoveItem

@synthesize velocity;

-(void) setVelocity:(CGFloat)x :(CGFloat)y; {
    
    velocity = CGPointMake(x, y);
}

@end
