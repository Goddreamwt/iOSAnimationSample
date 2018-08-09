//
//  LinkViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 mac. All rights reserved.
//
/*
 1.图片变了
 2.大小变了
 3.爆炸效果(CAEmitterLayer 粒子动画)
 */
#import "LinkViewController.h"

@interface LinkViewController ()
@property(nonatomic,strong)UIButton * linkBtn;
@property(nonatomic,strong)CAEmitterLayer * emitterLayer;
@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    _linkBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -20, self.view.frame.size.height/2-20, 40, 40)];
    [_linkBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [_linkBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [_linkBtn addTarget:self action:@selector(linkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_linkBtn];
    
    [self explosion];
}
-(void)linkBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    //关键帧动画 改变大小
    CAKeyframeAnimation * anim =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (btn.selected) {
        anim.values = @[@1.5,@.8,@1,@1.2,@1];
        anim.duration = .6;
        [self addExplosionAnim];
    }else{
        anim.values = @[@.8,@1.0];
        anim.duration = .4;
    }
    [_linkBtn.layer addAnimation:anim forKey:nil];
}
-(void)addExplosionAnim{
    _emitterLayer.beginTime = CACurrentMediaTime();//同一时间出发
    _emitterLayer.birthRate = 1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_emitterLayer.birthRate = 0;
    });
}

- (void)explosion{
    _emitterLayer = [CAEmitterLayer layer];
    //CAEmitterCell 相当于粒子动画中的一个粒子，比如烟花动画，cell就是每一朵烟花
    CAEmitterCell * cell =[[CAEmitterCell alloc]init];
    cell.name = @"explosionCell";//设置标识
    cell.lifetime = .7;//存活时间
    cell.birthRate = 4000;//数量，一秒钟产生4000个
    cell.velocity = 50; //初始化速度
    cell.velocityRange = 15;//速度范围
    cell.scale =.03;//缩小比例
    cell.scaleRange =.02;//比例范围
    cell.contents =(id)[UIImage imageNamed:@"sparkle"].CGImage;//设置图片
    
    _emitterLayer.name = @"explosionLayer";
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;//设置形状
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;//设置模式,从哪个位置发出，从发射器边缘发射
    _emitterLayer.emitterSize = CGSizeMake(25, 0);//设置大小
    _emitterLayer.emitterCells = @[cell];//可以设置多种cell
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;//渲染模式，越早的在上面
    _emitterLayer.masksToBounds = NO;//为了防止它在边缘消失
    _emitterLayer.birthRate = 0;//整个例子的数量
    _emitterLayer.zPosition =0;//层级关系越小的在上面
    _emitterLayer.position = CGPointMake(CGRectGetWidth(_linkBtn.bounds)/2, CGRectGetHeight(_linkBtn.bounds)/2);//设置位置
    [_linkBtn.layer addSublayer:_emitterLayer];
}


@end
