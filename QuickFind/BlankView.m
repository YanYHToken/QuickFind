//
//  BlankView.m
//  QuickFind
//
//  Created by qwater on 2017/8/17.
//  Copyright © 2017年 qwater. All rights reserved.
//

#import "BlankView.h"

@implementation BlankView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor colorWithHexString:@"7AC5CD" withAlpha:0.7];
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}


@end
