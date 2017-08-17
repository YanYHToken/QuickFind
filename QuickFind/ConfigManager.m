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
    RectVO *rect2 = [[RectVO alloc] initWith:2 width:70 height:70];
    return @[rect1, rect2];
}

@end
