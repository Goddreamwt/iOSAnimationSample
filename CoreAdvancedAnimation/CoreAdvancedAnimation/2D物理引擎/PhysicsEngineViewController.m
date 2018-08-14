//
//  PhysicsEngineViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 mac. All rights reserved.
//
/*
 1.添加行为（绑定view）
 2.把行为添加在容器中（绑定view的父view）
 */
#import "PhysicsEngineViewController.h"

@interface PhysicsEngineViewController ()
@property(nonatomic,strong)UIDynamicAnimator * animator;
@property(nonatomic,strong)UIDynamicAnimator * animator2;
@property(nonatomic,strong)UIAttachmentBehavior * attachmentBehavior;
@property(nonatomic,strong)UIView * redView;
@property(nonatomic,strong)UIView * greenView;
@property(nonatomic,strong)UIView * yellowView;
@end

@implementation PhysicsEngineViewController
//懒加载
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        // 创建一个物理仿真器
        //容器（里面放一些行为）
        /*
         ReferenceView:关联的view
         */
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _redView =[[UIView alloc]initWithFrame:CGRectMake(100, 200, 50, 50)];
    _redView.backgroundColor =[UIColor redColor];
    _redView.layer.masksToBounds = YES;
    _redView.layer.cornerRadius = 25;
    [self.view addSubview:_redView];
    
    _greenView =[[UIView alloc]initWithFrame:CGRectMake(100, 400, 100, 40)];
    _greenView.backgroundColor =[UIColor greenColor];
    [self.view addSubview:_greenView];
    
    _yellowView =[[UIView alloc]initWithFrame:CGRectMake(200, 500, 30, 30)];
    _yellowView.backgroundColor =[UIColor yellowColor];

    [self.view addSubview:_yellowView];
    
    [self animator];
    _animator2 = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //自由落体行为
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]initWithItems:@[_redView,_greenView,_yellowView]];
    //重力行为有一个属性是重力加速度，设置越大速度增长越快。默认是1
    gravity.magnitude = 2;
    //添加到容器
    [_animator addBehavior:gravity];
    
    
    //碰撞行为
    UICollisionBehavior *collision =[[UICollisionBehavior alloc]initWithItems:@[_redView,_yellowView,_greenView]];
    //设置边缘（父View的bounds）
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //也可以自己写边缘
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0,150, self.view.frame.size.width, self.view.frame.size.width)];
    CAShapeLayer * shapeLayer =[CAShapeLayer layer];
    shapeLayer.path =path.CGPath;
    shapeLayer.strokeColor =[UIColor redColor].CGColor;//画笔颜色
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = nil;//填充颜色
    [self.view.layer addSublayer:shapeLayer];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    [_animator addBehavior:collision];
    
    //模拟捕捉行为 UISnapBehavior
    //捕捉行为需要在创建时就给与一个点
    //捕捉行为有一个防震系数属性，设置的越大，振幅就越小
    CGPoint point = CGPointMake(100, 400);
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:_greenView snapToPoint:point];
    snap.damping = 1;
    [_animator addBehavior:snap];
    
    //其他行为的拓展
    UIDynamicItemBehavior *itemBehavior =[[UIDynamicItemBehavior alloc]initWithItems:@[_redView]];
    /*
     elasticity 弹性系数
     friction   摩擦系数
     density    密度
     resistance 抵抗性
     angularResistance 角度阻力
     charge     冲击
     anchored   锚定
     allowsRotation 允许旋转
     */
    itemBehavior.elasticity =.6;//弹性系数
    
    [_animator addBehavior:itemBehavior];
    
    //添加手势
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAuction:)];
    [_redView addGestureRecognizer:pan];
}
-(void)panAuction:(UIPanGestureRecognizer *)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        UIOffset offset = UIOffsetMake(-10, -10);
        /*
         offsetFromCenter:偏离中心幅度
         attachedToAnchor:附加到锚点 手势点击的位置
         */
        _attachmentBehavior =[[UIAttachmentBehavior alloc]initWithItem:_redView offsetFromCenter:offset attachedToAnchor:[ges locationInView:self.view]];
        [_animator addBehavior:_attachmentBehavior];
    }else if (ges.state == UIGestureRecognizerStateChanged){
        [_attachmentBehavior setAnchorPoint:[ges locationInView:self.view]];//设置锚点
    }else if (ges.state ==UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateFailed || ges.state == UIGestureRecognizerStateCancelled){
        [_animator removeBehavior:_attachmentBehavior];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获得手指对应的触摸对象
    UITouch *touch = [touches anyObject];
    
    // 2.获得触摸点
    CGPoint point = [touch locationInView:self.view];
    
    // 3.创建捕捉行为
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:_yellowView snapToPoint:point];
    // 防震系数，damping越大，振幅越小
    snap.damping = 1;
    
    // 4.清空之前的并再次开始
 
    [_animator2 removeAllBehaviors];
    [_animator2 addBehavior:snap];
}
@end
