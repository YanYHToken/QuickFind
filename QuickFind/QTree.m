//
//  QTree.m
//  QuickFind
//
//  Created by YanYH on 2017/8/12.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import "QTree.h"
#import "QTreeRect.h"



float random_yyh()
{
    float rand = (float)(1+arc4random()%99)/100.0;
//    printf("rand = %f",rand);
    return rand;
}

@implementation QTree


- (instancetype)initWith:(int)width height:(int)height
{
    self = [super init];
    if(self)
    {
        self.maps = [[NSMutableArray alloc] init];
        self.blank = [[NSMutableArray alloc] init];
        //根结点
        self.root = [[QTreeNode alloc] init];
        QTreeRect *rect = [[QTreeRect alloc] init];
        rect.x = rect.y = 0;
        rect.width = width;
        rect.height = height;
        //🌲区域大小
        self.root.rect = rect;
        //🌲的深度
        self.root.level = _depth;
        //创建子🌲
        [self buildBranch:self.root];
    }
    return self;
}


- (RectVO *)minRect
{
    if(!_minRect)
    {
        _minRect = [[RectVO alloc] initWith:0 width:80 height:80];
    }
    return _minRect;
}

/**
 * 创建parent的四个子节点
 * @param parent 父节点  parent.rect 父节点的Rect
 *
 */
- (void)buildBranch:(QTreeNode *)parent
{
    //分割他的爹
    NSMutableArray <QTreeRect *> *childrenRects = [self cut:parent.rect];
    NSMutableArray <QTreeNode *> *vec = [[NSMutableArray alloc] init];
    //入栈
    BOOL isPutMaps = NO;
    //孩子的数量
    NSInteger len = childrenRects.count;
    for (int i = 0; i < len; i++)
    {
        QTreeRect *rect = childrenRects[i];
        //判断区域是不是合法
        if ([self check:rect] == NO) {
            //不合法继续下一个
            continue;
        }
        //判断区域是不是裁剪了
        if(rect.is_cut == NO)
        {
            //没有被裁剪
            isPutMaps = YES;
            //添加到 拼图数据结构中
            [self.maps addObject:rect];
            //继续下一个操作
            continue;
        }
        // 合法  没有裁剪
        //创建一个🌲节点  进入下一个🌲操作
        QTreeNode *node = [[QTreeNode alloc] init];
        node.rect = rect;
        node.level = parent.level + 1;
        if (_depth < node.level) {
            _depth = node.level;
        }
        //创建子🌲   递归
        [self buildBranch:node];
        [vec addObject:node];
    }
    //孩子节点数为0   并且没有添加  父节点区域置于 拼图数据结构中
    if (vec.count == 0 && isPutMaps == NO) {
        [self.maps addObject:parent.rect];
    }
    parent.subs = vec;
}


- (BOOL)check:(QTreeRect *)rect
{
    //区域大小判断
    if (rect.width < self.minRect.width && rect.height < self.minRect.height) {
        return NO;
    }
    return YES;
}

/**
 * 将父节点切分成四个子节点
 * @param rect 父节点的Rect
 */
- (NSMutableArray *)cut:(QTreeRect *)rect
{
    //子节点 vector
    NSMutableArray<QTreeRect *> *vec = [[NSMutableArray alloc] init];
    //子节点区域分割大小
    int nw = rect.width / 2;
    int nh = rect.height / 2;
    int i = 0;
    //分成四个象限的图
    for (int len = 4; i < len; i++)
    {
        QTreeRect *r = [[QTreeRect alloc] init];
        r.data = [rect data];
        r.width = nw;
        r.height = nh;
        switch (i) {
            case 0:
                //第一象限
                r.x = rect.x;
                r.y = rect.y;
                break;
            case 1:
                //第二象限
                r.x = rect.x + nw;
                r.y = rect.y;
                break;
            case 2:
                //第三象限
                r.x = rect.x;
                r.y = rect.y + nh;
                break;
            case 3:
                //第四象限
                r.x = rect.x + nw;
                r.y = rect.y + nh;
                break;
        }
        [vec addObject:r];
    }
    return vec;
}

@end
