//
//  CATransitionViewController.m
//  CoreAnimationDemo
//
//  Created by brant on 2017/6/22.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController ()

@property (nonatomic, strong) UIView *aniView;

@property (nonatomic) BOOL isRed;

@property (nonatomic) int index;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isRed = YES;
    _index = 0;
    
    [self.view addSubview:self.aniView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStyleDone target:self action:@selector(startAnimation)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation {
    
    /*
     * 基本效果
     
     - kCATransitionFade        渐入渐出效果
     - kCATransitionMoveIn      移入效果
     - kCATransitionPush        推入效果
     - kCATransitionReveal      截开效果
     
     * 私有API(可安全使用):
     
     - cube                   方块
     - suckEffect             三角
     - rippleEffect           水波
     - pageCurl               上翻页
     - pageUnCurl             下翻页
     - oglFlip                上下翻转
     - cameralrisHollowOpen      镜头快门开
     - cameralrisHollowClose     镜头快门关
     */
    
    NSArray *aniKeys = @[@"fade", @"movein", @"push", @"reveal", @"cube", @"oglFlip", @"suckEffect", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"cameralIrisHollowOpen", @"cameraIrisHollowClose"];
    
    
    
    self.aniView.backgroundColor = self.isRed ? [UIColor blueColor] : [UIColor redColor];
    self.isRed = !self.isRed;
    
    CATransition *ani = [CATransition animation];
    ani.duration = 1;
    ani.type = aniKeys[self.index];
    ani.subtype = kCATransitionFromBottom;
    ani.removedOnCompletion = YES;
    
    [self.aniView.layer addAnimation:ani forKey:@"ani"];
    
    self.index++;
    if (self.index >= aniKeys.count) {
        self.index = 0;
    }
}

#pragma mark - setters/getters

- (UIView *)aniView {
    if (!_aniView) {
        _aniView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0 - 100, 100, 200, 200)];
        _aniView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
        _aniView.backgroundColor = [UIColor redColor];
        _aniView.layer.masksToBounds = YES;
    }
    
    return _aniView;
}


@end
