//
//  RectVO.m
//  QuickFind
//
//  Created by YanYH on 2017/8/11.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import "RectVO.h"

@implementation RectVO
- (instancetype)initWith:(int)identity width:(int)width height:(int)height
{
    self = [super init];
    if(self)
    {
        self.identity = identity;
        self.width = width;
        self.height = height;
    }
    return self;
}

- (NSDictionary *)data
{
    NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
    [mutDict setObject:@(random() % 100) forKey:@"score"];
    [mutDict setObject:@"type" forKey:@"type"];
    return mutDict;
}
@end
