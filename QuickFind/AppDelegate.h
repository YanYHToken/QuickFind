//
//  AppDelegate.h
//  QuickFind
//
//  Created by qwater on 2017/8/11.
//  Copyright © 2017年 qwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

