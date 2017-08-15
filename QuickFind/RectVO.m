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
@end
