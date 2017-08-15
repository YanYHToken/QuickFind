//
//  QTree.h
//  QuickFind
//
//  Created by YanYH on 2017/8/12.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTreeRect.h"
#import "QTreeNode.h"
#import "RectVO.h"

/*  象限划分 ^
   UL(1)   |    UR(2)
 ----------|-----------
   BL(3)   |    BR(4)
 */
typedef enum
{
    UL = 1,// UR第一象限
    UR = 2, // UL为第二象限
    BL = 3, // BL为第三象限
    BR = 4  // BR为第四象限
}QuadrantEnum;


float random_yyh();

//四叉树规则切图
@interface QTree : NSObject
//最终拼图
@property(nonatomic, strong)NSMutableArray<QTreeRect *> *maps;
//空白间隙
@property(nonatomic, strong)NSMutableArray<QTreeRect *> *blank;
//根节点
@property(nonatomic, strong)QTreeNode *root;
//深度
@property(nonatomic, strong)RectVO *minRect;

@property(nonatomic, assign)int depth;

- (instancetype)initWith:(int)width height:(int)height;

//检查Rect
- (BOOL)check:(QTreeRect *)rect;
//裁剪rect
- (NSMutableArray *)cut:(QTreeRect *)rect;
@end
