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
    
    [self snowflake];
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

/*雪花效果*/
-(void)snowflake{
    UIImageView * bgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height)];
    bgview.image =[UIImage imageNamed:@"bg-snowy"];
    [self.view addSubview:bgview];
    //设置layer的frame
    CAEmitterLayer *emitter = [CAEmitterLayer new];
    CGRect frame = CGRectMake(0, -70, self.view.frame.size.width, 0);
    emitter.frame = frame;
    [self.view.layer addSublayer:emitter];
    
    //发射体的形状通常会影响到新粒子的产生，但也会影响到它们的z位置，在你创造3d粒子系统的情况下。
    emitter.emitterShape = kCAEmitterLayerCuboid;
    
    //    Point shape
    //    一个发射器形状的kCAEmitterLayerPoint使所有的粒子在同一点产生:发射器的位置。这是一个很好的选择，包括火花或烟花:
    //    举例来说，你可以通过在同一点上创建所有的粒子并在它们消失之前让它们飞向不同的方向，从而产生火花效应。
    
    //Line shape
    //    一个发射器形状的kCAEmitterLayerLine在发射器框架的顶部创建了所有的粒子。这是一个对瀑布效应有用的发射器形状;水颗粒出现在瀑布的顶部边缘，像这样瀑布向下。
    
    //    Adding an emitter frame
    //结合形状、位置和大小属性定义了发射器框架。将发射器的位置设置为该层的中心，并设置发射器大小等于该层的大小。
    emitter.emitterPosition = CGPointMake(frame.size.width/2, frame.size.height/2);
    emitter.emitterSize = frame.size;
    
    CAEmitterCell *emitterCell = [[CAEmitterCell alloc] init];
    emitterCell.contents = (__bridge id)[UIImage imageNamed:@"snowflake1"].CGImage;
    emitterCell.birthRate = 20;  //每秒创建20个雪花
    emitterCell.lifetime = 5.0;  //在屏幕上保持3.5秒
    emitterCell.lifetimeRange = 1.5; //2.5-5
    //添加颗粒模板到发射器
    emitter.emitterCells = @[emitterCell];
    
    emitterCell.yAcceleration = 70.0;
    emitterCell.xAcceleration = 10.0;
    emitterCell.velocity = 0.1;
    emitterCell.emissionLongitude = (CGFloat)-M_PI;
    emitterCell.velocityRange = 200.0; //带有负初始速度的粒子根本不会飞起来，而是浮起来
    emitterCell.emissionRange = -(CGFloat)M_PI_2;
    emitterCell.color = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
    
    //    emitterCell.redRange = 0.3;
    //    emitterCell.greenRange = 0.3;
    //    emitterCell.blueRange = 0.3;
    emitterCell.redRange = 0.1;
    emitterCell.greenRange = 0.1;
    emitterCell.blueRange = 0.1;
    
    emitterCell.scale = 0.8;
    emitterCell.scaleRange = 0.8;
    
    emitterCell.scaleSpeed = -0.15;
    
    emitterCell.alphaRange = 0.75; // 0.25-1.0
    emitterCell.alphaSpeed = -0.15; //逐渐消逝
}
@end
