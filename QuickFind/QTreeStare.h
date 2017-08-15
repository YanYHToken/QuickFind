//
//  QTreeStare.h
//  QuickFind
//
//  Created by YanYH on 2017/8/12.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import "QTree.h"
//四叉树不规则切图
@interface QTreeStare : QTree

@property(nonatomic, strong)NSArray<RectVO *> *prs;
@property(nonatomic, strong)RectVO *maxRect;

- (instancetype)initWith:(int)width height:(int)height prs:(NSArray *)prs;
@end
