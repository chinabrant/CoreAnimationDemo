//
//  EmitterViewController.m
//  CoreAnimationDemo
//
//  Created by brant on 2017/6/6.
//  Copyright © 2017年 brant. All rights reserved.
//

#import "EmitterViewController.h"

@interface EmitterViewController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@property (nonatomic, strong) CAEmitterCell *emitterCell;

@end

@implementation EmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)likeButtonClicked:(id)sender {
    UIButton *btn = sender;
    self.emitterLayer.emitterCells = @[[self emitterCell]];
    [btn.layer addSublayer:self.emitterLayer];
}

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        
        _emitterLayer.name = @"emitterLayer";
        _emitterLayer.emitterShape = kCAEmitterLayerCircle;
        _emitterLayer.emitterMode = kCAEmitterLayerOutline;
        _emitterLayer.emitterSize = CGSizeMake(32, 0);
        _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
        _emitterLayer.masksToBounds = NO;
        _emitterLayer.emitterPosition = CGPointMake(32, 32);
        _emitterLayer.seed = 1366128504;
        
    }
    
    return _emitterLayer;
}

- (CAEmitterCell *)emitterCell {
    if (!_emitterCell) {
        _emitterCell = [CAEmitterCell emitterCell];
        
        _emitterCell.name = @"explosion";
        _emitterCell.alphaRange = 0.20;
        _emitterCell.alphaSpeed = -1.0;
        
        _emitterCell.lifetime = 0.7;
        _emitterCell.lifetimeRange = 0.3;
        _emitterCell.birthRate = 0;
        _emitterCell.velocity = 40.00;
        _emitterCell.velocityRange = 10.00;
        
        _emitterCell.contents = (__bridge id) [UIImage imageNamed:@"like"].CGImage;
//        _emitterCell.yAcceleration = -10.f;     // 粒子的初始加速度
//        _emitterCell.xAcceleration = -110.f;
        _emitterCell.birthRate = 20.f;           // 每秒生成粒子的个数
//        _emitterCell.lifetime = 2.f;            // 粒子存活时间
//        _emitterCell.alphaSpeed = -0.3f;        // 粒子消逝的速度
//        _emitterCell.velocity = 30.f;           // 粒子运动的速度均值
//        _emitterCell.velocityRange = 30.f;      // 粒子运动的速度扰动范围
//        _emitterCell.emissionRange = M_PI * 2; // 粒子发射角度, 这里是一个扇形.
        _emitterLayer.scale = 0.2;
        
    }
    
    return _emitterCell;
}

@end
