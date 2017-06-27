//
//  UIViewAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by brant on 2017/6/19.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "UIViewAnimationViewController.h"


static const CGFloat kAnimationDuration = 2.0;

@interface UIViewAnimationViewController ()

@property (nonatomic, strong) UIView *aniView;  // 执行演示动画的view

@end

@implementation UIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.aniView];
}

- (IBAction)normalAnimation:(id)sender {
    [self blockAnimation];
    
//    [self startAnimation];
}

- (IBAction)springAnimationClicked:(id)sender {
    [self springAnimation];
}

- (IBAction)resetFrame:(id)sender {
    self.aniView.frame = CGRectMake(10, 80, 40, 40);
}

- (void)startAnimation {
    // 第一个参数：动画的标识
    // 第二个参数：附加参数，会发送给动画代理，一般设置为nil就可以了
    [UIView beginAnimations:@"test" context:nil];
    // 动画执行时间
    [UIView setAnimationDuration:kAnimationDuration];
    // 设置动画延迟执行时间，默认为0，一般不用设置
    [UIView setAnimationDelay:0];
    // 动画重复次数
    [UIView setAnimationRepeatCount:1];
    // 动画是否原路返回
    [UIView setAnimationRepeatAutoreverses:NO];
    
    // 要先设置这个代理，后面设置代理方法才会有效果
    [UIView setAnimationDelegate:self];
    // 这里的方法也可以是其它的任何方法,如果是这个标准的代理方法，可以不用设置，只设置代理就会执行这个方法
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    // 动画的时间曲线
    /*UIViewAnimationCurve的枚举值如下：
      UIViewAnimationCurveEaseInOut,//慢进慢出（默认值）
      UIViewAnimationCurveEaseIn,//慢进
      UIViewAnimationCurveEaseOut,//慢出
      UIViewAnimationCurveLinear//匀速
     */
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    // 要执行的view的变化
    self.aniView.backgroundColor = [UIColor purpleColor];
    self.aniView.frame = CGRectMake(200, 80, 100, 100);
    // 提交动画执行
    [UIView commitAnimations];
}

// 以block形式开始动画
- (void)blockAnimation {
    // iOS4以后有了block形式的动画，可以更方便的组织代码
    
    
    // 只设置动画时间，要执行的变化
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.aniView.backgroundColor = [UIColor purpleColor];
        self.aniView.frame = CGRectMake(200, 80, 100, 100);
    }];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
    } completion:^(BOOL finished) {
        // 动画执行完后的回调
    }];
    
    
    // options 可以设置多个。
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.aniView.backgroundColor = [UIColor purpleColor];
        self.aniView.frame = CGRectMake(200, 80, 100, 100);
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完了");
    }];
}

// iOS7 以后，有了带弹簧效果的动画api
- (void)springAnimation {
    [UIView animateWithDuration:kAnimationDuration // 动画持续时间
                          delay:0 // 动画延迟执行的时间
         usingSpringWithDamping:0.2 // 震动效果，范围0~1，数值越小震动效果越明显
          initialSpringVelocity:10 // 初始速度，数值越大初始速度越快
                        options:UIViewAnimationOptionCurveEaseIn // 动画的过渡效果
                     animations:^{
                         //执行的动画
                         self.aniView.backgroundColor = [UIColor purpleColor];
                         self.aniView.frame = CGRectMake(200, 80, 100, 100);
                     }
                     completion:^(BOOL finished) {
                         // 动画执行完后的回调
                     }];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    NSLog(@"Animation:%@ stoped", animationID);
}

#pragma mark - getters/setters

- (UIView *)aniView {
    if (!_aniView) {
        _aniView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, 40, 40)];
        _aniView.backgroundColor = [UIColor redColor];
    }
    
    return _aniView;
}

@end
