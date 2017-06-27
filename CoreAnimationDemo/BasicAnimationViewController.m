//
//  BasicAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by brant on 2017/6/19.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()

@property (nonatomic, strong) UIView *aniView;

@property (nonatomic, strong) UIButton *menuButton;

@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}



- (void)setupViews {
    
    CGFloat wid = self.view.frame.size.width / 8.0;
    CGFloat y = 150;
    CGFloat y1 = y + 150;
    CGFloat y2 = y1 + 150;
    
    
    [self.view addSubview:self.aniView];
    
    [self.view addSubview:self.menuButton];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, y)];
    
    [path addLineToPoint:CGPointMake(wid * 2.0, y)];
    [path addLineToPoint:CGPointMake(wid * 2.0, y2)];
    [path addLineToPoint:CGPointMake(wid * 4.0, y2)];
    [path addLineToPoint:CGPointMake(wid * 4.0, y1)];
    [path addLineToPoint:CGPointMake(wid * 6.0, y1)];
    [path addLineToPoint:CGPointMake(wid * 6.0, y)];
    [path addLineToPoint:CGPointMake(wid * 8.0, y)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor purpleColor].CGColor;
    
    [self.view.layer addSublayer:layer];
}

- (void)startAnimation {
    CGFloat wid = self.view.frame.size.width / 8.0;
    CGFloat y = 150;
    CGFloat y1 = y + 150;
    CGFloat y2 = y1 + 150;
    
    // 下面一系列的平移也可以用一个keyframe动画， 更简洁
    // 平移
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, y)];
    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 2.0, y)];
    ani.duration = 1.0;
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani2.fromValue = [NSValue valueWithCGPoint:CGPointMake(wid * 2.0, y)];  // 开始位置，CGPoint要放到NSValue中
    ani2.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 2.0, y2)];   // 结束位置
    ani2.beginTime = ani.beginTime + ani.duration;  // 设置动画的开始时间，在上一个动画执行完后再执行
    ani2.duration = 1.0;    // 设置动画的持续时间
    
    CABasicAnimation *ani3 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani3.fromValue = [NSValue valueWithCGPoint:CGPointMake(wid * 2.0, y2)];
    ani3.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 4.0, y2)];
    ani3.duration = 1.0;
    ani3.beginTime = ani2.beginTime + ani2.duration;
    
    CABasicAnimation *ani4 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani4.fromValue = [NSValue valueWithCGPoint:CGPointMake(wid * 4.0, y2)];
    ani4.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 4.0, y1)];
    ani4.duration = 1.0;
    ani4.beginTime = ani3.beginTime + ani3.duration;
    
    CABasicAnimation *ani5 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani5.fromValue = [NSValue valueWithCGPoint:CGPointMake(wid * 4.0, y1)];
    ani5.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 6.0, y1)];
    ani5.duration = 1.0;
    ani5.beginTime = ani4.beginTime + ani4.duration;
    
    CABasicAnimation *ani6 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani6.fromValue = [NSValue valueWithCGPoint:CGPointMake(wid * 6.0, y1)];
    ani6.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 6.0, y)];
    ani6.duration = 1.0;
    ani6.beginTime = ani5.beginTime + ani5.duration;
    
    CABasicAnimation *ani7 = [CABasicAnimation animationWithKeyPath:@"position"];
    ani7.fromValue = [NSValue valueWithCGPoint:CGPointMake(wid * 6.0, y)];
    ani7.toValue = [NSValue valueWithCGPoint:CGPointMake(wid * 8.0, y)];
    ani7.duration = 1.0;
    ani7.beginTime = ani6.beginTime + ani6.duration;
    
    // 透明度
    CABasicAnimation *opcaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opcaAni.fromValue = @(1);
    opcaAni.toValue = @(0.3);
    opcaAni.autoreverses = YES; // 自动回到原始状态
    opcaAni.duration = 3.5;
    
    // 圆角
    CABasicAnimation *cornerAni = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAni.fromValue = @(0);
    cornerAni.toValue = @(40);
    cornerAni.autoreverses = YES;
    cornerAni.duration = 3.5;
    
    // 背景色
    CABasicAnimation *colorAni = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAni.fromValue = (__bridge id) ([UIColor redColor].CGColor);
    colorAni.toValue = (__bridge id) [UIColor blackColor].CGColor;
    colorAni.autoreverses = YES;
    colorAni.duration = 3.5;
    
    // 缩放
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.fromValue = @(1);
    scaleAni.toValue = @(0.2);
    scaleAni.autoreverses = YES;
    scaleAni.duration = 3.5;
    
    // 全放到一个动画组里
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[ani, ani2, ani3, ani4, ani5, ani6, ani7, opcaAni, cornerAni, colorAni, scaleAni];
    // 动画组的时间，要是所有一个时间线上的动画时间总长
    group.duration = ani.duration + ani2.duration + ani3.duration + ani4.duration + ani5.duration + ani6.duration + ani7.duration;
    
    
    
    
    [self.aniView.layer addAnimation:group forKey:@"rotation"];
}

#pragma mark - events

- (void)menuClicked {
    
    [self startAnimation];
    
}



#pragma mark - setters/getters

- (UIView *)aniView {
    if (!_aniView) {
        _aniView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _aniView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
        _aniView.backgroundColor = [UIColor redColor];
        _aniView.layer.masksToBounds = YES;
    }
    
    return _aniView;
}

- (UIButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0 - 20, self.view.frame.size.height - 64 - 90, 40, 40)];
        _menuButton.layer.cornerRadius = 20.0;
        _menuButton.layer.borderColor = [UIColor redColor].CGColor;
        _menuButton.layer.borderWidth = 1.0;
        [_menuButton setTitle:@"开始" forState:UIControlStateNormal];
        [_menuButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_menuButton addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuButton;
}

- (UIView *)line {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}


@end
