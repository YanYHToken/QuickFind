//
//  UIColor+Category.h
//  QuickFind
//
//  Created by YanYH on 2017/8/14.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+(UIColor*)colorWithHexString:(NSString*)str withAlpha:(float)a;

+(UIColor*)colorWithHexString:(NSString*)str;
@end
