//
//  BubbleDragViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//
/*
 拆分：
  1.2个圆，一个固定，一个可移动
  2.贝塞尔（重点：求关键点）
  3.固定圆比例缩小
  4.拖拽到一定距离的时候，需要断开
  5.断开后有个圆的反弹效果
 */
#import "BubbleDragViewController.h"

@interface BubbleDragViewController ()
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)CAShapeLayer * shapeLayer;
@property (nonatomic, assign) CGPoint oldViewCenter;
@property (nonatomic, assign) CGRect oldViewFrame;
@property (nonatomic, assign) CGFloat r1;
@end

@implementation BubbleDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self setup];
}
-(void)setup{
    //添加view1
    _view1 =[[UIView alloc]initWithFrame:CGRectMake(36, CGRectGetHeight(self.view.bounds)-66, 40, 40)];
    _view1.layer.masksToBounds = YES;
    _view1.layer.cornerRadius = 20;
    _view1.backgroundColor =[UIColor redColor];
    [self.view addSubview:_view1];
    
    //添加view2
    _view2 =[[UIView alloc]initWithFrame:_view1.frame];
    _view2.layer.masksToBounds = YES;
    _view2.layer.cornerRadius = 20;
    _view2.backgroundColor =[UIColor redColor];
    [self.view addSubview:_view2];
    
    //添加label
    UILabel *numL= [[UILabel alloc]initWithFrame:_view2.bounds];
    numL.text = @"99";
    numL.textAlignment = NSTextAlignmentCenter;
    numL.textColor =[UIColor whiteColor];
    [_view2 addSubview:numL];
    
    //添加手势
    UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAuction:)];
    [_view2 addGestureRecognizer:pan];
    
    //初始化layer
    _shapeLayer =[CAShapeLayer layer];
    _oldViewFrame =_view1.frame;
    _oldViewCenter = _view1.center;
    _r1 = CGRectGetWidth(_view1.frame)/2;
}
-(void)panAuction:(UIPanGestureRecognizer *)ges{
    if (ges.state ==UIGestureRecognizerStateChanged) {
        //1.view2跟着手势移动
        _view2.center = [ges locationInView:self.view];
        if (_r1<4) {
            _view1.hidden = YES;
            [_shapeLayer removeFromSuperlayer];
        }
        //2.计算6个关键点，画贝塞尔曲线
        [self caculP];
        
    }else if(ges.state ==UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateFailed){
        //手势结束或者取消或者失败时,view2恢复初始位置，并增加弹簧动画
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self->_shapeLayer removeFromSuperlayer];
            self->_view2.center = self->_oldViewCenter;
        } completion:^(BOOL finished) {
            //在动画结束后恢复view1最开始的状态
            self->_view1.hidden = NO;
            self->_view1.frame = self->_oldViewFrame;
            self->_r1 = self->_oldViewFrame.size.width/2;
            self->_view1.layer.cornerRadius = self->_r1;
        }];
    }
}
-(void)caculP{
    //1.初始化中心点
    CGPoint center = _view1.center;
    CGPoint center2 = _view2.center;
    //2.求出2个中心点的距离(勾股定理)
    CGFloat dis = sqrtf((center.x -center2.x)*(center.x -center2.x)+(center.y -center2.y)*(center.y -center2.y));
    //3.计算正弦余弦
    CGFloat sin = (center2.x - center.x) / dis;
    CGFloat cos = (center.y - center2.y)/dis;
    //4.半径
    CGFloat r1 = CGRectGetWidth(_oldViewFrame)/2- dis/20;
    CGFloat r2 = CGRectGetWidth(_view2.bounds)/2;
    _r1 = r1;
    //5.计算6个关键点
    CGPoint pA = CGPointMake(center.x - r1*cos, center.y -r1*sin);
    CGPoint pB = CGPointMake(center.x + r1* cos, center.y+r1*sin);
    CGPoint pC = CGPointMake(center2.x + r2*cos, center2.y + r2*sin);
    CGPoint pD = CGPointMake(center2.x - r2*cos, center2.y -r2*sin);
    CGPoint pO = CGPointMake(pA.x + dis/2*sin, pA.y - dis/2*cos);
    CGPoint pP = CGPointMake(pB.x +dis/2*sin, pB.y - dis/2*cos);
    
    //6.画赛贝尔曲线
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addQuadCurveToPoint:pD controlPoint:pO];
    [path addLineToPoint:pC];
    [path addQuadCurveToPoint:pB controlPoint:pP];
    [path closePath];

    if (!_view1.hidden) {
        //7.把路径添加到layer上
        _shapeLayer.path = path.CGPath;
        _shapeLayer.fillColor =[UIColor redColor].CGColor;
        
        //8.把layer添加在view.layer上面 在_view2.layer的下面
        [self.view.layer insertSublayer:_shapeLayer below:_view2.layer];
    }
      //9.重新计算view1的位置
    _view1.center = _oldViewCenter;
    _view1.bounds = CGRectMake(0, 0, r1* 2, r1*2);
    _view1.layer.cornerRadius = r1;
}



@end
