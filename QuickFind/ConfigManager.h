//
//  ConfigManager.h
//  QuickFind
//
//  Created by YanYH on 2017/8/11.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RectVO.h"


@interface ConfigManager : NSObject
@property(nonatomic, strong)NSArray<RectVO *> *rectVec;

+ (ConfigManager *)sharedInstance;
@end
