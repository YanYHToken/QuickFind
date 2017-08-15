//
//  QTreeNode.h
//  QuickFind
//
//  Created by YanYH on 2017/8/12.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTreeRect.h"
@interface QTreeNode : NSObject
@property(nonatomic, assign)int level;//级点
@property(nonatomic, strong)QTreeRect *rect; //节点矩形区域
@property(nonatomic, strong)NSMutableArray<QTreeNode*> *subs;//节点子节点数据
@end
