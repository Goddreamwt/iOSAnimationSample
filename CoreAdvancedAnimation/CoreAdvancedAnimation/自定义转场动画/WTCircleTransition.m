//
//  WTCircleTransition.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//
/*
 1.使用贝塞尔画2个圆圈(重点:中心点，半径)
 2.做动画
 */
#import "WTCircleTransition.h"
#import "CustomTransitionViewController.h"
#import "SecondViewController.h"

@interface WTCircleTransition()<CAAnimationDelegate>

@property(nonatomic,strong)id<UIViewControllerContextTransitioning> context;
@end
@implementation WTCircleTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .8f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1.持有transitionContext上下文
    _context = transitionContext;
    //2.获取view的容器
    UIView *containerView = [transitionContext containerView];
    //3.初始化toVc,把toVc的view添加到容器view
    UIViewController *toVc =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //4.添加动画
    /*
     拆分动画
     4.1 2个圆(大小圆的中心点一致)
     4.2 贝塞尔
     4.3 蒙版
     */
    UIButton *btn;
    CustomTransitionViewController * VC1;
    SecondViewController * VC2;
    if (_isPush) {
        VC1 =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        VC2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = VC1.customTransitionBtn;
    }else{
        VC2 =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        VC1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = VC2.backBtn;
    }
     [containerView addSubview:VC1.view];
     [containerView addSubview:VC2.view];
    //5.画出小圆
    UIBezierPath *smallPath =[UIBezierPath bezierPathWithOvalInRect:btn.frame];//内切圆
    CGPoint centerP;
    centerP = btn.center;
    //6.求大圆半径 勾股定理
    CGFloat radius;
    CGFloat y = CGRectGetHeight(toVc.view.bounds)-CGRectGetMaxY(btn.frame)+CGRectGetHeight(btn.bounds)/2;
    CGFloat x = CGRectGetWidth(toVc.view.bounds)-CGRectGetMaxX(btn.frame)+CGRectGetWidth(btn.bounds)/2;
    if (btn.frame.origin.x >CGRectGetWidth(toVc.view.bounds)/2) {
        //位于1，4象限
        if (CGRectGetMaxY(btn.frame)< CGRectGetHeight(toVc.view.bounds)/2) {
            //第一象限
            //sqrtf(求平方根)
            radius = sqrtf(btn.center.x *btn.center.x +y*y);
        }else{
            //第四象限
            radius = sqrtf(btn.center.x * btn.center.x + btn.center.y*btn.center.y);
        }
    }else{
        if (CGRectGetMaxY(btn.frame)<CGRectGetHeight(toVc.view.frame)) {
            //第二象限
            radius = sqrtf(x*x+y*y);
        }else{
            //第三象限
            radius = sqrtf(x*x + btn.center.y*btn.center.y);
        }
    }
    //7.画大圆
    UIBezierPath * bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    //8.
    CAShapeLayer *shapeLayer =[CAShapeLayer layer];
    
    if (_isPush) {
        shapeLayer.path = bigPath.CGPath;
    } else{
        shapeLayer.path = smallPath.CGPath;
    }
    
    //9.添加蒙版
//    [toVc.view.layer addSublayer:shapeLayer];
    UIViewController *VC;
    if (_isPush) {
        VC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }else{
        VC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    VC.view.layer.mask = shapeLayer;
    
    //10.给layer添加动画
    CABasicAnimation *anim =[CABasicAnimation animationWithKeyPath:@"path"];
    if (_isPush) {
         anim.fromValue = (id)smallPath.CGPath;
    }else{
         anim.fromValue = (id)bigPath.CGPath;
    }
    //重要，动画时间要和转场时间一致
    anim.duration = [self transitionDuration:transitionContext];
    anim.delegate = self;
    [shapeLayer addAnimation:anim forKey:nil];
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
    //去掉蒙版
    if (_isPush) {
        UIViewController * toVc =[_context viewControllerForKey:UITransitionContextToViewControllerKey];
        toVc.view.layer.mask = nil;
    }else{
        UIViewController * toVc =[_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        toVc.view.layer.mask = nil;
    }
  
}
@end
