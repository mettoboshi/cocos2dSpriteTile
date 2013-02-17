//
//  Tile.h
//  SpriteTile
//
//  Created by mettoboshi on 2013/02/17.
//  Copyright 2013年 mettobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Tile : CCSprite {
    bool colorChangeFlag;
    bool nowPointFlag;
}

- (id)init;

@property bool colorChangeFlag;
@property bool nowPointFlag;

@end
