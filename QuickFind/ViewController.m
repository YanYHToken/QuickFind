//
//  ViewController.m
//  QuickFind
//
//  Created by YanYH on 2017/8/11.
//  Copyright © 2017年 YanYH. All rights reserved.
//

#import "ViewController.h"
#import "QTreeRect.h"
#import "QTreeStare.h"
#import "ConfigManager.h"
#import "UIColor+Category.h"

@interface ViewController ()
@property(nonatomic, strong)UIScrollView *gameContainer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIScrollView
    self.gameContainer = [[UIScrollView alloc] init];
    self.gameContainer.frame = self.view.bounds; // frame中的size指UIScrollView的可视范围
    self.gameContainer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.gameContainer];
    int sheight = self.view.frame.size.height;
    int swidth = self.view.frame.size.width;
    int gwidth = swidth * 4;

    self.gameContainer.contentSize = CGSizeMake(gwidth, sheight);
    
    int twdith = 0;
    int nwidth = swidth;
    int nh = sheight;
    for (int i = 0; i < 10; i++) {
        if(twdith + nwidth > gwidth)
        {
            nwidth = gwidth - twdith;
        }
        QTree *tree;
        //区域均分的树结构
//        tree = [[QTree alloc] initWith:nwidth height:nh];
        //区域随机大小的树结构
        tree = [[QTreeStare alloc] initWith:nwidth height:nh prs:[ConfigManager sharedInstance].rectVec];
        //拼图item
        [self createView:tree.maps startX:twdith startY:0 color:@"FFFFFF"];
        //空白区域
        [self createView:tree.blank startX:twdith startY:0 color:@"7AC5CD"];
        twdith += nwidth;
        if(twdith >= gwidth){
            break;
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)createView:(NSArray *)maps startX:(int)startX startY:(int)startY color:(NSString *)color
{
//    NSLog(@"startX = %i", startX);
    for (QTreeRect *r in maps) {
        UIView *view = [self getView:r color:color];
        CGRect frame = view.frame;
        frame.origin = CGPointMake(view.frame.origin.x + startX, view.frame.origin.y + startY);
        view.frame = frame;
//        NSLog(@"frame %@", NSStringFromCGRect(frame));
        [self.gameContainer addSubview:view];
    }
}

- (UIView *)getView:(QTreeRect *)r color:(NSString *)color
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(r.x, r.y, r.width, r.height)];
    view.backgroundColor = [UIColor colorWithHexString:color withAlpha:0.7];
    view.layer.borderColor = [UIColor colorWithHexString:color].CGColor;
    view.layer.borderWidth = 1;
    return view;
}

@end
