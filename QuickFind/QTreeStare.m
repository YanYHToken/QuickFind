//
//  QTreeStare.m
//  QuickFind
//
//  Created by YanYH on 2017/8/12.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import "QTreeStare.h"

@implementation QTreeStare

- (instancetype)initWith:(int)width height:(int)height prs:(NSArray *)prs
{
    self = [super init];
    if(self)
    {
        //图片规格
        self.prs = prs;
        [self prepare];
        self = [super initWith:width height:height];
    }
    return self;
}


- (void)prepare
{
    self.minRect = [[RectVO alloc] init];
    self.maxRect = [[RectVO alloc] init];
    //找到区域可能的最小值
    self.minRect.height = self.minRect.width = INT_MAX;
    //找到区域可能的最大值
    self.maxRect.height = self.maxRect.width = -INT_MAX;
    for(RectVO *r in self.prs)
    {
        //找到width的最小值
        if (self.minRect.width > r.width)
        {
            self.minRect.width = r.width;
        }
        //找到height的最小值
        if (self.minRect.height > r.height)
        {
            self.minRect.height = r.height;
        }
        //找到width的最大值
        if (self.maxRect.width < r.width)
        {
            self.maxRect.width = r.width;
        }
        //找到height的最大值
        if (self.maxRect.height < r.height)
        {
            self.maxRect.height = r.height;
        }
    }
    NSLog(@"%@,   %@", self.minRect, self.maxRect);
}

- (BOOL)check:(QTreeRect *)rect
{
    if (rect.width < self.minRect.width || rect.height < self.minRect.height) {
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
    NSMutableArray<QTreeRect *> *vec = [[NSMutableArray alloc] init];

    //随机取一种图片大小作为目标
    RectVO *pr = [self randomRectVO:rect];
    if (pr)
    {
        //修改二或三象限的WH
        NSArray *whs = [self calculateRectWH:pr parent:rect];
        //随机修改目标的象限
        NSArray *randomRects = [self randomTargetLocation:whs];
        int i = 0;
        int len = (int)randomRects.count;
        for (; i < len; i++)
        {
            QTreeRect *childRect = randomRects[i];
            //获取他爹的坐标 加上自己的坐标位置  就是最终位置
            childRect.x += rect.x;
            childRect.y += rect.y;
            //判断区域是不是合法
            if (childRect.width >= self.minRect.width && childRect.height >= self.minRect.height)
            {
                [vec addObject:childRect];
            }
            else
            {
                //可绘制区域
                if (childRect.width > 0 && childRect.height > 0) {
                    [self.blank addObject:childRect];
                }
            }
        }
    }
    
    return vec;
}


- (NSArray *)randomTargetLocation:(NSArray *)whs
{
    //象限的随机数
    int index = (int)(random_yyh() * (BR + 1));
    //最大值
    index = MAX(1, index);
    //象限中的最小值
    index = MIN(BR, index);
    //第一象限的rect
    QTreeRect *r = [[QTreeRect alloc] init];
    r.is_cut = NO;
    r.width = [whs[0][0] intValue];
    r.height = [whs[0][1] intValue];
    //第二象限的rect
    QTreeRect *r1 = [[QTreeRect alloc] init];
    r1.width = [whs[1][0] intValue];
    r1.height = [whs[1][1] intValue];
    //第三象限的rect
    QTreeRect *r2 = [[QTreeRect alloc] init];
    r2.width = [whs[2][0] intValue];
    r2.height = [whs[2][1] intValue];
    //第四象限的rect
    QTreeRect *r3 = [[QTreeRect alloc] init];
    r3.width = [whs[3][0] intValue];
    r3.height = [whs[3][1] intValue];
    //每一个象限的位置 大小赋值
    switch (index) {
        case UL:
            r.x = 0;
            r.y = 0;
            r1.y = 0;
            r1.x = r.width;
            r2.x = 0;
            r2.y = r.height;
            r3.y = r1.height;
            r3.x = r2.width;
            break;
        case UR:
            r.x = r1.width;
            r.y = 0;
            r1.y = 0;
            r1.x = 0;
            r2.x = r3.width;
            r2.y = r.height;
            r3.y = r1.height;
            r3.x = 0;
            break;
        case BL:
            r.x = 0;
            r.y = r2.height;
            r1.x = r.width;
            r1.y = r3.height;
            r2.x = 0;
            r2.y = 0;
            r3.x = r2.width;
            r3.y = 0;
            break;
        case BR:
            r3.x = 0;
            r3.y = 0;
            r1.x = 0;
            r1.y = r3.height;
            r2.y = 0;
            r2.x = r3.width;
            r.x = r1.width;
            r.y = r2.height;
            break;
    }
    return @[r, r1, r2, r3];
}


/**
 宽高的获取

 @param rect 目标rect
 @param parent 他爹的rect
 @return 宽高数组
 */
- (NSArray *)calculateRectWH:(RectVO *)rect parent:(QTreeRect *)parent
{
    NSArray *wh;
    int width = rect.width;
    int height = rect.height;
    //宽度的差值
    int dwidth = parent.width - rect.width;
    //高度的差值
    int dheight = parent.height - rect.height;
    //宽大于高
    if (dheight > self.maxRect.height)
    {
        //NSLog(@"h1 > self.maxRect.height");
        int w2 = dwidth;
        int h2 = (dheight + height) / 2;
        h2 = h2 - h2 % self.minRect.height;
        int w3 = width;
        int h3 = dheight;
        dheight = height + dheight - h2;
        wh = @[@[@(width), @(height)], @[@(w2), @(h2)], @[@(w3), @(h3)], @[@(dwidth), @(dheight)]];
    }
    else if (dwidth > self.maxRect.width)
    {
        int w2 = dwidth;
        int h2 = height;
        int w3 = (int)((dwidth + width) / 2);
        w3 = w3 - w3 % self.minRect.width;
        int h3 = dheight;
        dwidth = width + dwidth - w3;
        wh =  @[@[@(width), @(height)], @[@(w2), @(h2)], @[@(w3), @(h3)], @[@(dwidth), @(dheight)]];
    }
    else
    {
        wh =  @[@[@(width), @(height)], @[@(dwidth), @(height)], @[@(width), @(dheight)], @[@(dwidth), @(dheight)]];
    }

    return wh;
}



//随机取一种图片大小
- (RectVO *)randomRectVO:(QTreeRect *)rect
{
    //随机目标
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.prs.count; i++)
    {
        
        RectVO *r = _prs[i];
        //拿到宽高都小于 他爹的rect
        if (r.width <= rect.width && r.height <= rect.height)
        {
            //宽高并不相等的rect
            if (!(r.width == rect.width && r.height == rect.height))
            {
                //添加到临时数组里
                [tmp addObject:r];
            }
        }
    }
    //临时
    int prsCurrLen = (int)tmp.count;
    //没有可以使用的区域
    if (prsCurrLen == 0)
    {
        return nil;
    }
    //数组下标随机  随机啊
    int index = (int)(random_yyh() * (prsCurrLen + 1)) - 1;
    //找到最大值
    index = MAX(0, index);
    //找到最大值
    index = MIN(prsCurrLen - 1, index);
    //返回可以使用的区域额
    RectVO *pr = tmp[index];
    return pr;
}
@end
