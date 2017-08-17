//
//  PictureView.m
//  QuickFind
//
//  Created by qwater on 2017/8/17.
//  Copyright © 2017年 qwater. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF" withAlpha:0.7];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        [self configLabel];
    }
    return self;
}


- (void)configLabel
{
    self.titleLabel.font = [UIFont systemFontOfSize:25];
    [self setTitle:[NSString stringWithFormat:@"%i", (int)random() % 10] forState:UIControlStateNormal];
    UIColor *textColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%i", (int)random() % 1000000]];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}


- (void)click
{
   int score = [[self.rect.data objectForKey:@"score"] intValue];
    NSLog(@"score %i", score);
    CGFloat t = 0.1;
    CGAffineTransform oriTrans = self.transform;
    CGAffineTransform translateRight  = CGAffineTransformRotate(self.transform, t);
    CGAffineTransform translateLeft = CGAffineTransformRotate(self.transform, -t);
    
    self.transform = translateLeft;
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:4];
        self.transform = translateRight;
    } completion:^(BOOL finished)
    {
        if(finished)
        {
            [self setTitle:[NSString stringWithFormat:@"%i", (int)random() % 10] forState:UIControlStateNormal];

            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform = oriTrans;
            } completion:NULL];
        }
    }];
}


- (void)setRect:(QTreeRect *)rect
{
    _rect = rect;
}





@end
