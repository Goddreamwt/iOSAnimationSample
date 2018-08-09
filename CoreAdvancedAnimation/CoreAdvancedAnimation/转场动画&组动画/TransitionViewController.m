//
//  TransitionViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()
@property(nonatomic,strong)NSArray * imgs;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic)NSInteger index;
@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _imgs = @[@"view0.jpg",@"view1.jpg",@"view2.jpg",@"view3.jpg"];
    self.imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 100    , 200)];
    self.imgView.image =[UIImage imageNamed:_imgs[0]];
    [self.view addSubview:self.imgView];
    
    [self test];
}

#pragma mark -组动画
-(void)test{
    //绘制贝塞尔曲线
    UIBezierPath *path =[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 500)];
    [path addCurveToPoint:CGPointMake(350, 500) controlPoint1:CGPointMake(170, 400) controlPoint2:CGPointMake(220, 300) ];
    //添加到layer
    CAShapeLayer * shapeLayer =[CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor =[UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    //添加灰色方块
    CALayer * colorLayer =[CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 30, 30);
    colorLayer.position = CGPointMake(50, 500);
    colorLayer.backgroundColor =[UIColor grayColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    
    //添加关键帧动画
    CAKeyframeAnimation * anim=[CAKeyframeAnimation animation];
    anim.path = path.CGPath;
    anim.keyPath =@"position";
//    anim.duration = 3;
//    [colorLayer addAnimation:anim forKey:nil];
    
    //添加基础动画-动态改变颜色
    CGFloat red =arc4random() /(CGFloat)INT_MAX;
    CGFloat green =arc4random() /(CGFloat)INT_MAX;
    CGFloat blue =arc4random() /(CGFloat)INT_MAX;
    CABasicAnimation * basicAnim =[CABasicAnimation animation];
    UIColor * color =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    basicAnim.keyPath =@"backgroundColor";
    basicAnim.toValue = (id)color.CGColor;
//    basicAnim.duration = 3;
//    [colorLayer addAnimation:basicAnim forKey:nil];
    
    //改变大小
    CABasicAnimation * anim1 =[CABasicAnimation animation];
    anim1.keyPath = @"transform.scale";
    anim1.toValue =@.2;
//    anim1.duration = 3;
//    [colorLayer addAnimation:anim1 forKey:nil];
    
    //使用动画组
    CAAnimationGroup * group =[CAAnimationGroup animation];
    group.animations = @[anim1,anim,basicAnim];
    group.duration = 3;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [colorLayer addAnimation:group forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _index++;
    if (_index>3) {
        _index =0;
    }
    NSString * imgName = _imgs[_index];
    _imgView.image =[UIImage imageNamed:imgName];
    //转场动画:默认淡入淡出
    CATransition *anim =[CATransition animation];
//    anim.type =@"suckEffect";//从父视图的左上角收缩
    anim.startProgress =.5;//从动画进程的一半开始
    anim.startProgress =.8;//从动画进程的百分之八十结束
    [_imgView.layer addAnimation:anim forKey:nil];
    
    [self test];
}


@end
