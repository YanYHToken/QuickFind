//
//  QTreeRect.h
//  QuickFind
//
//  Created by YanYH on 2017/8/12.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTreeRect : NSObject
@property(nonatomic, assign)int x;//x 坐标点
@property(nonatomic, assign)int y;//y 坐标点
@property(nonatomic, assign)int width;//item 的width
@property(nonatomic, assign)int height;//item 的height
@property(nonatomic, strong)id data; //区域数据
@property(nonatomic, assign)BOOL is_cut; //default YES  [self init]
@end
