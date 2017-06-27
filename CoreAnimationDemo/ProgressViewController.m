//
//  ProgressViewController.m
//  CoreAnimationDemo
//
//  Created by brant on 2017/6/19.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer:self.progressLayer];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStyleDone target:self action:@selector(progressAnimation)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)progressAnimation {
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.fromValue = @(0);
    ani.toValue = @(0.8);
    ani.duration = 1.0;
    
    // 动画执行完后，保持执行完的状态
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    
    [self.progressLayer addAnimation:ani forKey:@"progressAnimation"];
}

#pragma mark - setters/getters

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = CGRectMake(self.view.frame.size.width / 2.0 - 75, 150, 150, 150);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_progressLayer.bounds];
        _progressLayer.path = path.CGPath;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor orangeColor].CGColor;
        _progressLayer.lineWidth = 8.0;
        // 设置线条转折的地方圆角
//        _progressLayer.lineJoin = kCALineJoinRound;
        // 设置线条的两端圆角
        _progressLayer.lineCap = kCALineCapRound;
    }
    
    return _progressLayer;
}

@end
