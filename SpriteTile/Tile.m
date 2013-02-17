//
//  Tile.m
//  SpriteTile
//
//  Created by mettoboshi on 2013/02/17.
//  Copyright 2013年 mettobo. All rights reserved.
//

#import "Tile.h"

@implementation Tile

@synthesize colorChangeFlag;
@synthesize nowPointFlag;

-(id) init {
    [super init];
    colorChangeFlag = false;
    nowPointFlag = false;

    return self;
}

@end
