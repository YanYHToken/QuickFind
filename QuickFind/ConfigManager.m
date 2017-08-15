//
//  ConfigManager.m
//  QuickFind
//
//  Created by YanYH on 2017/8/11.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import "ConfigManager.h"

@implementation ConfigManager

+ (ConfigManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static ConfigManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ConfigManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.rectVec = [self createRects];
    }
    return self;
}



- (NSArray *)createRects
{
    RectVO *rect1 = [[RectVO alloc] initWith:1 width:80 height:80];
    RectVO *rect2 = [[RectVO alloc] initWith:2 width:80 height:90];
    RectVO *rect3 = [[RectVO alloc] initWith:3 width:80 height:100];
    RectVO *rect8 = [[RectVO alloc] initWith:7 width:100 height:80];
    RectVO *rect9 = [[RectVO alloc] initWith:7 width:90 height:80];
    RectVO *rect10 = [[RectVO alloc] initWith:7 width:120 height:120];
    return @[rect1, rect2, rect3, rect8, rect9, rect10];
}

@end
