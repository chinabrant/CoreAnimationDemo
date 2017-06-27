//
//  KeyFrameAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by brant on 2017/6/19.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"

@interface KeyFrameAnimationViewController ()

@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, strong) UIButton *btn1;

@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;


@end

// 只要给动画指定几个关键的帧，其它的动画状态都会自动生成。values存放关键帧
// 也可以指定path,path只对position起作用
@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.menuButton];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
}

#pragma mark - events

// 简易path menu
- (void)menuClicked {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.menuButton.center.x - 40, self.menuButton.center.y - 40, 80, 80)];
    
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = path.CGPath;
    ani.duration = 2.0;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    
    self.btn1.hidden = NO;
    [self.btn1.layer addAnimation:ani forKey:@"xx"];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:self.menuButton.center radius:40 startAngle:0 endAngle:90.0 * M_PI / 180.0 clockwise:YES];
    CAKeyframeAnimation *ani2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani2.path = path2.CGPath;
    ani2.duration = 0.5;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani2.removedOnCompletion = NO;
    ani2.fillMode = kCAFillModeForwards;
    
    self.btn2.hidden = NO;
    [self.btn2.layer addAnimation:ani2 forKey:@""];
    
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:self.menuButton.center radius:40 startAngle:0 endAngle:180.0 * M_PI / 180.0 clockwise:YES];
    CAKeyframeAnimation *ani3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani3.path = path3.CGPath;
    ani3.duration = 1;
    ani3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani3.removedOnCompletion = NO;
    ani3.fillMode = kCAFillModeForwards;
    
    self.btn3.hidden = NO;
    [self.btn3.layer addAnimation:ani3 forKey:@""];
    
    UIBezierPath *path4 = [UIBezierPath bezierPathWithArcCenter:self.menuButton.center radius:40 startAngle:0 endAngle:270.0 * M_PI / 180.0 clockwise:YES];
    CAKeyframeAnimation *ani4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani4.path = path4.CGPath;
    ani4.duration = 1.5;
    ani4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani4.removedOnCompletion = NO;
    ani4.fillMode = kCAFillModeForwards;
    
    self.btn4.hidden = NO;
    [self.btn4.layer addAnimation:ani4 forKey:@""];
}



#pragma mark - setters/getters

- (UIButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0 - 20, self.view.frame.size.height - 64 - 90, 40, 40)];
        _menuButton.layer.cornerRadius = 20.0;
        _menuButton.layer.borderColor = [UIColor redColor].CGColor;
        _menuButton.layer.borderWidth = 1.0;
        [_menuButton setTitle:@"+" forState:UIControlStateNormal];
        [_menuButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_menuButton addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuButton;
}

- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_btn1 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
//        [_btn1 sizeToFit];
        _btn1.hidden = YES;
    }
    
    return _btn1;
}

- (UIButton *)btn2 {
    if (!_btn2) {
        _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_btn2 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        //        [_btn1 sizeToFit];
        _btn2.hidden = YES;
    }
    
    return _btn2;
}

- (UIButton *)btn3 {
    if (!_btn3) {
        _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_btn3 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        //        [_btn1 sizeToFit];
        _btn3.hidden = YES;
    }
    
    return _btn3;
}

- (UIButton *)btn4 {
    if (!_btn4) {
        _btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_btn4 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        //        [_btn1 sizeToFit];
        _btn4.hidden = YES;
    }
    
    return _btn4;
}

@end
