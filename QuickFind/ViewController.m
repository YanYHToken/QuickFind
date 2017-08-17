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

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *gameContainer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIScrollView
    self.gameContainer = [[UIScrollView alloc] init];
    self.gameContainer.frame = self.view.bounds; // frame中的size指UIScrollView的可视范围
    self.gameContainer.delegate = self;
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
        [self createMapsView:tree.maps startX:twdith];
        //空白区域
        [self createBlanksView:tree.blank startX:twdith];
        twdith += nwidth;
        if(twdith >= gwidth){
            break;
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)createMapsView:(NSArray *)maps startX:(int)startX
{
    int startY = 0;
    for (QTreeRect *r in maps)
    {
        MapView *mapView = [[MapView alloc] initWithFrame:CGRectMake(r.x + startX, r.y + startY, r.width, r.height)];
        mapView.rect = r;
        [self.gameContainer addSubview:mapView];
    }
}

- (void)createBlanksView:(NSArray *)maps startX:(int)startX
{
    int startY = 0;
    for (QTreeRect *r in maps)
    {
        BlankView *blankView = [[BlankView alloc] initWithFrame:CGRectMake(r.x + startX, r.y + startY, r.width, r.height)];
        [self.gameContainer addSubview:blankView];
    }
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    return;
    for (UIView *viewToShake in scrollView.subviews)
    {
        if(viewToShake.frame.origin.x > ABS(scrollView.contentOffset.x) &&
           viewToShake.frame.origin.x < ABS(scrollView.contentOffset.x) + self.view.frame.size.width)
        {
            [self check:viewToShake];
        }
    }
}

-(void)check:(UIView *)viewToShake
{
    CGFloat t = 0.1;
    CGAffineTransform oriTrans = viewToShake.transform;
    CGAffineTransform translateRight  = CGAffineTransformRotate(viewToShake.transform, t);
    CGAffineTransform translateLeft = CGAffineTransformRotate(viewToShake.transform, -t);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:4];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform = oriTrans;
            } completion:NULL];
        }
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
