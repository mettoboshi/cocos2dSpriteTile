//
//  game.h
//  SpriteTile
//
//  Created by mettoboshi on 13/02/11.
//  Copyright 2013 mettobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tile.h"
#import "MoveItem.h"


@interface gameLayer : CCLayer {

    NSMutableArray *rows;
    NSMutableArray *cols;
    
    MoveItem* point;
    CCSpriteBatchNode* batch;
    CGPoint tileSize;
    
    int tileNumX;
    int tileNumY;
    
    int velocityNum;
    bool changeVelocity;
}

+ (CCScene *) scene;
//-(id) init;

- (void) movePoint;
- (void) update:(ccTime)delta;

@end
