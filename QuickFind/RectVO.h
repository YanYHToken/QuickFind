//
//  RectVO.h
//  QuickFind
//
//  Created by YanYH on 2017/8/11.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RectVO : NSObject
@property(nonatomic, assign)int identity;
@property(nonatomic, assign)int width;
@property(nonatomic, assign)int height;

- (instancetype)initWith:(int)identity width:(int)width height:(int)height;

- (NSDictionary *)data;
@end
