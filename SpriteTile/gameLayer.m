//
//  game.m
//  SpriteTile
//
//  Created by mettoboshi on 13/02/11.
//  Copyright 2013 mettobo. All rights reserved.
//

#import "gameLayer.h"

@implementation gameLayer

+ (CCScene *) scene
{
    //シーンの追加
    CCScene *scene = [CCScene node];
    gameLayer *layer = [gameLayer node];
    [scene addChild: layer];
    
    return scene;
}

-(id) init {
    [super init];
    
    tileSize = CGPointMake(20, 20);
    velocityNum = 20;
    changeVelocity = false;
    
    CGSize winSize =[[CCDirector sharedDirector] winSize];

    tileNumX = (int)winSize.width / tileSize.x;
    tileNumY = (int)winSize.height / tileSize.y;

    CCLOG(@"(x, y): %d, %d", tileNumX, tileNumY);
    
    cols = [NSMutableArray array];
    
    batch = [CCSpriteBatchNode batchNodeWithFile:@"tile.png"];
    
    for (int i = 0; i < tileNumY; i++) {
        rows = [NSMutableArray array];
        for (int j =0; j < tileNumX; j++) {
            Tile *sprite = [Tile spriteWithFile:@"tile.png"];
            
            sprite.position = CGPointMake(j * tileSize.x + (tileSize.x / 2),
                                          i * tileSize.y + (tileSize.y / 2));
            [rows addObject:sprite];
            [batch addChild:sprite];
        }
        [cols addObject:rows];
    }
    [cols retain];
    
    NSLog( @"cols:alloc -> %d", [cols retainCount] );
    NSLog( @"rows:alloc -> %d", [rows retainCount] );
    
    [self addChild:batch];
    [self movePoint];

    return self;
}


-(void) movePoint {
    point = [MoveItem spriteWithFile:@"tile.png"];
    [point setVelocity:CGPointMake(10, 0)];
    point.position = CGPointMake((tileSize.x / 2), (tileSize.y / 2));
    [point setColor:ccc3(255,0,0)];
    [self addChild:point];

    [self scheduleUpdate];
    
}

-(void) update:(ccTime)delta {
    changeVelocity = false;
    CGSize winSize =[[CCDirector sharedDirector] winSize];
    point.position = ccpAdd(point.position, point.velocity);

    // pointと当たったオブジェクトの色を変える
    float hit = [point texture].contentSize.width;
    for (int i = 0; i < tileNumY; i++) {
        for(int j = 0; j < tileNumX; j++) {
            Tile* temp = [[cols objectAtIndex:i] objectAtIndex:j];
            
            float distance = ccpDistance(point.position, temp.position);
                        
            if (hit > distance && temp.nowPointFlag == false) {
                
                temp.nowPointFlag = true;
                temp.colorChangeFlag = true;
            }
            
            if (0 < distance && temp.nowPointFlag == true
                && temp.colorChangeFlag == true
                && ((temp.position.x < point.position.x && point.velocity.x > 0)
                 || (temp.position.y < point.position.y && point.velocity.y > 0)
                 || (temp.position.x > point.position.x && point.velocity.x < 0)
                 || (temp.position.y > point.position.y && point.velocity.y < 0))) {
                [temp setColor:ccc3(0,255,0)];
                temp.nowPointFlag = false;
            }
            
            // 進んでいる方向のTileとの距離を調べる
            int tmpTileNumX = 0;
            int tmpTileNumY = 0;
            float distanceDirection = 0;
            Tile* tempDirection = nil;

            if (point.velocity.x > 0) {
                tmpTileNumX = (int) (point.position.x / tileSize.x) + 1;
                tmpTileNumY = (int) (point.position.y / tileSize.y);
                
                if (tmpTileNumX >= tileNumX) {
                    tmpTileNumX = 0;
                }

            } else if (point.velocity.x < 0) {
                tmpTileNumX = ((int) (point.position.x / tileSize.x)) - 1;
                tmpTileNumY = (int) (point.position.y / tileSize.y);

                if (tmpTileNumX < 0) {
                    tmpTileNumX = tileNumX - 1;
                }
                
            } else if (point.velocity.y > 0) {
                tmpTileNumX = (int) (point.position.x / tileSize.x);
                tmpTileNumY = (int) (point.position.y / tileSize.y) + 1;
                
                if (tmpTileNumY >= tileNumY) {
                    tmpTileNumY = 0;
                }

            } else if (point.velocity.y < 0) {
                tmpTileNumX = (int) (point.position.x / tileSize.x);
                tmpTileNumY = (int) (point.position.y / tileSize.y) - 1;

                if (tmpTileNumY < 0) {
                    tmpTileNumY = tileNumY - 1;
                }
 
            }

            tempDirection = [[cols objectAtIndex:tmpTileNumY] objectAtIndex:tmpTileNumX];
            distanceDirection = ccpDistance(point.position, tempDirection.position);
            
            // 画面の端に来たら方向転換
            if ((point.position.x + ([point texture].contentSize.width / 2) >= winSize.width)
                && point.velocity.x > 0) {
                [point setVelocity:CGPointMake(0, velocityNum)];
                changeVelocity = true;
            } else if (point.position.y + ([point texture].contentSize.height / 2) >= winSize.height
                       && point.velocity.y > 0) {
                [point setVelocity:CGPointMake(-velocityNum, 0)];
                changeVelocity = true;
            } else if (point.position.x - ([point texture].contentSize.width / 2) <= 0
                       && point.velocity.x < 0) {
                [point setVelocity:CGPointMake(0, -velocityNum)];
                changeVelocity = true;
            } else if (point.position.y - ([point texture].contentSize.height / 2) <= 0
                       && point.velocity.y < 0) {
                [point setVelocity:CGPointMake(velocityNum, 0)];
                changeVelocity = true;
            }
            
            // 進行方向の隣のTileの色が変更済みであれば方向転換
            if (distanceDirection <= hit && tempDirection.colorChangeFlag == true && changeVelocity == false) {
                if (point.velocity.x > 0) {
                    [point setVelocity:CGPointMake(0, velocityNum)];
                } else if (point.velocity.y > 0) {
                    [point setVelocity:CGPointMake(-velocityNum, 0)];
                } else if (point.velocity.x < 0) {
                    [point setVelocity:CGPointMake(0, -velocityNum)];
                } else if (point.velocity.y < 0) {
                    [point setVelocity:CGPointMake(velocityNum, 0)];
                }
            }

        }
    }
}

@end
